import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/utils/app_bar/custom_appbars.dart';
import '../../../../../component/button/common_button.dart';
import '../../../../../component/text/common_text.dart';
import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../widgets/already_accunt_rich_text.dart';
import '../widgets/sign_up_all_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // Simulate sign up process
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
        // Navigate or show success message
      });
    }
    //Get.toNamed(AppRoutes.signIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: "",showBackButton: true,),


              SizedBox(height: 20.h),

              /// Sign up Title
              const CommonText(
                text: "Sign up",
                fontSize: 36,
                color: AppColors.white50,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(height: 8.h),

              /// Subtitle
              const CommonText(
                text: "Sign up and elevate your fitness journey with us",
                fontSize: 14,
                color: AppColors.white700,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                maxLines: 2,
              ),

              SizedBox(height: 32.h),

              /// Form Fields
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// All Text Fields here
                    const SignUpAllField(),

                    SizedBox(height: 32.h),

                    /// Sign Up Button
                    CommonButton(
                      titleText: "Sign up",
                      isLoading: isLoading,
                      buttonColor: AppColors.primaryColor,
                      titleColor: AppColors.black,
                      buttonRadius: 500,
                      onTap: (){
                        Get.toNamed(AppRoutes.verifyUser);
                      },
                    ),

                    SizedBox(height: 24.h),

                    /// Already have an account
                    const AlreadyAccountRichText(),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}