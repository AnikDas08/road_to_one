import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';
import '../../data/model/my_plan_model.dart';
import '../controller/my_plancontroller.dart';

class MyPlanScreen extends StatelessWidget {
  MyPlanScreen({Key? key}) : super(key: key);

  final MyPlanController controller = Get.put(MyPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "My Plan"),
      body: Obx(() => ListView.builder(
        padding: EdgeInsets.only(top: 20,bottom: 10),
        itemCount: controller.plans.length,
        itemBuilder: (context, index) {
          final plan = controller.plans[index];
          return _buildPlanItem(plan);
        },
      )),
    );
  }

  Widget _buildPlanItem(PlanModel plan) {
    return GestureDetector(
      onTap: () {
        if (!plan.isLocked.value) {
          controller.openPlan(plan);
        } else {
          controller.showLockedMessage();
        }
      },
      child: Obx(() => Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: plan.isLocked.value ? AppColors.gray : AppColors.upcolor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              plan.title,
              style: TextStyle(
                color: plan.isLocked.value ? Colors.grey[600] : Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            plan.isLocked.value
                ? Icon(
              Icons.lock,
              color: Colors.grey[600],
              size: 20.sp,
            )
                : Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24.sp,
            ),
          ],
        ),
      )),
    );
  }
}