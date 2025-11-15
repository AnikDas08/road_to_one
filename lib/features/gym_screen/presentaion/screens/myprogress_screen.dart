import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import 'dart:io';
import '../controller/my_progress_controller.dart';

class MyProgressScreen extends GetView<MyProgressController> {
  MyProgressScreen({Key? key}) : super(key: key);

  MyProgressController controller=Get.put(MyProgressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          _buildTimeFilterTabs(),
          SizedBox(height: 24.h),
          _buildWorkoutCount(),
          SizedBox(height: 20.h),
          _buildWorkoutPicturesHeader(),
          SizedBox(height: 12.h),
          _buildPicturesGrid(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.backgroudColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'My Progress',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTimeFilterTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildTabButton('This Week', 0),
          SizedBox(width: 8.w),
          _buildTabButton('This Month', 1),
          SizedBox(width: 8.w),
          _buildTabButton('This Year', 2),
          SizedBox(width: 8.w),
          _buildTabButton('Total', 3),
        ],
      ),
    );
  }

  Widget _buildWorkoutCount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: const Color(0xFFb4ff39),
            size: 20.sp,
          ),
          SizedBox(width: 8.w),
          Obx(() => Text(
            '${controller.workoutCount} workout${controller.workoutCount != 1 ? 's' : ''}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWorkoutPicturesHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        'Workout Pictures',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPicturesGrid() {
    return Expanded(
      child: Obx(() {
        final pictureCount = controller.pictures.length;
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 1,
          ),
          itemCount: pictureCount + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildAddPictureButton();
            }
            return _buildPictureItem(controller.pictures[index - 1], index - 1);
          },
        );
      }),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Obx(() {
      final isSelected = controller.selectedTab == index;
      return GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.grey[700]!,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAddPictureButton() {
    return GestureDetector(
      onTap: () => controller.addPicture(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          Icons.add_photo_alternate_outlined,
          color: Colors.grey[600],
          size: 32.sp,
        ),
      ),
    );
  }

  Widget _buildPictureItem(String imageUrl, int index) {
    return GestureDetector(
      onLongPress: () => _showDeleteDialog(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: imageUrl.startsWith('http')
                ? NetworkImage(imageUrl) as ImageProvider
                : FileImage(File(imageUrl)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(int index) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text(
          'Delete Picture',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete this picture?',
          style: TextStyle(color: Colors.grey[400]),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.deletePicture(index);
              Get.back();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}