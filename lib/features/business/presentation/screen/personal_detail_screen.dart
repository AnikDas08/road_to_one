import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_project_flutter/component/text/common_text.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/image/app_bar.dart';

class PersonalDetailScreen extends StatelessWidget {
  const PersonalDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.h), // 👈 AppBar height increased
          child: AppBarNew(title:"Emotional Intelligent & Self Management"),),
      body: Column(
        children: [
          SizedBox(height: 20.h,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CommonText(text: "This section focuses on helping individuals understand and regulate their emotions while maintaining mental clarity under pressure. It includes techniques to identify emotional triggers, manage stress effectively, and communicate with empathy. Through self-awareness exercises and decision-making strategies, individuals can strengthen their relationships and develop emotional stability that supports both personal and professional success — fostering balance, confidence, and emotional growth.",
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white54,
            textAlign: TextAlign.left,
            maxLines: 8,
            ),
          )
        ],
      )
    );
  }
}
