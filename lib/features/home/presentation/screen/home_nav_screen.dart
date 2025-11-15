import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:road_project_flutter/features/business/presentation/screen/business_screen.dart';
import 'package:road_project_flutter/features/gym_screen/presentaion/screens/gymscreen.dart';
import 'package:road_project_flutter/features/mealscreen/presentation/screen/meal_screen.dart';
import 'package:road_project_flutter/features/profile/presentaion/screen/profile_screen.dart';
import 'package:road_project_flutter/features/store/presentation/screen/store_screen.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_string.dart';
import 'home_screen.dart';

class HomeNavScreen extends StatelessWidget {
  HomeNavScreen({super.key}) {
    Get.put(HomeNavController());
  }

  final List<Map<String, String>> _navItems = [
    {"icon": "assets/icons/home.svg"},
    {"icon": "assets/icons/profile.svg"},
    {"icon": "assets/icons/defence.svg"},
    {"icon": "assets/icons/medias.svg"},
    {"icon": "assets/icons/buessness.svg"},
    {"icon": "assets/icons/store.svg"},
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeNavController>();

    return Obx(
          () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            controller.selectedIndex.value == 0 ? HomeScreen() : Container(),
            controller.selectedIndex.value== 1 ? ProfileScreen():Container(),
            controller.selectedIndex.value == 2 ? GymScreen() : Container(),
            controller.selectedIndex.value == 3 ? MealScreen() : Container(),
            controller.selectedIndex.value == 4 ? BusinessScreen() : Container(),
            controller.selectedIndex.value == 5 ? StoreScreen() : Container(),
          ],
        ),

        /// 🟢 Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.r,
                offset: Offset(0, -2.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.r),
              topRight: Radius.circular(4.r),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xff151515),
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeIndex,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: const Color(0xffA1A1A1),
              showSelectedLabels: false,  // hide text
              showUnselectedLabels: false, // hide text
              iconSize: 24.sp,
              elevation: 0,
              items: List.generate(_navItems.length, (index) {
                final isSelected = controller.selectedIndex.value == index;
                return BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 8.h, bottom: 6.h),
                    child: SvgPicture.asset(
                      _navItems[index]["icon"]!,
                      width: 32.w,
                      height: 32.h,
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.primaryColor : const Color(0xffA1A1A1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  label: '', // empty label
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeNavController extends GetxController {
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final argIndex = Get.arguments?['index'];
    if (argIndex != null) {
      selectedIndex.value = argIndex;
    }
  }

  void changeIndex(int index) {
    if (index == selectedIndex.value) return; // Prevent rebuilding if same index
    selectedIndex.value = index;
  }
}