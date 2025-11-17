import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/features/auth/change_password/presentation/controller/change_password_controller_here.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Change Password"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  color: AppColors.upcolor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: "Please set your new password",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white700,
                      ),
                      SizedBox(height: 32.h),
        
                      // Current Password
                      Text(
                        'Current Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(() => TextField(
                        controller: controller.currentPasswordController,
                        obscureText: !controller.isCurrentPasswordVisible.value,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'enter Password',
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isCurrentPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[600],
                              size: 20.sp,
                            ),
                            onPressed: controller.toggleCurrentPasswordVisibility,
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
        
                      SizedBox(height: 32.h),
        
                      // New Password
                      Text(
                        'New Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(() => TextField(
                        controller: controller.newPasswordController,
                        obscureText: !controller.isNewPasswordVisible.value,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'enter Password',
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isNewPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[600],
                              size: 20.sp,
                            ),
                            onPressed: controller.toggleNewPasswordVisibility,
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
        
                      SizedBox(height: 32.h),
        
                      // Confirm New Password
                      Text(
                        'Confirm New Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(() => TextField(
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'enter Password',
                          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[600],
                              size: 20.sp,
                            ),
                            onPressed: controller.toggleConfirmPasswordVisibility,
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
            ),
        
            // Update Password Button
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: controller.updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    'Update Password',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}