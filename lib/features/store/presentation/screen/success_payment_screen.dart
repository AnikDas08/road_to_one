import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/component/image/common_image.dart';

import '../../../../component/text/common_text.dart';
import '../../../../config/route/app_routes.dart';
import '../../../../utils/constants/app_colors.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonImage(
                  imageSrc: "assets/images/success_home.png",
                  height: 367.h,
                  width: 375.w,
              ),
              CommonText(
                text: "Thank You",
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white50,
              ),
              SizedBox(height: 4.h),
              CommonText(
                text: "Your payment has been placed successfully done!",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white700,
              ),
              SizedBox(height: 24.h),
              CommonButton(
                  titleText: "Go to Home",
                onTap: (){
                       Get.offAllNamed(AppRoutes.homeNav);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
