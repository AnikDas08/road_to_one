import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/network_status.dart';

class NetworkController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  RxList<NetworkUser> users = <NetworkUser>[
    NetworkUser(
      id: '1',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      status: NetworkStatus.followRequest,
    ),
    NetworkUser(
      id: '2',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      status: NetworkStatus.following,
    ),
    NetworkUser(
      id: '3',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100',
      status: NetworkStatus.following,
    ),
    NetworkUser(
      id: '4',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=100',
      status: NetworkStatus.connected,
    ),
    NetworkUser(
      id: '5',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=100',
      status: NetworkStatus.connected,
    ),
    NetworkUser(
      id: '6',
      name: 'Shariful Madaripur',
      role: 'Developer',
      image: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      status: NetworkStatus.connected,
    ),
  ].obs;

  void acceptFollowRequest(int index) {
    users[index].status.value = NetworkStatus.following;
    users.refresh();
    Get.snackbar(
      'Success',
      'You are now following ${users[index].name}',
      backgroundColor: const Color(0xFFb4ff39),
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
  }

  void rejectFollowRequest(int index) {
    final userName = users[index].name;
    users.removeAt(index);
    Get.snackbar(
      'Rejected',
      'Follow request from $userName rejected',
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void unfollowUser(int index) {
    final userName = users[index].name;
    users.removeAt(index);
    Get.snackbar(
      'Unfollowed',
      'You unfollowed $userName',
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void blockUser(int index) {
    final userName = users[index].name;
    users.removeAt(index);
    Get.snackbar(
      'Blocked',
      'You blocked $userName',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void openMessage(NetworkUser user) {
    Get.snackbar(
      'Opening Chat',
      'Opening message with ${user.name}',
      backgroundColor: const Color(0xFFb4ff39),
      colorText: Colors.black,
      duration: const Duration(seconds: 2),
    );
    // Navigate to chat screen
    // Get.to(() => ChatScreen(user: user));
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}