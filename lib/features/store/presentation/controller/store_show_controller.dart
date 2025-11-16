// Path: lib/screens/store/controller/product_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  late Map<String, dynamic> product;

  var isFavorite = false.obs;
  var selectedSize = 'M'.obs;
  var quantity = 1.obs;
  var selectedColor = 'black'.obs;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];

  final List<Map<String, dynamic>> colors = [
    {'name': 'black', 'color': Colors.black},
    {'name': 'red', 'color': Colors.red},
    {'name': 'yellow', 'color': Colors.yellow},
    {'name': 'green', 'color': Colors.green},
    {'name': 'blue', 'color': Colors.blue},
    {'name': 'purple', 'color': Colors.purple},
    {'name': 'white', 'color': Colors.white},
    {'name': 'grey', 'color': Colors.grey},
  ];

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Map<String, dynamic>;
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(String color) {
    selectedColor.value = color;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() {
    Get.snackbar(
      'Added to Cart',
      '${product['name']} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  void buyWithShop() {
    Get.snackbar(
      'Buy with Shop',
      'Proceeding to checkout...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }
}