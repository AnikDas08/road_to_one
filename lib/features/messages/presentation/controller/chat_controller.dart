import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/chat_model.dart' show ChatMessage;
import '../../data/story_model.dart';
import '../screen/message_screen.dart';

class ChatController extends GetxController {
  var searchController = TextEditingController();
  var filteredChats = <ChatMessage>[].obs;

  // Static story data
  final stories = <Story>[
    Story(
      id: '0',
      name: 'Your Story',
      avatar: 'https://i.pravatar.cc/150?img=1',
      isYourStory: true,
    ),
    Story(
      id: '1',
      name: 'Peterson',
      avatar: 'https://i.pravatar.cc/150?img=12',
    ),
    Story(
      id: '2',
      name: 'Peterson',
      avatar: 'https://i.pravatar.cc/150?img=13',
    ),
    Story(
      id: '3',
      name: 'Peterson',
      avatar: 'https://i.pravatar.cc/150?img=14',
    ),
    Story(
      id: '4',
      name: 'Peterson',
      avatar: 'https://i.pravatar.cc/150?img=15',
    ),
  ].obs;

  // Static chat data
  final chats = <ChatMessage>[
    ChatMessage(
      id: '1',
      name: 'Shariful Madarijpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
    ChatMessage(
      id: '2',
      name: 'Shariful Madarijpur',
      message: 'Hi',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
    ChatMessage(
      id: '3',
      name: 'Shariful Madarijpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
    ChatMessage(
      id: '4',
      name: 'Hridoy Rangpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=34',
      isOnline: true,
    ),
    ChatMessage(
      id: '5',
      name: 'Shariful Madarijpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
    ChatMessage(
      id: '6',
      name: 'Shariful Madarijpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
    ChatMessage(
      id: '7',
      name: 'Shariful Madarijpur',
      message: 'Hello',
      time: '11:30 AM',
      avatar: 'https://i.pravatar.cc/150?img=33',
      isOnline: true,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    filteredChats.value = chats;
  }

  void searchChats(String query) {
    if (query.isEmpty) {
      filteredChats.value = chats;
    } else {
      filteredChats.value = chats
          .where((chat) =>
      chat.name.toLowerCase().contains(query.toLowerCase()) ||
          chat.message.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void onChatTap(ChatMessage chat) {
    Get.to(() => MessageScreen(
      chatName: chat.name,
      chatAvatar: chat.avatar,
      isOnline: chat.isOnline,
    ));
  }

  void onStoryTap(Story story) {
    // Navigate to story view screen
    print('Opening story of ${story.name}');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}