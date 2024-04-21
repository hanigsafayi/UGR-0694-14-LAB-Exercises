import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});
}

class PostsProvider extends ChangeNotifier {
  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future<void> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      _posts = data
          .map((postData) => Post(
                id: postData['id'],
                title: postData['title'],
                body: postData['body'],
              ))
          .toList();
      notifyListeners();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<void> createPost(String title, String body) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'body': body}),
    );

    if (response.statusCode == 201) {
      final newPost = Post(
        id: json.decode(response.body)['id'],
        title: title,
        body: body,
      );
      _posts.add(newPost);
      notifyListeners();
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> updatePost(Post post, String newTitle, String newBody) async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': newTitle, 'body': newBody}),
    );

    if (response.statusCode == 200) {
      final updatedPost = Post(
        id: post.id,
        title: newTitle,
        body: newBody,
      );
      final index = _posts.indexWhere((p) => p.id == post.id);
      _posts[index] = updatedPost;
      notifyListeners();
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(Post post) async {
    final url =
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      _posts.removeWhere((p) => p.id == post.id);
      notifyListeners();
    } else {
      throw Exception('Failed to delete post');
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostsProvider(),
      child: MaterialApp(
        title: 'JSONPlaceholder Posts',
        home: const PostsPage(),
      ),
    );
  }
}

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<PostsProvider>(context, listen: false).fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholder Posts'),
        actions: [
          IconButton(
            onPressed: () {
              _showCreatePostDialog(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<PostsProvider>(
        builder: (context, postsProvider, child) {
          if (postsProvider.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: postsProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postsProvider.posts[index];
              return Dismissible(
                key: Key('post-${post.id}'),
                onDismissed: (direction) {
                  postsProvider.deletePost(post);
                },
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _showUpdatePostDialog(context, post);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          postsProvider.deletePost(post);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: 'Body',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final body = bodyController.text;
                Provider.of<PostsProvider>(context, listen: false)
                    .createPost(title, body);
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdatePostDialog(BuildContext context, Post post) {
    final titleController = TextEditingController(text: post.title);
    final bodyController = TextEditingController(text: post.body);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: 'Body',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newTitle = titleController.text;
                final newBody = bodyController.text;
                Provider.of<PostsProvider>(context, listen: false)
                    .createPost(newTitle, newBody);
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
