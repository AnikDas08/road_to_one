import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';

class CreateStoryController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<String?> selectedImage = Rx<String?>(null);

  // Text editor variables
  RxBool textWidgetVisible = false.obs;
  RxBool isEditing = false.obs;
  RxString editedText = "Double tap to edit".obs;
  Rx<Offset> textPosition = Offset(100, 100).obs;
  TextEditingController textController = TextEditingController();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        selectedImage.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void onTextEditTap() {
    textWidgetVisible.value = true;
    isEditing.value = true;
  }

  void enableTextEditing() {
    textController.text = editedText.value;
    isEditing.value = true;
  }

  void saveEditedText(String value) {
    editedText.value = value.isEmpty ? "Tap to edit" : value;
    isEditing.value = false;
  }

  void updateTextPosition(Offset delta) {
    textPosition.value = Offset(
      textPosition.value.dx + delta.dx,
      textPosition.value.dy + delta.dy,
    );
  }

  void createStory() {
    if (selectedImage.value == null) {
      Get.offNamed(AppRoutes.homeNav);
    }
    Get.offNamed(AppRoutes.homeNav);
    Get.snackbar(
      'Success',
      'Story created successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Future.delayed(const Duration(seconds: 1), () => Get.back());
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
