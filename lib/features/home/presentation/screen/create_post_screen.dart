import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/button/common_button.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/utils/app_bar/custom_appbars.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';
import '../controller/create_post_controller_here.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  final CreatePostController controller = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.upcolor,
        appBar: AppBarNew(title: "Create Post",),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Upload Container
            GestureDetector(
              onTap: controller.pickImage,
              child: Obx(() => Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.grey.shade800,
                    width: 1.5,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.selectedImage.value != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    controller.selectedImage.value!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.upload_outlined,
                        color: Colors.grey.shade400,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 20),
            // Caption Label
            CommonText(
                text: "Caption",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.white50,
            ),
            const SizedBox(height: 8),
            // Caption TextField
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller.captionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type Here',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const Spacer(),
            // Create Post Button
            CommonButton(
                titleText: "Create Post",
              onTap: (){
                  Get.toNamed(AppRoutes.homeNav);
              },
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }
}