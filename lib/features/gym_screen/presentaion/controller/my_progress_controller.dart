import 'dart:ui';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/progress_model.dart';

class MyProgressController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  // Reactive variables
  final _selectedTab = 0.obs;
  final _workoutCount = 4.obs;
  final _pictures = <String>[].obs;

  // Getters (proper encapsulation)
  int get selectedTab => _selectedTab.value;
  int get workoutCount => _workoutCount.value;
  List<String> get pictures => _pictures;

  // All data for different time periods - made final and initialized properly
  final Map<int, ProgressData> _progressData = {
    0: ProgressData(workouts: 4, pictures: [
      'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
    ]),
    1: ProgressData(workouts: 20, pictures: [
      'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
      'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400',
      'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=400',
      'https://images.unsplash.com/photo-1541534741688-6078c6bfb5c5?w=400',
      'https://images.unsplash.com/photo-1605296867424-35fc25c9212a?w=400',
      'https://images.unsplash.com/photo-1623874228601-f4193c7b1818?w=400',
      'https://images.unsplash.com/photo-1598971639058-fab3c3109a00?w=400',
      'https://images.unsplash.com/photo-1594381898411-846e7d193883?w=400',
      'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=400',
    ]),
    2: ProgressData(workouts: 156, pictures: [
      'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
    ]),
    3: ProgressData(workouts: 325, pictures: [
      'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
      'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400',
    ]),
  };

  @override
  void onInit() {
    super.onInit();
    _loadTabData(0);
  }

  void selectTab(int index) {
    _selectedTab.value = index;
    _loadTabData(index);
  }

  void _loadTabData(int tabIndex) {
    final data = _progressData[tabIndex];
    if (data != null) {
      _workoutCount.value = data.workouts;
      // Create a new list to avoid reference issues
      _pictures.value = List<String>.from(data.pictures);
    }
  }

  Future<void> addPicture() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        // Add to current reactive list
        _pictures.add(image.path);

        // Update the data for current tab
        _progressData[_selectedTab.value]?.pictures.add(image.path);

        Get.snackbar(
          'Success',
          'Picture added successfully',
          backgroundColor: const Color(0xFFb4ff39),
          colorText: const Color(0xFF000000),
          duration: const Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add picture: ${e.toString()}',
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deletePicture(int index) {
    if (index >= 0 && index < _pictures.length) {
      _pictures.removeAt(index);

      // Update the data for current tab
      final currentTabData = _progressData[_selectedTab.value];
      if (currentTabData != null && index < currentTabData.pictures.length) {
        currentTabData.pictures.removeAt(index);
      }

      Get.snackbar(
        'Deleted',
        'Picture deleted successfully',
        backgroundColor: const Color(0xFF424242),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}

class ProgressData {
  int workouts;
  List<String> pictures;

  ProgressData({
    required this.workouts,
    required this.pictures,
  });
}