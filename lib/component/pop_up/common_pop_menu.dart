import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../services/storage/storage_services.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_string.dart';
import '../../utils/helpers/other_helper.dart';
import '../button/common_button.dart';
import '../text/common_text.dart';
import '../text_field/common_text_field.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
    this.height = 30,
    this.selectedColor = AppColors.primaryColor,
    this.unselectedColor = Colors.transparent,
    this.style,
    this.isContainer = false,
    this.iconColor = AppColors.black,
    this.iconData = Icons.keyboard_arrow_down_outlined,
  });

  static Future<void> closeDialog(BuildContext context) async {
    Navigator.of(context).pop();
  }

  final List items;
  final List selectedItem;
  final Color selectedColor;
  final Color iconColor;
  final Color unselectedColor;
  final double height;
  final Function(int index) onTap;
  final TextStyle? style;
  final bool isContainer;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: PopupMenuButton<String>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: selectedColor),
        ),
        offset: const Offset(1, 1),
        padding: EdgeInsets.zero,
        itemBuilder:
            (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'option1',
                child: Column(
                  children: List.generate(
                    items.length,
                    (index) => GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pop();
                        onTap(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(color: selectedColor),
                                color:
                                    selectedItem.contains(
                                          items[index].toString(),
                                        )
                                        ? selectedColor
                                        : unselectedColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(items[index].toString(), style: style),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
        icon: Padding(
          padding: EdgeInsets.only(left: isContainer ? 40 : 0),
          child: Icon(iconData, color: iconColor, size: height),
        ),
      ),
    );
  }
}

logOutPopUp() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      // Controller for the animation
      return AnimationPopUp(
        child: AnimatedBuilder(
          animation: CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeIn,
          ),
          builder: (context, child) {
            return FadeTransition(
              opacity: ModalRoute.of(context)!.animation!,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                contentPadding: EdgeInsets.all(12.sp),
                title: const CommonText(
                  text: AppString.youSureWantToLogout,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          titleText: AppString.no,
                          borderWidth: 1.5,
                          borderColor: AppColors.primaryColor,
                          buttonColor: AppColors.transparent,
                          titleColor: AppColors.primaryColor,
                          onTap: () => Get.back(),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CommonButton(
                          titleText: AppString.yes,
                          onTap: () {
                            LocalStorage.removeAllPrefData();
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

deletePopUp({
  required TextEditingController controller,
  required VoidCallback onTap,
  bool isLoading = false,
}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AnimationPopUp(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.only(bottom: 12),
          title: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CommonText(
                    text: AppString.areYouSure,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    maxLines: 1,
                    bottom: 24.h,
                  ),
                ),
                CommonText(
                  text: "Give your password to confirm your account.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 4,
                  bottom: 20.h,
                ),
                CommonTextField(
                  controller: controller,
                  hintText: "Enter Your Password",
                  isPassword: true,
                  validator: OtherHelper.validator,
                  borderColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: AppString.cancel,
                    titleColor: AppColors.black,
                    borderColor: AppColors.black,
                    buttonColor: AppColors.transparent,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    titleText: AppString.done,
                    titleColor: AppColors.white,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Get.back();
                        confirmDelete();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
confirmDelete({
  bool isLoading = false,
}) {
  final formKey = GlobalKey<FormState>();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AnimationPopUp(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.only(bottom: 12),
          title: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CommonText(
                    text: "Do you want to Delete you Account?",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    maxLines: 2,
                    bottom: 24.h,
                  ),
                ),
                CommonText(
                  text: "After 30 days your account will be deleted.All the data are remove from your account.",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  maxLines: 4,
                  bottom: 20.h,
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: AppString.cancel,
                    titleColor: AppColors.black,
                    borderColor: AppColors.black,
                    buttonColor: AppColors.transparent,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    titleText: "Confirm",
                    titleColor: AppColors.white,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Get.back();

                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}


logOutPopUps() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AnimationPopUp(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          contentPadding: EdgeInsets.all(12.sp),
          title: const CommonText(
            text: AppString.youSureWantToLogout,
            maxLines: 2,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: AppString.no,
                    borderWidth: 1.5,
                    borderColor: AppColors.primaryColor,
                    buttonColor: AppColors.transparent,
                    titleColor: AppColors.primaryColor,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    titleText: AppString.yes,
                    onTap: () async {
                      Navigator.of(context).pop();
                      LocalStorage.removeAllPrefData();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

/*simpleDialog() async {
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.all(20.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Image
            Image.asset(
              "assets/images/succes_image.png", // 👉 put your image in assets folder
              height: 100.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20.h),

            // ✅ Title
            Text(
              AppString.password_change_now,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30.h),

            // ✅ Button
            CustomButton(text: AppString.back_to_login_button, isSelected: true, onTap: (){Get.offAllNamed(AppRoutes.signIn);})
          ],
        ),
      );
    },
  );
}*/

void logoutDialog({
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AnimationPopUp(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: const EdgeInsets.only(bottom: 12),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CommonText(
                  text: AppString.logout_correct,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  maxLines: 2,
                  bottom: 24.h,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: AppString.no_button,
                    titleColor: AppColors.black,
                    borderColor: AppColors.black,
                    buttonColor: AppColors.transparent,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CommonButton(
                    titleText: AppString.yes_button,
                    titleColor: AppColors.white,
                    buttonRadius: 4.r,
                    buttonHeight: 48.h,
                    onTap: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}



class AnimationPopUp extends StatefulWidget {
  const AnimationPopUp({super.key, required this.child});

  final Widget child;

  @override
  AnimationPopUpState createState() => AnimationPopUpState();
}

class AnimationPopUpState extends State<AnimationPopUp>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> closeDialog() async {
    await _animationController.reverse();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FadeTransition(
            opacity: ModalRoute.of(context)!.animation!,
            child: widget.child,
          ),
        );
      },
    );
  }
}
