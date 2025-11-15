import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  final captionController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void createPost() {
    if (selectedImage.value != null && captionController.text.isNotEmpty) {
      // Handle post creation
      Get.snackbar('Success', 'Post created successfully');
    } else {
      Get.snackbar('Error', 'Please add image and caption');
    }
  }

  @override
  void onClose() {
    captionController.dispose();
    super.onClose();
  }
}