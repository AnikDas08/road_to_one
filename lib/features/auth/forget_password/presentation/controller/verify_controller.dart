import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

class VerifyController extends GetxController {
  var otpCode = ''.obs;
  final email = '**********123@gmail.com';

  void updateOTPFromTextField(String value) {
    if (value.length <= 6) {
      otpCode.value = value;
    }
  }

  void verifyOTP() {
    if (otpCode.value.length == 6) {
      Get.toNamed(AppRoutes.changePassword);
    } else {
      Get.snackbar(
        'Error',
        'Please enter complete 6-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
    }
  }
}
