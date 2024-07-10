import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chatbird/src/post/post.dart';

/// A service that stores and retrieves Posts.
class PostService {
  Future<List<Post>> fetchPosts() async {
    // Growable List for containing the Posts from the response.
    List<Post> posts = List.empty(growable: true);

    // Await a response from a URL.
    final response = await http
        .get(Uri.parse('https://my-json-server.typicode.com/maki-keep/typicode_demo/posts'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the list of JSON Post entries.
      for (Map<String, dynamic> jsonPost in jsonDecode(response.body) as List<dynamic>) {
        posts.add(Post.fromJsonPost(jsonPost));
      }
      print(posts);
      return posts;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load posts.');
    }
  }

  /// Persists the Posts to local or remote storage.
  Future<void> updatePosts(List<Post> posts) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }
}
