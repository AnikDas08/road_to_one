import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/create_stroy_controllers.dart';

class CreateStoryScreen extends StatelessWidget {
  CreateStoryScreen({Key? key}) : super(key: key);

  final CreateStoryController controller = Get.put(CreateStoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarNew(title: "Create Story"),
      body: SafeArea(
        child: Column(
          children: [

            // Image Preview Area
            Expanded(
              child: Obx(() => controller.selectedImage.value != null
                  ? _buildImagePreview()
                  : _buildPlaceholder()),
            ),

            // Bottom Actions
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            'Create Story',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Obx(() {
      return Stack(
        children: [
          // Image preview
          Positioned.fill(
            child: Image.file(
              File(controller.selectedImage.value!),
              fit: BoxFit.cover,
            ),
          ),

          // Editable text overlay
          if (controller.textWidgetVisible.value)
            Positioned(
              left: controller.textPosition.value.dx,
              top: controller.textPosition.value.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  controller.updateTextPosition(details.delta);
                },
                onDoubleTap: () {
                  controller.enableTextEditing();
                },
                child: controller.isEditing.value
                    ? Container(
                  width: 200,
                  padding: const EdgeInsets.all(8),
                  color: Colors.black54,
                  child: TextField(
                    controller: controller.textController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter text",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    onSubmitted: (value) {
                      controller.saveEditedText(value);
                    },
                  ),
                )
                    : Text(
                  controller.editedText.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Add text button (bottom right)
          Positioned(
            bottom: 20.h,
            right: 20.w,
            child: GestureDetector(
              onTap: controller.onTextEditTap,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Text',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.text_fields,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }


  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 80.sp,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: 16.h),
          Text(
            'Select an image to create story',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: Obx(() => controller.selectedImage.value != null
          ? _buildCreateButton()
          : _buildSelectImageButton()),
    );
  }

  Widget _buildSelectImageButton() {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            'Select Image',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton() {
    return GestureDetector(
      onTap: controller.createStory,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Text(
            'Create Story',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
