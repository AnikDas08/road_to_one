import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

import '../../data/details_all_model.dart';

class BreakfastController extends GetxController {
  final RxList<MealItem> meals = <MealItem>[
    MealItem(
      id: '1',
      name: 'Oats',
      imageUrl: 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?w=400',
      isLocked: false,
    ),
    MealItem(
      id: '2',
      name: 'Pancakes',
      imageUrl: 'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=400',
      isLocked: true,
    ),
    MealItem(
      id: '3',
      name: 'Eggs',
      imageUrl: 'https://images.unsplash.com/photo-1608039829572-78524f79c4c7?w=400',
      isLocked: true,
    ),
    MealItem(
      id: '4',
      name: 'Smoothie',
      imageUrl: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=400',
      isLocked: true,
    ),
    MealItem(
      id: '5',
      name: 'Toast',
      imageUrl: 'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=400',
      isLocked: true,
    ),
    MealItem(
      id: '6',
      name: 'Yogurt',
      imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400',
      isLocked: true,
    ),
  ].obs;
  String mealType="";

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null) {
      final meal = args as String;
      if (meal == 'breakfast') {
        mealType = "Breakfast";
      } else if (meal == 'lunch') {
        mealType = "Lunch";
      } else if (meal == 'dinner') {
        mealType = "Dinner";
      }
    }
  }

  void onMealTap(int index) {
    if (meals[index].isLocked.value) {
      showLockedMessage(meals[index].name);
    } else {
      openMealDetail(meals[index]);
    }
  }

  void openMealDetail(MealItem meal) {
    Get.toNamed(AppRoutes.mealDetailScreen);
    // Navigate to meal detail screen
    // Get.to(() => MealDetailScreen(meal: meal));
  }

  void showLockedMessage(String mealName) {
    Get.snackbar(
      'Locked',
      '$mealName is locked. Complete previous meals to unlock.',
      backgroundColor: Colors.grey[800],
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      icon: Icon(Icons.lock, color: Colors.white),
    );
  }

  void unlockMeal(int index) {
    if (index >= 0 && index < meals.length) {
      meals[index].isLocked.value = false;
      Get.snackbar(
        'Unlocked!',
        '${meals[index].name} is now unlocked',
        backgroundColor: const Color(0xFFb4ff39),
        colorText: Colors.black,
        duration: const Duration(seconds: 2),
        icon: Icon(Icons.lock_open, color: Colors.black),
      );
    }
  }

  void unlockMealById(String mealId) {
    final index = meals.indexWhere((m) => m.id == mealId);
    if (index != -1) {
      unlockMeal(index);
    }
  }

  void unlockNextMeal() {
    final index = meals.indexWhere((m) => m.isLocked.value == true);
    if (index != -1) {
      unlockMeal(index);
    }
  }

  void lockMeal(int index) {
    if (index >= 0 && index < meals.length) {
      meals[index].isLocked.value = true;
    }
  }
}