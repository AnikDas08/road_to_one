import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';
import '../controller/details_all_controller.dart';

class BreakfastScreen extends StatelessWidget {
  BreakfastScreen({Key? key}) : super(key: key);

  final BreakfastController controller = Get.put(BreakfastController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: controller.mealType),
      body: Obx(() => GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.85,
        ),
        itemCount: controller.meals.length,
        itemBuilder: (context, index) {
          return _buildMealItem(index);
        },
      )),
    );
  }

  Widget _buildMealItem(int index) {
    return GestureDetector(
      onTap: () => controller.onMealTap(index),
      child: Obx(() => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            // Image or Lock Icon
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: controller.meals[index].isLocked.value
                      ? const Color(0xFF1a1a1a)
                      : const Color(0xFF2d2d2d),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                child: controller.meals[index].isLocked.value
                    ? Center(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey[600],
                      size: 28.sp,
                    ),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.network(
                    controller.meals[index].imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[900],
                        child: Icon(
                          Icons.image,
                          color: Colors.grey[600],
                          size: 32.sp,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Meal Name
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2d2d2d),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.r),
                ),
              ),
              child: Text(
                controller.meals[index].name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: controller.meals[index].isLocked.value
                      ? Colors.grey[600]
                      : Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}