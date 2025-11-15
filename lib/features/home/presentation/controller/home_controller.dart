import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

// Home Controller - Single controller for entire screen
class HomeController extends GetxController {
  final scrollController = ScrollController();

  // Observable lists
  var stories = <StoryModel>[].obs;
  var posts = <PostModel>[].obs;

  // Notification counts
  var cartCount = 3.obs;
  var notificationCount = 1.obs;
  var messageCount = 5.obs;

  // Post image carousel controllers
  final Map<String, PageController> pageControllers = {};
  final Map<String, RxInt> currentPages = {};
  final Map<String, Timer?> autoScrollTimers = {};

  @override
  void onInit() {
    super.onInit();
    loadStories();
    loadPosts();
    initializePostControllers();
  }

  void onRefresh(){

  }

  @override
  void onClose() {
    scrollController.dispose();
    // Dispose all page controllers and timers
    for (var controller in pageControllers.values) {
      controller.dispose();
    }
    for (var timer in autoScrollTimers.values) {
      timer?.cancel();
    }
    super.onClose();
  }

  void loadStories() {
    stories.value = [
      StoryModel(name: 'Your Story', image: 'https://i.pravatar.cc/150?img=1', isOwn: true, hasStory: false),
      StoryModel(name: 'Peterson', image: 'https://i.pravatar.cc/150?img=2', isOwn: false, hasStory: true),
      StoryModel(name: 'Johnson', image: 'https://i.pravatar.cc/150?img=3', isOwn: false, hasStory: true),
      StoryModel(name: 'Peterson', image: 'https://i.pravatar.cc/150?img=4', isOwn: false, hasStory: true),
      StoryModel(name: 'Peterson', image: 'https://i.pravatar.cc/150?img=5', isOwn: false, hasStory: true),
    ];
  }

  void loadPosts() {
    posts.value = [
      PostModel(
        id: 'post1',
        userName: 'J.K Peterson',
        userImage: 'https://i.pravatar.cc/150?img=2',
        time: '2 hours ago',
        caption: 'What are you looking for others???',
        hashtag: 'Feshion-Co',
        images: [
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500',
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=500',
          'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=500',
        ],
        likes: '1.3k',
        isLiked: false,
        comments: [
          CommentModel(userName: 'Feshion-Co', comment: 'looking so healthy :)')
        ],
      ),
      PostModel(
        id: 'post2',
        userName: 'Hank Jhonson',
        userImage: 'https://i.pravatar.cc/150?img=3',
        time: '3 hours ago',
        caption: 'What are you doing for others???',
        hashtag: 'Feshion-Co',
        images: [
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=500',
        ],
        likes: '1.3k',
        isLiked: false,
        comments: [
          CommentModel(userName: 'Asad Ux', comment: 'What are you doing for others???')
        ],
      ),
    ];
  }

  void initializePostControllers() {
    for (var post in posts) {
      if (!pageControllers.containsKey(post.id)) {
        pageControllers[post.id] = PageController();
        currentPages[post.id] = 0.obs;

        // Start auto scroll for posts with multiple images
        if (post.images.length > 1) {
          startAutoScroll(post.id, post.images.length);
        }
      }
    }
  }

  void startAutoScroll(String postId, int imageCount) {
    autoScrollTimers[postId] = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPages[postId] != null && pageControllers[postId] != null) {
        int nextPage = (currentPages[postId]!.value + 1) % imageCount;
        currentPages[postId]!.value = nextPage;

        if (pageControllers[postId]!.hasClients) {
          pageControllers[postId]!.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
      }
    });
  }

  void onPageChanged(String postId, int page) {
    if (currentPages[postId] != null) {
      currentPages[postId]!.value = page;
    }
  }

  // App bar actions
  void onCartTap() {
    Get.snackbar('Cart', 'Cart clicked');
  }

  void onNotificationTap() {
    Get.snackbar('Notifications', 'Notifications clicked');
  }

  void onMessageTap() {
    Get.snackbar('Messages', 'Messages clicked');
  }

  // Post actions
  void toggleLike(String postId) {
    int index = posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      posts[index].isLiked = !posts[index].isLiked;
      posts.refresh();
    }
  }

  void onCommentTap(String postId) {
    Get.snackbar('Comment', 'Comment on post $postId');
  }

  void onSaveTap(String postId) {
    Get.snackbar('Save', 'Post $postId saved');
  }

  void onConnectTap(String userName) {
    Get.snackbar('Connect', 'Connected with $userName');
  }

  void onMoreTap(String postId) {
    Get.snackbar('More', 'More options for post $postId');
  }

  // Get page controller for a post
  PageController? getPageController(String postId) {
    return pageControllers[postId];
  }

  // Get current page for a post
  RxInt? getCurrentPage(String postId) {
    return currentPages[postId];
  }
}