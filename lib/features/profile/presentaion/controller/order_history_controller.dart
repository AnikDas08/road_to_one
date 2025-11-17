import 'package:get/get.dart';

import '../../data/order_model.dart';

class OrderHistoryController extends GetxController {

  // Static order data
  var orders = <Order>[
    Order(
      id: '1',
      productName: 'Vintage Tee',
      productImage: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      itemCount: 1,
      date: 'Yesterday',
    ),
    Order(
      id: '2',
      productName: 'Vintage Tee',
      productImage: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      itemCount: 6,
      date: '7 Days ago',
    ),
    Order(
      id: '3',
      productName: 'Vintage Tee',
      productImage: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      itemCount: 2,
      date: '3 weeks ago',
    ),
    Order(
      id: '4',
      productName: 'Vintage Tee',
      productImage: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
      itemCount: 4,
      date: '1 Month ago',
    ),
  ].obs;

  void viewOrderDetails(Order order) {
    print('Viewing order details: ${order.id}');
    // Navigate to order details screen
    // Get.to(() => OrderDetailsScreen(order: order));
  }
}