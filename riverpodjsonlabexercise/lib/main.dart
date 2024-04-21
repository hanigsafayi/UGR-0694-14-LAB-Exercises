import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch posts');
  }
});

final createPostProvider =
    Provider.family<Future<Post>, Post>((ref, post) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode == 201) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
});

final updatePostProvider =
    Provider.family<Future<Post>, Post>((ref, post) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update post');
  }
});

final deletePostProvider =
    Provider.family<Future<void>, Post>((ref, post) async {
  final response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}'),
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete post');
  }
});

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'JSONPlaceholder Posts',
        home: PostsPage(),
      ),
    );
  }
}

class PostsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('JSONPlaceholder Posts'),
      ),
      body: posts.when(
        data: (posts) => ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      final updatedPost = Post(
                          id: post.id,
                          title: 'Updated title',
                          body: 'Updated body');
                      ref
                          .read(updatePostProvider(updatedPost))
                          .then((updatedPost) {});
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref.read(deletePostProvider(post)).then((_) {});
                    },
                  ),
                ],
              ),
            );
          },
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newPost =
              Post(id: 0, title: 'New Post', body: 'This is a new post');
          ref.read(createPostProvider(newPost)).then((newPost) {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
