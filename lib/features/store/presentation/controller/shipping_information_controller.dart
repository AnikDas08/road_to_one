// Path: lib/screens/store/controller/shipping_information_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingInformationController extends GetxController {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  var totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Get total amount from arguments or calculate from cart
    if (Get.arguments != null && Get.arguments['total'] != null) {
      totalAmount.value = Get.arguments['total'];
    } else {
      // Calculate from cart items if needed
      totalAmount.value = 87.00; // Default value
    }

    // Load saved address and contact if available
    loadSavedData();
  }

  void loadSavedData() {
    // Load from local storage or user profile
    addressController.text = 'House C17/A, B Block, Dhanmondi Dhaka Bangladesh';
    contactController.text = '+61 1234 5678 910';
  }

  void proceedToPay() {
    // Validate inputs
    if (addressController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (contactController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your contact number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    // Proceed to payment
    Get.snackbar(
      'Processing',
      'Proceeding to payment...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    // Navigate to payment screen
    // Get.toNamed('/payment', arguments: {
    //   'address': addressController.text,
    //   'contact': contactController.text,
    //   'total': totalAmount.value,
    // });
  }

  @override
  void onClose() {
    addressController.dispose();
    contactController.dispose();
    super.onClose();
  }
}