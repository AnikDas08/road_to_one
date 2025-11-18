import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../home/presentation/screen/showstory_screen.dart';
import '../../../home/presentation/screen/story_screen.dart';
import '../../data/chat_model.dart';
import '../../data/story_model.dart';
import '../controller/chat_controller.dart';


class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Chat"),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.searchChats,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
                filled: true,
                fillColor: Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
            ),
          ),

          // Stories Section
          Container(
            height: 100.h,
            padding: EdgeInsets.only(left: 16.w),
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.stories.length,
              itemBuilder: (context, index) {
                final story = controller.stories[index];
                return _buildStoryItem(story);
              },
            )),
          ),

          SizedBox(height: 8.h),

          // Chat List
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredChats.length,
              itemBuilder: (context, index) {
                final chat = controller.filteredChats[index];
                return _buildChatItem(chat);
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(Story story) {
    return GestureDetector(
      onTap: () {
        if (story.isYourStory) {
          Get.to(() => CreateStoryScreen());
        } else {
          Get.to(() => const StoryViewScreen());
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          children: [
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: story.isYourStory
                      ? Colors.grey[600]!
                      : AppColors.primaryColor,
                  width: 2.5,
                ),
              ),
              child: Stack(
                children:
                [
                  Container(
                    width: 65.w,
                    height: 65.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.r),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(story.avatar),
                      ),
                    ),
                  ),
                  if (story.isYourStory)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.w),
                        ),
                        child: Icon(Icons.add, color: Colors.black, size: 12.sp),
                      ),
                    ),
                ]
              ),
            ),
            SizedBox(height: 6.h),
            SizedBox(
              width: 64.w,
              child: Text(
                story.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(ChatMessage chat) {
    return InkWell(
      onTap: () => controller.onChatTap(chat),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 28.r,
                  backgroundColor: Colors.grey[800],
                  backgroundImage: NetworkImage(chat.avatar),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.upcolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),

            // Name and Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    chat.message,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time and Online indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                if (chat.isOnline)
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}