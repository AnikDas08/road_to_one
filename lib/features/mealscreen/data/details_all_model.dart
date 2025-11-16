import 'package:get/get.dart';

class MealItem {
  final String id;
  final String name;
  final String imageUrl;
  final RxBool isLocked;

  MealItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required bool isLocked,
  }) : isLocked = isLocked.obs;
}