import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  var selectedCountryCode = '+880'.obs;
  var selectedCountryFlag = '🇧🇩'.obs;

  void updateCountry(Country country) {
    selectedCountryCode.value = '+${country.phoneCode}';
    selectedCountryFlag.value = country.flagEmoji;
  }

  void getOTP() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your mobile number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.7),
        colorText: Colors.white,
      );
      return;
    }

    Get.snackbar(
      'OTP Sent',
      'OTP has been sent to ${selectedCountryCode.value} ${emailController.text}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFCDFF00).withOpacity(0.7),
      colorText: Colors.black,
    );
  }

}
