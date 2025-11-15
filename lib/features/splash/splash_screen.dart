import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:haircutmen_user_app/utils/extensions/extension.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import '../../../config/route/app_routes.dart';
import 'package:get/get.dart';
import '../../component/image/common_image.dart';
import '../../services/storage/storage_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      final isLoggedIn = LocalStorage.isLogIn;

      /*if (isLoggedIn) {
        bool isValidSession=await SignInController().checkProfile();

        if (isValidSession) {
          Get.offAllNamed(AppRoutes.homeNav);
        } else {
          Get.offAllNamed(AppRoutes.onboarding);
        }
      } else {
        Get.offAllNamed(AppRoutes.onboarding);
      }*/
      //Get.offAllNamed(AppRoutes.onboarding);
      Get.offAllNamed(AppRoutes.onBoardingFirst);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: CommonText(
            color: Colors.white,
              fontSize: 40.sp,
              fontWeight: FontWeight.w600,
              text: "Road to 1%"
          ),
        ),
      ),
    );
  }
}
