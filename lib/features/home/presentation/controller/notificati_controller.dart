import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/notification_model.dart';

class NotificationController extends GetxController {
  var notifications = <NotificationItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  void _loadNotifications() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    notifications.value = [
      // Today's notifications
      NotificationItem(
        id: '1',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: now.subtract(Duration(hours: 2)),
      ),
      NotificationItem(
        id: '2',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: now.subtract(Duration(hours: 2)),
      ),
      NotificationItem(
        id: '3',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: now.subtract(Duration(hours: 2)),
      ),

      // Yesterday's notifications
      NotificationItem(
        id: '4',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 20)),
      ),
      NotificationItem(
        id: '5',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 18)),
      ),
      NotificationItem(
        id: '6',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 16)),
      ),
      NotificationItem(
        id: '7',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 14)),
      ),
      NotificationItem(
        id: '8',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 12)),
      ),
      NotificationItem(
        id: '9',
        title: 'Your order is on the way',
        subtitle: 'Midnights (3am Edition) is now available',
        time: '2h ago',
        dateTime: yesterday.add(Duration(hours: 10)),
      ),
    ];
  }

  Map<String, List<NotificationItem>> get groupedNotifications {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    Map<String, List<NotificationItem>> grouped = {
      'Recent': [],
      'Yesterday': [],
    };

    for (var notification in notifications) {
      final notificationDate = DateTime(
        notification.dateTime.year,
        notification.dateTime.month,
        notification.dateTime.day,
      );

      if (notificationDate == today) {
        grouped['Recent']!.add(notification);
      } else if (notificationDate == yesterday) {
        grouped['Yesterday']!.add(notification);
      }
    }

    return grouped;
  }

  void onNotificationTap(NotificationItem notification) {
    print('Tapped notification: ${notification.title}');
    // Navigate to notification detail or order details
  }

  void clearAllNotifications() {
    Get.defaultDialog(
      title: 'Clear All',
      titleStyle: TextStyle(color: Colors.white),
      middleText: 'Are you sure you want to clear all notifications?',
      middleTextStyle: TextStyle(color: Colors.white70),
      backgroundColor: Color(0xFF2A2A2A),
      radius: 12,
      textConfirm: 'Clear',
      textCancel: 'Cancel',
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.white,
      buttonColor: Color(0xFFCCFF00),
      onConfirm: () {
        notifications.clear();
        Get.back();
      },
    );
  }
}