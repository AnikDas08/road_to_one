import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';
import '../../services/storage/storage_services.dart';
import '../../../config/route/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    /// 🔥 Status bar white for splash also
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    /// Animation setup
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    /// Delay & navigate
    Future.delayed(const Duration(seconds: 3), () async {
      final isLoggedIn = LocalStorage.isLogIn;

      Get.offAllNamed(AppRoutes.onBoardingFirst);

      /*
      if (isLoggedIn) {
        bool isValidSession = await SignInController().checkProfile();
        if (isValidSession) {
          Get.offAllNamed(AppRoutes.homeNav);
        } else {
          Get.offAllNamed(AppRoutes.onboarding);
        }
      } else {
        Get.offAllNamed(AppRoutes.onboarding);
      }
      */
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fade,
        child: Center(
          child: CommonText(
            text: "Road to 1%",
            fontSize: 40.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
