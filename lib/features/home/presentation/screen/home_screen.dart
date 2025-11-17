import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/features/home/presentation/screen/showstory_screen.dart';
import 'package:road_project_flutter/features/home/presentation/screen/story_screen.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/home_controller.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            _buildCustomAppBar(),

            // Stories Section
            _buildStoriesSection(),

            // Posts Section
            Expanded(
              child: Obx(() => ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    post: controller.posts[index],
                    controller: controller,
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: ()=>Get.toNamed(AppRoutes.createPost),
                  child: Icon(Icons.add, color: Colors.white, size: 26.sp)
              ),
              SizedBox(width: 8.w),
              Text(
                'Road to 1%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Obx(() => GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.cartScreen);
                },
                child: _buildIconWithBadge(Icons.shopping_cart_outlined, controller.cartCount.value, AppColors.primaryColor, AppColors.black),
              )),
              SizedBox(width: 20.w),
              Obx(() => GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.notificationScreen);
                },
                child: _buildIconWithBadge(Icons.notifications_outlined, controller.notificationCount.value, Colors.red, AppColors.white),
              )),
              SizedBox(width: 20.w),
              Obx(() => GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.chatScreenImage);
                },
                child: _buildIconWithBadge(Icons.chat, controller.messageCount.value, AppColors.textColor, AppColors.white),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithBadge(IconData icon, int count, Color color, Color textColor) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: Colors.white, size: 24.sp),
        if (count > 0)
          Positioned(
            right: -6.w,
            top: -6.h,
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              constraints: BoxConstraints(
                minWidth: 18.w,
                minHeight: 18.h,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStoriesSection() {
    return Container(
      height: 110.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.stories.length,
        itemBuilder: (context, index) {
          return StoryItem(story: controller.stories[index]);
        },
      )),
    );
  }
}

class StoryItem extends StatelessWidget {
  final StoryModel story;

  const StoryItem({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (story.isOwn) {
          // ✅ Navigate to CreateStoryScreen
          Get.to(() => CreateStoryScreen());
        } else {
          Get.to(() => const StoryViewScreen());
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: story.hasStory ? AppColors.primaryColor : Colors.grey.shade800,
                      width: 2.5.w,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.r),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(story.image),
                    ),
                  ),
                ),
                if (story.isOwn)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00ff87),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2.w),
                      ),
                      child: Icon(Icons.add, color: Colors.black, size: 12.sp),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              story.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}


class PostCard extends StatelessWidget {
  final PostModel post;
  final HomeController controller;

  const PostCard({
    Key? key,
    required this.post,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      color: const Color(0xFF0a0a0a),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          _buildPostHeader(),

          // Post Images
          _buildPostImages(),

          // Post Actions
          _buildPostActions(),

          // Post Caption
          SizedBox(height: 8.h),
          _buildPostCaption(),

          // Comments Section
          _buildCommentsSection(),
        ],
      ),
    );
  }

  Widget _buildPostHeader() {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(post.userImage),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  post.time,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.onConnectTap(post.userName),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => controller.onMoreTap(post.id),
            child: Icon(Icons.more_vert, color: Colors.grey.shade400, size: 24.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImages() {
    final pageController = controller.getPageController(post.id);
    final currentPage = controller.getCurrentPage(post.id);

    if (pageController == null || currentPage == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 400.h,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: (page) => controller.onPageChanged(post.id, page),
            itemCount: post.images.length,
            itemBuilder: (context, index) {
              return Image.network(
                post.images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade900,
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (post.images.length > 1)
          Positioned(
            bottom: 10.h,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                post.images.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage.value == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            )),
          ),
      ],
    );
  }

  Widget _buildPostActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => controller.toggleLike(post.id),
            child: Icon(
              post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: post.isLiked ? Colors.red : AppColors.primaryColor,
              size: 26.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            '${post.likes}',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 14.sp),
          ),
          SizedBox(width: 20.w),
          GestureDetector(
            onTap: () => controller.onCommentTap(post.id),
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            '${post.comments.length}',
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => controller.onSaveTap(post.id),
            child: Icon(
              Icons.bookmark_border,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCaption() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              children: [
                TextSpan(
                  text: '${post.userName} ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: post.caption),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '#${post.hashtag}',
            style: TextStyle(
              color: const Color(0xFF00a8ff),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    if (post.comments.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
              children: [
                TextSpan(
                  text: '${post.comments[0].userName} ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: post.comments[0].comment,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}