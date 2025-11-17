import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/notificati_controller.dart';
import '../models/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.upcolor,
      appBar: AppBarNew(title: "Notification"),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return _buildEmptyState();
        }

        final grouped = controller.groupedNotifications;

        return ListView(
          children: [
            // Recent Section
            if (grouped['Recent']!.isNotEmpty) ...[
              _buildSectionHeader('Recent'),
              ...grouped['Recent']!
                  .map((notification) => _buildNotificationItem(notification))
                  .toList(),
            ],

            // Yesterday Section
            if (grouped['Yesterday']!.isNotEmpty) ...[
              _buildSectionHeader('Yesterday'),
              ...grouped['Yesterday']!
                  .map((notification) => _buildNotificationItem(notification))
                  .toList(),
            ],
          ],
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return InkWell(
      onTap: () => controller.onNotificationTap(notification),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    notification.subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              notification.time,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            color: Colors.grey[700],
            size: 80.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Notifications',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You don\'t have any notifications yet',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}