// Path: lib/screens/store/controller/shipping_information_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingInformationUpdateController extends GetxController {
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

}