import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/common_image.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/button/common_button.dart';

class OnboardingSecondScreen extends StatelessWidget {
  const OnboardingSecondScreen({super.key});

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
                      onTap: ()=>Get.toNamed(AppRoutes.signIn),
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
                CommonImage( imageSrc: "assets/images/on_boarding_second_image.png"),
                SizedBox(height: 60.h),
                CommonText(
                  text: "Easy Onboarding System",
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white50,
                ),
                SizedBox(height: 20.h,),
                CommonText(
                  text: "Your fitness products are on their way and will be delivered to your address soon!",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white50,
                  maxLines: 3,
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CommonButton(
            titleText: "Next",
            onTap: () {
              Get.toNamed(AppRoutes.onBoardingThree);
            },
          ),
        ),
      ),
    );
  }
}
