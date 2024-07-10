import 'package:flutter/material.dart';

import '../post/post_controller.dart';

/// Form for posting a message.
class ChatFormView extends StatefulWidget {
  // Fields.
  final PostController postController;

  // Constructor.
  const ChatFormView({
    super.key,
    required this.postController
  });

  static const routeName = '/form';

  @override
  State<ChatFormView> createState() => _ChatFormViewState();
}

class _ChatFormViewState extends State<ChatFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Write a message.',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Message is empty.';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _formKey.currentState?.save();
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 24.0,
                semanticLabel: 'Send message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
