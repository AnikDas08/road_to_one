import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/route/app_routes.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_string.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(
          children: [
            /// Already Have Account text
            TextSpan(
              text: "Already have an account?  ",
              style: GoogleFonts.roboto(
                color: AppColors.white50,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            /// Sign in clickable text
            TextSpan(
              text: "Sign In",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(AppRoutes.signIn);
                },
              style: GoogleFonts.roboto(
                color: AppColors.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}