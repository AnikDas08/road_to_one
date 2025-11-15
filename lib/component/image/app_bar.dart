import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

class AppBarNew extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton; // condition

  const AppBarNew({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true, // 🔥 default TRUE
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.upcolor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
          child: Row(
            children: [
              // 🔥 Conditionally show/hide back button
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                  onPressed: onBackPressed ?? () => Get.back(),
                )
              else
                const SizedBox(width: 48),

              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 48),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
