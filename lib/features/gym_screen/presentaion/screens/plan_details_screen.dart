import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/plan_details_controller.dart';
class PlanDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final PlanDetailController controller = Get.put(PlanDetailController());

    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "My Push"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: const Color(0xFFb4ff39),
            ),
          );
        }

        final plan = controller.planDetail.value;
        if (plan == null) {
          return Center(
            child: Text(
              'No plan details available',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plan Image
              Container(
                width: double.infinity,
                height: 250.h,
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  image: DecorationImage(
                    image: NetworkImage(plan.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Plan Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  plan.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Plan Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  plan.description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Benefits Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Benefits',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // Benefits List
              ...plan.benefits.map((benefit) =>
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h, right: 12.w),
                          width: 6.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFb4ff39),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            benefit,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }
}