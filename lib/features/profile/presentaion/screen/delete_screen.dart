import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../config/route/app_routes.dart';
import '../controller/delete_controller.dart';

class DeleteScreen extends StatelessWidget {
  DeleteScreen({Key? key}) : super(key: key);

  final controller = Get.put(DeleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.upcolor,
      appBar: AppBarNew(title: "Setting"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Delete Your Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 16.h),
        
                    // Warning Message
                    Text(
                      'This action will delete your all plans and permanently erase your all data. You cannot undo this action.',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 16.h),
        
                    // Confirmation Message
                    Text(
                      'If you are sure you want to proceed, enter your password below',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13.sp,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 32.h),
        
                    // Password Field Label
                    Text(
                      'Enter Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12.h),
        
                    // Password Input
                    Obx(() => TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.isPasswordVisible.value,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey[600],
                            size: 20.sp,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[800]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    )),
                  ],
                ),
              ),
            ),
        
            // Delete Account Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonButton(
                  titleText: "Delete Account",
                  onTap: () {
                    Get.toNamed(AppRoutes.settingScreen);
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}