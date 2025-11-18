import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../data/message_view.dart';
import '../controller/message_controller.dart';

class MessageScreen extends StatelessWidget {
  final String chatName;
  final String chatAvatar;
  final bool isOnline;

  MessageScreen({
    Key? key,
    required this.chatName,
    required this.chatAvatar,
    this.isOnline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageController controller = Get.put(
      MessageController(
        chatName: chatName,
        chatAvatar: chatAvatar,
        isOnline: isOnline,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.upcolor,
        appBar: AppBar(
          backgroundColor: AppColors.upcolor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: Colors.grey[800],
                backgroundImage: NetworkImage(chatAvatar),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: isOnline ? AppColors.primaryColor : Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Messages List
            Expanded(
              child: Obx(() => ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(16.w),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildMessageBubble(message, chatAvatar);
                },
              )),
            ),
      
            // Message Input
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.upcolor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Attachment Button
                  GestureDetector(
                    onTap: controller.showImageOptions,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white70,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
      
                  // Text Input
                  Expanded(
                    child: TextField(
                      controller: controller.messageController,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                        filled: true,
                        fillColor: Color(0xFF2A2A2A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => controller.sendMessage(),
                    ),
                  ),
                  SizedBox(width: 12.w),
      
                  // Send Button
                  GestureDetector(
                    onTap: controller.sendMessage,
                    child: Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message, String chatAvatar) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment:
        message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for received messages
          if (!message.isSentByMe) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.grey[800],
              backgroundImage: NetworkImage(chatAvatar),
            ),
            SizedBox(width: 8.w),
          ],

          // Message Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: message.isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: message.isSentByMe
                        ? Color(0xFF7C9631)
                        : Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: message.isSentByMe ? Radius.circular(16.r) : Radius.zero,
                      bottomRight: message.isSentByMe ? Radius.zero : Radius.circular(16.r),
                    ),
                  ),
                  child: message.imageUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(message.imageUrl!),
                      width: 200.w,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Text(
                    message.text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11.sp,
                      ),
                    ),
                    if (message.isSentByMe) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.done_all,
                        color: Colors.grey[600],
                        size: 14.sp,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Avatar for sent messages (optional)
          if (message.isSentByMe) SizedBox(width: 8.w),
        ],
      ),
    );
  }
}