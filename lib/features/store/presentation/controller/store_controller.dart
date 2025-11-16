// Path: lib/screens/store/controller/store_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  var selectedCategory = 'All'.obs;
  var cartItems = <Map<String, dynamic>>[].obs;
  var favoriteIds = <String>[].obs;

  var categories = ['All', 'T-shirts', 'Hoodies', 'Shorts', 'Trousers'].obs;

  var products = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedCategory.value = 'All';
    _loadProducts();
    // Add some demo items to cart for testing
    addToCart(_getAllProducts()[0]); // Add first product
    addToCart(_getAllProducts()[1]); // Add second product
  }

  void _loadProducts() {
    products.value = _getAllProducts();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterProducts();
  }

  void filterProducts() {
    if (selectedCategory.value == 'All') {
      _loadProducts();
    } else {
      final allProducts = _getAllProducts();
      products.value = allProducts
          .where((product) => product['category'] == selectedCategory.value)
          .toList();
    }
  }

  List<Map<String, dynamic>> _getAllProducts() {
    return [
      {
        'id': '1',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '2',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '3',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '4',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1529374255404-311a2a4f1fd9?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '5',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '6',
        'name': 'Vintage Tee',
        'price': '45.00',
        'image': 'https://images.unsplash.com/photo-1622445275576-721325763afe?w=400',
        'category': 'T-shirts',
      },
      {
        'id': '7',
        'name': 'Classic Hoodie',
        'price': '65.00',
        'image': 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400',
        'category': 'Hoodies',
      },
      {
        'id': '8',
        'name': 'Pullover Hoodie',
        'price': '70.00',
        'image': 'https://images.unsplash.com/photo-1620799140188-3b2a7c2e0e27?w=400',
        'category': 'Hoodies',
      },
      {
        'id': '9',
        'name': 'Sport Shorts',
        'price': '35.00',
        'image': 'https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=400',
        'category': 'Shorts',
      },
      {
        'id': '10',
        'name': 'Casual Shorts',
        'price': '40.00',
        'image': 'https://images.unsplash.com/photo-1591195524242-c8e8c675a096?w=400',
        'category': 'Shorts',
      },
      {
        'id': '11',
        'name': 'Slim Fit Trousers',
        'price': '55.00',
        'image': 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=400',
        'category': 'Trousers',
      },
      {
        'id': '12',
        'name': 'Cargo Trousers',
        'price': '60.00',
        'image': 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8?w=400',
        'category': 'Trousers',
      },
    ];
  }

  bool isFavorite(String productId) {
    return favoriteIds.contains(productId);
  }

  void toggleFavorite(String productId) {
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
    } else {
      favoriteIds.add(productId);
    }
  }

  bool isInCart(String productId) {
    return cartItems.any((item) => item['id'] == productId);
  }

  void addToCart(Map<String, dynamic> product) {
    if (!isInCart(product['id'])) {
      cartItems.add(product);
      Get.snackbar(
        'Added to Cart',
        '${product['name']} has been added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Already in Cart',
        '${product['name']} is already in your cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    }
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item['id'] == productId);
  }

  void openProductDetail(Map<String, dynamic> product) {
    // Navigate to product detail screen
    Get.toNamed('/product-detail', arguments: product);
    // Or use: Get.to(() => ProductDetailScreen(product: product));
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += double.parse(item['price']);
    }
    return total;
  }
}