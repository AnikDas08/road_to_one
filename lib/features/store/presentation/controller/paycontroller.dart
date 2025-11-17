import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = 'cash'.obs;

  // Get address and contact from previous screen
  final String address;
  final String contact;
  final double totalAmount;

  PaymentController({
    required this.address,
    required this.contact,
    required this.totalAmount,
  });

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void processPayment() {
    // Implement payment logic here
    print('Processing payment of \$${totalAmount.toStringAsFixed(2)} via ${selectedPaymentMethod.value}');

    // Show success dialog or navigate to success screen
    Get.snackbar(
      'Payment Processing',
      'Your payment is being processed',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}