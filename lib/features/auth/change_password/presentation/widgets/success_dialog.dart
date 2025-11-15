import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:road_project_flutter/component/image/common_image.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import '../../../../../component/button/common_button.dart';

class SuccessDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // disable outside tap
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.gray, // custom background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Image
              CommonImage(
                imageSrc: "assets/images/success_here.png",
                height: 120.h,
                width: 120.w,
              ),

              SizedBox(height: 20.h),

              /// Title
              CommonText(
                text: "Congratulations!",
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white50,
              ),

              SizedBox(height: 12.h),

              /// Message
              CommonText(
                text: "Your password has been successfully changed.",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white700,
                maxLines: 3,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 25.h),

              /// Button
              CommonButton(
                titleText: "Go to Login",
                onTap: () {
                  Get.toNamed(AppRoutes.signIn);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
