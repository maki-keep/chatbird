import 'package:flutter/material.dart';

import 'package:chatbird/src/post/post.dart';
import 'package:chatbird/src/post/post_service.dart';

/// A class that many Widgets can interact with to read Posts,
/// update Posts, or listen to Posts changes.
///
/// Controllers glue Data Services to Flutter Widgets.
/// The PostController uses the PostService to store and retrieve Posts.
class PostController with ChangeNotifier {
  // Make _postService a private variable so it is not used directly.
  final PostService _postService;

  // Constructor.
  PostController(this._postService);

  // Make _posts a private variable so it is not updated directly without
  // also persisting the changes with the PostService.
  late List<Post> _posts;

  // Allow Widgets to read the Posts.
  List<Post> get posts => _posts;

  /// Load the Posts from the PostService.
  /// It may load from a local database or the internet.
  /// The controller only knows it can load the Posts from the service.
  Future<void> loadPosts() async {
    _posts = await _postService.fetchPosts();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the Posts.
  Future<void> updatePosts(List<Post>? newPosts) async {
    if (newPosts == null) return;

    // Do not perform any work if new and old Posts are identical.
    if (newPosts == _posts) return;

    // Otherwise, store the new Posts in memory.
    _posts = newPosts;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // PostService.
    await _postService.updatePosts(newPosts);
  }
}
