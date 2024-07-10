import 'package:flutter/material.dart';

import '../settings/settings_view.dart';

/// Displays detailed information about a Post.
class PostDetailsView extends StatelessWidget {
  const PostDetailsView({super.key});

  static const routeName = '/post';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('More information here.'),
      ),
    );
  }
}
