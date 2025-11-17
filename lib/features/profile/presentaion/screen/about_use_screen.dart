import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

import '../../../../component/text/common_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroudColor,
      appBar: AppBarNew(title: "About Us"),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: CommonText(
                text: "Printers in the 1500s scrambled the words from Cicero's De Finibus Bonorum et Malorum'' after mixing the words in each sentence.\n\nThe familiar lorem ipsum dolor sit amet text emerged when 16th-century printers adapted Cicero's original work, beginning with the phrase\n\ndolor sit amet consectetur.\n\nThey abbreviated dolorem (meaning pain) to lorem, which carries no meaning in Latin.Ipsum translates to itself, and the text frequently includes phrases such as consectetur adipiscing elit ut labore et dolore.\n\nThese Latin fragments, derived from Cicero's philosophical treatise, were rearranged to create the standard dummy text that has become a fundamental tool in design and typography across generations.",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                maxLines: 18,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
