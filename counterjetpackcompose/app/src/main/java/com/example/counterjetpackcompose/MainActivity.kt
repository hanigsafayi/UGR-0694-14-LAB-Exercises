package com.example.counterjetpackcompose

import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp

@Composable
fun CounterApp() {
    var count by remember { mutableStateOf(0) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(text = "Count: $count", style = MaterialTheme.typography.h4)

        Spacer(modifier = Modifier.height(16.dp))

        Row {
            Button(onClick = { count++ }) {
                Text(text = "Increment")
            }

            Spacer(modifier = Modifier.width(16.dp))

            Button(onClick = { count-- }) {
                Text(text = "Decrement")
            }

            Spacer(modifier = Modifier.width(16.dp))

            Button(onClick = { count = 0 }) {
                Text(text = "Reset")
            }
        }
    }
}

fun Text(text: String) {

}

@Composable
fun Text(text: String, style: Any) {

}


@Composable
fun CounterAppContent() {
    CounterApp()
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    CounterAppTheme {
        CounterAppContent()
    }
}
