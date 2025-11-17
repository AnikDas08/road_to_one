import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/features/business/presentation/controller/business_controller.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';

class BusinessScreen extends StatelessWidget {
  BusinessScreen({Key? key}) : super(key: key);

  final BusinessController controller = Get.put(BusinessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h), // 👈 AppBar height increased
        child: AppBarNew(title: "Personal Business & Mindset Development Plan",showBackButton: false,),
      ),

      body: Obx(() => ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: controller.plans.length,
        itemBuilder: (context, index) {
          final plan = controller.plans[index];
          return _buildPlanItem(plan);
        },
      )),
    );
  }

  Widget _buildPlanItem(Map<String, dynamic> plan) {
    final isLocked = plan['isLocked'] ?? false;

    return GestureDetector(
      onTap: () {
        if (!isLocked) {
          controller.openPlan(plan);
        } else {
          controller.showLockedMessage();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: isLocked
              ? AppColors.gray.withOpacity(0.3)
              : AppColors.upcolor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                plan['title'] ?? '',
                style: TextStyle(
                  color: isLocked
                      ? Colors.grey[600]
                      : Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              isLocked ? Icons.lock_outline : Icons.chevron_right,
              color: isLocked
                  ? Colors.grey[600]
                  : Colors.white,
              size: isLocked ? 30.sp : 30.sp,
            ),
          ],
        ),
      ),
    );
  }
}