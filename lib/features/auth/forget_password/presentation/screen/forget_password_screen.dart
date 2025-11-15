import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/features/auth/forget_password/presentation/controller/forget_password_controller.dart';
import 'package:road_project_flutter/features/auth/phone_signup/presentation/controller/phonesignupcontroller.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../signup/presentation/controller/sign_up_controller.dart';
import 'package:country_picker/country_picker.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordController controller = Get.put(ForgetPasswordController());

    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),

              // Title
              CommonText(
                text: "Forget Password",
                fontSize: 36.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white50,
              ),

              const SizedBox(height: 8),

              // Subtitle
              CommonText(
                text: "Enter your email and get OTP for verification",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white700,
              ),

              SizedBox(height: 40.h),

              // Mobile Number Label
              CommonText(
                text: "Email Address",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.white50,
              ),

              const SizedBox(height: 12),

              // Phone Input Field
              _buildTextField(
                controller: controller.emailController,
                hintText: "Enter email address",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 40.h),
              CommonButton(
                titleText: "Get Otp",
                onTap: (){
                  Get.toNamed(AppRoutes.verifyAccount);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: GoogleFonts.roboto(
        color: AppColors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.roboto(
          color: Color(0xFF757575),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Color(0xFF424242),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Color(0xFF424242),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Color(0xFF757575),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
      validator: validator,
    );
  }
}