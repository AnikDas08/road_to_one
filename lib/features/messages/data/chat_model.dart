import 'package:get/get.dart';

class ChatMessage {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool isOnline;

  ChatMessage({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.isOnline,
  });
}