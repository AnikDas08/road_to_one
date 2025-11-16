import 'package:get/get.dart';

class CartItem {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  RxInt quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required int quantity,
  }) : quantity = quantity.obs;
}