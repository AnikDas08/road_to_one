import 'package:get/get.dart';

import '../../data/models/cart_item.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Sample data
    cartItems.addAll([
      CartItem(
        id: '1',
        name: 'T Shirt',
        description: 'pinky Ponky',
        image: 'https://via.placeholder.com/80',
        price: 600,
        quantity: 1,
      ),
      CartItem(
        id: '2',
        name: 'T Shirt',
        description: 'pinky Ponky',
        image: 'https://via.placeholder.com/80',
        price: 600,
        quantity: 1,
      ),
      CartItem(
        id: '3',
        name: 'T Shirt',
        description: 'pinky Ponky',
        image: 'https://via.placeholder.com/80',
        price: 600,
        quantity: 1,
      ),
    ]);
  }

  void incrementQuantity(String id) {
    final item = cartItems.firstWhere((item) => item.id == id);
    item.quantity.value++;
  }

  void decrementQuantity(String id) {
    final item = cartItems.firstWhere((item) => item.id == id);
    if (item.quantity.value > 1) {
      item.quantity.value--;
    }
  }

  void removeItem(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity.value));
  }

  double get taxes => 5.00;
  double get otherFees => 0.00;
  double get deliveryFees => 10.00;

  double get total => subtotal + taxes + otherFees + deliveryFees;

  void continueShoppingPressed() {
    Get.snackbar('Continue Shopping', 'Navigating to shopping page');
  }

  void checkoutPressed() {
    Get.snackbar('Checkout', 'Proceeding to checkout');
  }
}