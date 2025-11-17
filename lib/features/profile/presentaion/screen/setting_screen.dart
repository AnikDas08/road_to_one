import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/config/route/app_routes.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/delete_dialog.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../controller/setting_controller.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "Setting"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Order History
            _buildSettingItem(
              icon: Icons.receipt_long_outlined,
              title: 'Order History',
              onTap: (){Get.toNamed(AppRoutes.orderHistoryScreen);},
            ),

            _buildDivider(),

            // Shipping Information
            _buildSettingItem(
              icon: Icons.local_shipping_outlined,
              title: 'Shipping Information',
              onTap: ()=>Get.toNamed(AppRoutes.shippingInformationUpdateScreen),
            ),

            _buildDivider(),

            // Change Password
            _buildSettingItem(
              icon: Icons.lock_outline,
              title: 'Change Password',
              onTap: ()=>Get.toNamed(AppRoutes.changePassword),
            ),

            _buildDivider(),

            // About us
            _buildSettingItem(
              icon: Icons.info_outline,
              title: 'About us',
              onTap: ()=>Get.toNamed(AppRoutes.aboutUsScreen),
            ),

            _buildDivider(),

            // Delete Account
            _buildSettingItem(
              icon: Icons.delete_outline,
              title: 'Delete Account',
              onTap: controller.deleteAccount,
            ),

            _buildDivider(),

            // Logout
            _buildSettingItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: (){
                LogoutDialog.show(
                    onConfirm: (){
                  Get.offAllNamed(AppRoutes.signIn);
                });
              },
            ),

            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: AppColors.upcolor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.grey,
                  size: 30.sp,
                ),
                SizedBox(width: 8.w,),
                CommonText(text: title,fontSize: 16.sp,fontWeight: FontWeight.w400,color: AppColors.white50,)
              ],
            ),
            SizedBox(width: 16.w),
            Icon(
              Icons.chevron_right,
              color: Colors.white70,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.1),
      height: 1,
      thickness: 1,
    );
  }
}