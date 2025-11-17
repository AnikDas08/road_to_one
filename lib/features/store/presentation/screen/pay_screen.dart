import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/button/common_button.dart';
import '../../../../config/route/app_routes.dart';
import '../controller/paycontroller.dart';

class PaymentScreen extends StatelessWidget {
  final String? address;
  final String? contact;
  final double? totalAmount;

  PaymentScreen({
    Key? key,
    this.address="DFDSF DSFDF",
    this.contact="3454545",
    this.totalAmount=1231,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(
      PaymentController(
        address: address!,
        contact: contact!,
        totalAmount: totalAmount!,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Payment"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                        text: "Shipping to",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white50,
                    ),
                    SizedBox(height: 12.h),
        
                    // Shipping Address Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Address",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white50,
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: address!,
                            fontSize: 12.sp,
                            maxLines: 3,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12.h),
                          CommonText(
                            text: "Contact",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white50,
                          ),
                          SizedBox(height: 8.h),
                          CommonText(
                            text: contact!,
                            fontSize: 12.sp,
                            maxLines: 3,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
        
                    SizedBox(height: 32.h),
        
                    CommonText(
                      text: "Payment Method",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white50,
                    ),
                    SizedBox(height: 16.h),
        
                    // Payment Methods
                    Obx(() => _buildPaymentOption(
                      controller: controller,
                      icon: Icons.monetization_on,
                      iconColor: Colors.orange,
                      label: 'Cash on Delivery',
                      value: 'cash',
                    )),
                    SizedBox(height: 12.h),
        
                    Obx(() => _buildPaymentOption(
                      controller: controller,
                      icon: Icons.payment,
                      iconColor: Colors.blue,
                      label: 'Pay with Paypal',
                      value: 'paypal',
                    )),
                    SizedBox(height: 12.h),
        
                    Obx(() => _buildPaymentOption(
                      controller: controller,
                      icon: Icons.credit_card,
                      iconColor: Colors.red,
                      label: 'Pay with Card',
                      value: 'card',
                    )),
                    SizedBox(height: 16.h),
        
                    // Add Card Button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(28.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          // Add card logic
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        label: Text(
                          'Add Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        
            // Pay Button
            Padding(
              padding: EdgeInsets.all(20.h),
              child: CommonButton(
                titleText: "Pay",
                onTap: () {
                  Get.toNamed(AppRoutes.successImageScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required PaymentController controller,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    final isSelected = controller.selectedPaymentMethod.value == value;

    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                Icons.circle,
                size: 12.sp,
                color: Colors.black,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// Path: lib/screens/store/controller/shipping_information_controller.dart
// Update this method in your existing ShippingInformationController

void proceedToPay() {
  // Validate inputs


}