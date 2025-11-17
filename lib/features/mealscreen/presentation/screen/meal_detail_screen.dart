import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';
import 'package:road_project_flutter/utils/constants/app_colors.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarNew(title: "Oats"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ingredients Section
            Text(
              'Ingredients:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '½ cup rolled oats, 1 cup water or milk, a pinch of salt, ½ tbsp maple syrup, and 1-2 tbsp brown sugar.',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
                height: 1.6,
              ),
            ),
            SizedBox(height: 32),

            // Method Section
            Text(
              'Method (Stovetop):',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),

            // Step 1
            _buildStep(
              number: '1',
              text: 'Add oats, water or milk, and salt to a pot over medium-high heat. You can also add cinnamon for extra flavor.',
            ),
            SizedBox(height: 16),

            // Step 2
            _buildStep(
              number: '2',
              text: 'Bring the mixture to a low boil, then reduce the heat to a simmer.',
            ),
            SizedBox(height: 16),

            // Step 3
            _buildStep(
              number: '3',
              text: 'Cook for 5–7 minutes, stirring occasionally, until the liquid is mostly absorbed and the oats are creamy.',
            ),
            SizedBox(height: 16),

            // Step 4
            _buildStep(
              number: '4',
              text: 'Remove from heat, stir in the maple syrup and brown sugar, and serve with your favorite toppings.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({required String number, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}