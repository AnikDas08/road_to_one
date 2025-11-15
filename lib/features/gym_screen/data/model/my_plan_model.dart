import 'package:get/get.dart';

class PlanModel {
  final String id;
  final String title;
  final RxBool isLocked;

  PlanModel({
    required this.id,
    required this.title,
    required bool isLocked,
  }) : isLocked = isLocked.obs;
}