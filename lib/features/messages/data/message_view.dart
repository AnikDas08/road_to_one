class Message {
  final String id;
  final String text;
  final String time;
  final bool isSentByMe;
  final String? imageUrl;

  Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isSentByMe,
    this.imageUrl,
  });
}