import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/model/progress_model.dart';

class ProgressData {
  int workouts;
  List<PictureItem> pictures;

  ProgressData({
    required this.workouts,
    required this.pictures,
  });
}

class PictureItem {
  String imageUrl;
  String caption;
  DateTime dateAdded;

  PictureItem({
    required this.imageUrl,
    this.caption = '',
    DateTime? dateAdded,
  }) : dateAdded = dateAdded ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'caption': caption,
    'dateAdded': dateAdded.toIso8601String(),
  };

  factory PictureItem.fromJson(Map<String, dynamic> json) => PictureItem(
    imageUrl: json['imageUrl'],
    caption: json['caption'] ?? '',
    dateAdded: DateTime.parse(json['dateAdded']),
  );
}
class MyProgressController extends GetxController {
  final ImagePicker _imagePicker = ImagePicker();

  // Reactive variables
  final _selectedTab = 0.obs;
  final _workoutCount = 4.obs;
  final _pictures = <PictureItem>[].obs;

  // Getters (proper encapsulation)
  int get selectedTab => _selectedTab.value;
  int get workoutCount => _workoutCount.value;
  List<PictureItem> get pictures => _pictures;

  // All data for different time periods
  final Map<int, ProgressData> _progressData = {
    0: ProgressData(workouts: 4, pictures: [
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
        caption: 'Morning workout',
      ),
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
        caption: 'Gym session',
      ),
    ]),
    1: ProgressData(workouts: 20, pictures: [
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
        caption: 'Week 1 progress',
      ),
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
        caption: 'Cardio day',
      ),
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
        caption: 'Strength training',
      ),
    ]),
    2: ProgressData(workouts: 156, pictures: [
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
        caption: 'Year progress',
      ),
    ]),
    3: ProgressData(workouts: 325, pictures: [
      PictureItem(
        imageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
        caption: 'Total journey',
      ),
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
      _pictures.value = List<PictureItem>.from(data.pictures);
    }
  }

  Future<void> addPicture() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        // Show dialog to add caption
        _showAddCaptionDialog(image.path);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showAddCaptionDialog(String imagePath) {
    final TextEditingController captionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text(
          'Add Caption',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: captionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter a caption for your picture...',
            hintStyle: TextStyle(color: Colors.grey[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFb4ff39)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              final newPicture = PictureItem(
                imageUrl: imagePath,
                caption: captionController.text.trim(),
              );

              _pictures.add(newPicture);
              _progressData[_selectedTab.value]?.pictures.add(newPicture);

              Get.back();
              Get.snackbar(
                'Success',
                'Picture added successfully',
                backgroundColor: const Color(0xFFb4ff39),
                colorText: const Color(0xFF000000),
                duration: const Duration(seconds: 2),
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Color(0xFFb4ff39)),
            ),
          ),
        ],
      ),
    );
  }

  void editCaption(int index) {
    if (index >= 0 && index < _pictures.length) {
      final TextEditingController captionController = TextEditingController(
        text: _pictures[index].caption,
      );

      Get.dialog(
        AlertDialog(
          backgroundColor: const Color(0xFF2d2d2d),
          title: const Text(
            'Edit Caption',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: captionController,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter a caption for your picture...',
              hintStyle: TextStyle(color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[700]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFb4ff39)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
            TextButton(
              onPressed: () {
                _pictures[index].caption = captionController.text.trim();
                _pictures.refresh();
                Get.back();
                Get.snackbar(
                  'Success',
                  'Caption updated successfully',
                  backgroundColor: const Color(0xFFb4ff39),
                  colorText: const Color(0xFF000000),
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Color(0xFFb4ff39)),
              ),
            ),
          ],
        ),
      );
    }
  }

  void deletePicture(int index) {
    if (index >= 0 && index < _pictures.length) {
      _pictures.removeAt(index);

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
    super.onClose();
  }
}