import 'package:flutter/material.dart';

import 'package:chatbird/src/loading/loading_mixin.dart';
import 'package:chatbird/src/chat_form/chat_form_view.dart';
import 'package:chatbird/src/post/post.dart';
import 'package:chatbird/src/post/post_controller.dart';
import 'package:chatbird/src/post/post_details_view.dart';
import 'package:chatbird/src/settings/settings_view.dart';

/// Displays a list of Posts.
class PostListView extends StatefulWidget {
  // Fields.
  final PostController controller;

  // Constructor.
  const PostListView({
    super.key,
    required this.controller
  });

  static const routeName = '/';

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> with LoadingMixin {
  List<Post> _items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() => _refresh());
    });
  }

  // Refresh posts.
  Future<void> _refresh() async {
    changeLoading(isLoading: true);

    // Simulate an asynchronous operation.
    await Future.delayed(const Duration(seconds: 2));
    await widget.controller.loadPosts();
    setState(() {
      _items = widget.controller.posts;
    });

    changeLoading(isLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _refresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () {
              Navigator.restorablePushNamed(context, ChatFormView.routeName);
            },
          ),
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
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoadingNotifier,
        builder: (context, value, child) => value
          ? CircularProgressIndicator(
            color: Theme.of(context).primaryColorDark,
          )
          // To work with lists that may contain a large number of items, it’s best
          // to use the ListView.builder constructor.
          //
          // In contrast to the default ListView constructor, which requires
          // building all Widgets up front, the ListView.builder constructor lazily
          // builds Widgets as they’re scrolled into view.
          : ListView.builder(
            // Providing a restorationId allows the ListView to restore the
            // scroll position when a user leaves and returns to the app after it
            // has been killed while running in the background.
            restorationId: 'PostListView',
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _items[index];
              final author = item.author;
              final dateTime = item.timestamp;
              return Container(
                color: Theme.of(context).splashColor,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(item.content),
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            // Display the avatar.
                            backgroundImage: NetworkImage(author['avatar']),
                          ),
                          Text(author['name'])
                        ],
                      ),
                      trailing: Text('${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}'),
                      onTap: () {
                        // Navigate to the details page. If the user leaves and returns to
                        // the app after it has been killed while running in the
                        // background, the navigation stack is restored.
                        Navigator.restorablePushNamed(
                          context,
                          PostDetailsView.routeName,
                        );
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for(int i = 0; i < item.attachments.length; i++)...[
                          Image.network(item.attachments[i]['src']),
                        ],
                      ]
                    ),
                  ],
                ),
              );
            },
          ),
      ),
    );
  }
}
