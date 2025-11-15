import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/common_image.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/button/common_button.dart';
import '../../../../config/route/app_routes.dart';

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,size: 24.sp,color: Colors.white,),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signIn);
                      },
                      child: CommonText(
                        text: "Skip",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.h),
                CommonImage( imageSrc: "assets/images/on_boarding_3rd_image.png"),
                SizedBox(height: 60.h),
                CommonText(
                  text: "Easy Payment Method",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white50,
                ),
                SizedBox(height: 20.h,),
                CommonText(
                  text: "Enjoy a seamless and secure payment experience that lets you subscribe to workout plans, track progress, and stay focused on your fitness goals—without any hassle",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white50,
                  maxLines: 5,
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CommonButton(
            titleText: "Get Started",
            onTap: () {
              Get.toNamed(AppRoutes.signIn);
            },
          ),
        ),
      ),
    );
  }
}
