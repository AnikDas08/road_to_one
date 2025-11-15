import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    this.icon,
    required this.title,
    this.image = "",
    this.disableDivider = false,
    this.onTap,
    this.color = AppColors.black,
    this.vertical = 4,
    this.horizontal = 24,
    this.disableIcon = false,
  });

  final IconData? icon;
  final String title;
  final String image;
  final bool disableDivider;
  final bool disableIcon;
  final VoidCallback? onTap;
  final Color color;
  final double vertical;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.black50),
            boxShadow: [
              BoxShadow(
                color: Color(0x408E8E8E),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.black50,
                  borderRadius: BorderRadius.circular(100),
                ),
                child:
                    SvgPicture.asset(
                        image,
                      height: 24.h,
                      width: 24.w,
                    )
              ),
              SizedBox(width: 10.w),
              CommonText(
                text: title,
                color: AppColors.black400,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
