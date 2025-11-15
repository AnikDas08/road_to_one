import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/text/common_text.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Gym & Fitness Plans",showBackButton: false,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.myPlanScreen);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: AppColors.white50,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.lock, size: 50.sp, color: AppColors.gray,),
                      ),
                      SizedBox(height: 8.h,),
                      CommonText(
                        text: "My Plan",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white50,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.myProgressScreen);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: AppColors.white50,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.start, size: 50.sp, color: AppColors.gray,),
                      ),
                      SizedBox(height: 8.h,),
                      CommonText(
                        text: "My Progress",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white50,)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: ()=>Get.toNamed(AppRoutes.calenderScreen),
                  child: Column(
                    children: [
                      Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: AppColors.white50,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Icons.calendar_month_sharp, size: 50.sp, color: AppColors.gray,),
                      ),
                      SizedBox(height: 8.h,),
                      CommonText(
                        text: "Calendar",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white50,)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
