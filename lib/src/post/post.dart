/// A Post with its details.
class Post {
  // Fields.
  final List<dynamic> attachments;
  final String content;
  final String id;
  final DateTime timestamp;
  final dynamic author;

  // Constructor.
  const Post({
    required this.attachments,
    required this.content,
    required this.id,
    required this.timestamp,
    required this.author
  });

  // Convert JSON Post into Post.
  Post.fromJsonPost(Map<String, dynamic> jsonPost)
      : attachments = jsonPost['attachments'] as List<dynamic>,
        content = jsonPost['content'] as String,
        id = jsonPost['id'] as String,
        timestamp = DateTime.parse(jsonPost['timestamp']),
        author = jsonPost['author'] as dynamic;

  // Convert Post into JSON Post.
  Map<String, dynamic> toJsonPost() => {
    'attachments': attachments,
    'content': content,
    'id': id,
    'timestamp': timestamp,
    'author': author
  };
}
