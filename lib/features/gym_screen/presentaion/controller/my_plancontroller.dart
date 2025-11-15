import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

import '../../data/model/my_plan_model.dart';

class MyPlanController extends GetxController {
  final plans = <PlanModel>[
    PlanModel(id: '1', title: 'Push Day', isLocked: false),
    PlanModel(id: '2', title: 'Pull Day', isLocked: true),
    PlanModel(id: '3', title: 'Leg Day', isLocked: true),
  ].obs;

  void openPlan(PlanModel plan) {
    Get.toNamed(AppRoutes.planDetails);
    // Navigate to plan detail screen
    // Get.to(() => PlanDetailScreen(plan: plan));
  }

  void showLockedMessage() {
    Get.snackbar(
      'Locked',
      'This plan is locked. Complete previous plans to unlock.',
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: Icon(Icons.lock, color: Colors.white),
    );
  }

  void unlockPlan(String planId) {
    final plan = plans.firstWhere((p) => p.id == planId);
    plan.isLocked.value = false;
  }

  void lockPlan(String planId) {
    final plan = plans.firstWhere((p) => p.id == planId);
    plan.isLocked.value = true;
  }

  void unlockNextPlan() {
    // Unlock the next locked plan
    final lockedPlan = plans.firstWhereOrNull((p) => p.isLocked.value == true);
    if (lockedPlan != null) {
      lockedPlan.isLocked.value = false;
      Get.snackbar(
        'Plan Unlocked!',
        '${lockedPlan.title} is now unlocked',
        backgroundColor: const Color(0xFFb4ff39),
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
        icon: Icon(Icons.lock_open, color: Colors.black),
      );
    }
  }
}