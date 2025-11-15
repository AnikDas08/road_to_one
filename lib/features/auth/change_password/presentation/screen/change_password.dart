import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/features/auth/change_password/presentation/widgets/success_dialog.dart';
import 'package:road_project_flutter/utils/app_bar/custom_appbars.dart';

import '../../../../../component/text/common_text.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../controller/change_password_controller_here.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final ChangePasswordController controller =
  Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: ""),
              SizedBox(height: 20.h),

              const CommonText(
                text: "Set New Password",
                fontSize: 36,
                color: AppColors.white50,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: 8.h),

              const CommonText(
                text: "Please Set Your New Password",
                fontSize: 14,
                color: AppColors.white400,
                fontWeight: FontWeight.w400,
              ),

              SizedBox(height: 30.h),

              /// Password Field
              CommonText(
                text: "New Password",
                fontSize: 14.sp,
                color: AppColors.white50,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),

              Obx(() => _buildTextField(
                controller: controller.passwordController,
                hintText: "Enter Password",
                obscureText: !controller.isPasswordVisible.value,
                validator: controller.validatePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFF757575),
                    size: 20.sp,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              )),

              SizedBox(height: 20.h),

              /// Confirm Password Field
              CommonText(
                text: "Confirm New Password",
                fontSize: 14.sp,
                color: AppColors.white50,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 8.h),

              Obx(() => _buildTextField(
                controller: controller.confirmController,
                hintText: "Enter Password",
                obscureText: !controller.isConfirmPasswordVisible.value,
                validator: controller.validateConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmPasswordVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color(0xFF757575),
                    size: 20.sp,
                  ),
                  onPressed:
                  controller.toggleConfirmPasswordVisibility,
                ),
              )),
              SizedBox(height: 20.h,),
              CommonButton(
                  titleText: "Change Password",
                  onTap: () {
                    SuccessDialog.show(Get.context!);
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
          color: const Color(0xFF757575),
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
          borderSide: const BorderSide(
            color: Color(0xFF424242),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Color(0xFF424242),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Color(0xFF757575),
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
