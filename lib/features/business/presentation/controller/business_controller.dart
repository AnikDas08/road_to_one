import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

class BusinessController extends GetxController {
  // Observable list of plans with simple Map structure
  var plans = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadPlans();
  }

  void _loadPlans() {
    plans.value = [
      {
        'id': '1',
        'title': 'Emotional Intelligent & Self Management',
        'isLocked': false,
      },
      {
        'id': '2',
        'title': 'Strategic Thinking & Problem Solving',
        'isLocked': true,
      },
      {
        'id': '3',
        'title': 'Goal setting, Planning & Execution',
        'isLocked': true,
      },
      {
        'id': '4',
        'title': 'Communication & Influence',
        'isLocked': true,
      },
      {
        'id': '5',
        'title': 'Growth Mindset & Resilience',
        'isLocked': true,
      },
    ];
  }

  void openPlan(Map<String, dynamic> plan) {
    Get.toNamed(AppRoutes.personalDetailsScreen);
  }

  void showLockedMessage() {
    Get.snackbar(
      'Locked',
      'This plan is currently locked. Complete previous plans to unlock.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  // Method to unlock a plan
  void unlockPlan(String planId) {
    final planIndex = plans.indexWhere((plan) => plan['id'] == planId);
    if (planIndex != -1) {
      plans[planIndex]['isLocked'] = false;
      plans.refresh(); // Refresh the observable list
    }
  }

  // Method to check if user can unlock next plan
  void checkAndUnlockNext(String completedPlanId) {
    final completedIndex = plans.indexWhere((plan) => plan['id'] == completedPlanId);
    if (completedIndex != -1 && completedIndex < plans.length - 1) {
      plans[completedIndex + 1]['isLocked'] = false;
      plans.refresh(); // Refresh the observable list
    }
  }

  // Check if a plan is locked
  bool isPlanLocked(Map<String, dynamic> plan) {
    return plan['isLocked'] ?? false;
  }
}