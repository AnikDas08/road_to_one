// Path: lib/screens/store/shipping_information_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/features/profile/presentaion/controller/shipping_information_update.dart';
import 'package:road_project_flutter/features/store/presentation/screen/pay_screen.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';


class ShippingInformationUpdateScreen extends StatelessWidget {
  ShippingInformationUpdateScreen({Key? key}) : super(key: key);

  final ShippingInformationUpdateController controller = Get.put(ShippingInformationUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(
          title: "Shipping Information"
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shipping to
                    Text(
                      'Shipping to',
                      style: TextStyle(
                        color: AppColors.white50,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
        
                    // Address Input
                    Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: controller.addressController,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      decoration: InputDecoration(
                        hintText: 'Enter your address',
                        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                        filled: true,
                        fillColor: Color(0xFF2A2A2A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      ),
                      maxLines: 2,
                    ),
        
                    SizedBox(height: 24.h),
        
                    // Contact Input
                    Text(
                      'Contact',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: controller.contactController,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                        filled: true,
                        fillColor: Color(0xFF2A2A2A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                      ),
                    ),
        
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: CommonButton(
                  titleText: "Update Information",
                onTap: (){
                    Get.snackbar("Successfully Update", "Change Your Information",colorText: Colors.white);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
