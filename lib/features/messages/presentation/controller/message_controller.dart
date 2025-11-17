import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/message_view.dart';


class MessageController extends GetxController {
  final String chatName;
  final String chatAvatar;
  final bool isOnline;

  MessageController({
    required this.chatName,
    required this.chatAvatar,
    required this.isOnline,
  });

  final TextEditingController messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  var messages = <Message>[
    Message(
      id: '1',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:30 AM',
      isSentByMe: true,
    ),
    Message(
      id: '2',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:39 AM',
      isSentByMe: false,
    ),
    Message(
      id: '3',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:39 AM',
      isSentByMe: true,
    ),
    Message(
      id: '4',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:39 AM',
      isSentByMe: false,
    ),
    Message(
      id: '5',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:39 AM',
      isSentByMe: true,
    ),
    Message(
      id: '6',
      text: "Glad you liked it! It's called 'Midnight Pulse.' I can send you the stems if you're ready.",
      time: '10:39 AM',
      isSentByMe: false,
    ),
  ].obs;

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: messageController.text.trim(),
      time: _formatTime(DateTime.now()),
      isSentByMe: true,
    );

    messages.insert(0, newMessage);
    messageController.clear();
  }

  Future<void> pickAndSendImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final newMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          time: _formatTime(DateTime.now()),
          isSentByMe: true,
          imageUrl: image.path,
        );

        messages.insert(0, newMessage);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> pickAndSendImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        final newMessage = Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: '',
          time: _formatTime(DateTime.now()),
          isSentByMe: true,
          imageUrl: image.path,
        );

        messages.insert(0, newMessage);
      }
    } catch (e) {
      print('Error taking photo: $e');
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  void showImageOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.white),
              title: Text('Choose from gallery', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                pickAndSendImage();
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.white),
              title: Text('Take a photo', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                pickAndSendImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}