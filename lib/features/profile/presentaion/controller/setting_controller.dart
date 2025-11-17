import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

import '../screen/delete_dialog.dart';

class SettingsController extends GetxController {

  void goToOrderHistory() {
    print('Navigate to Order History');
    // Get.to(() => OrderHistoryScreen());
  }

  void goToShippingInformation() {
    print('Navigate to Shipping Information');
    // Get.to(() => ShippingInformationScreen());
  }

  void goToChangePassword() {
    print('Navigate to Change Password');
    // Get.to(() => ChangePasswordScreen());
  }

  void goToAboutUs() {
    print('Navigate to About Us');
    // Get.to(() => AboutUsScreen());
  }

  void deleteAccount() {
    DeleteAccountDialog.show(onConfirm: () {
      Get.toNamed(AppRoutes.deleteScreen);
    });
  }

  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      middleText: 'Are you sure you want to logout?',
      middleTextStyle: TextStyle(color: Colors.white70),
      backgroundColor: Color(0xFF2A2A2A),
      radius: 12,
      confirm: ElevatedButton(
        onPressed: () {
          // Implement logout logic
          Get.back();
          print('User logged out');
          // Get.offAll(() => LoginScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: Text('Logout', style: TextStyle(color: Colors.white)),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white30),
        ),
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}