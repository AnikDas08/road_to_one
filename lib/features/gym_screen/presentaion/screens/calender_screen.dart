import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_project_flutter/component/image/app_bar.dart';

import '../../data/model/calender_model.dart';
import '../controller/calender_controller.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CalendarController>(
      init: CalendarController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFF1a1a1a),
          appBar: AppBarNew(title: "Calender",),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'My week',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildFilterButtons(controller),
                SizedBox(height: 16.h),
                _buildCalendar(controller),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    'My Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildTaskSchedule(controller),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterButtons(CalendarController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _buildDropdownButton(controller.selectedYear.toString(), () {
            Get.back();
            controller.showYearPicker();
          }),
          SizedBox(width: 8.w),
          _buildDropdownButton(controller.selectedMonth, () {
            controller.showMonthPicker();
          }),
          SizedBox(width: 8.w),
          _buildDateRangeButton(controller.dateRange),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2d2d2d),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d2d),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCalendar(CalendarController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2d2d2d),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return SizedBox(
                width: 32.w,
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 12.h),
          // Calendar grid
          ...controller.calendarWeeks.map((week) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: week.map((day) {
                  return _buildCalendarDay(day, controller);
                }).toList(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(CalendarDay day, CalendarController controller) {
    final isSelected = controller.isDateSelected(day.date);
    final isInRange = controller.isDateInRange(day.date);
    final isToday = controller.isToday(day.date);

    Color bgColor = Colors.transparent;
    Color textColor = Colors.white;

    if (isSelected) {
      bgColor = const Color(0xFFb4ff39);
      textColor = Colors.black;
    } else if (isInRange) {
      bgColor = const Color(0xFF4a5a3a);
    } else if (!day.isCurrentMonth) {
      textColor = Colors.grey[700]!;
    }

    return GestureDetector(
      onTap: () => controller.selectDate(day.date),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            day.day.toString(),
            style: TextStyle(
              color: textColor,
              fontSize: 14.sp,
              fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskSchedule(CalendarController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: controller.weekDays.map((dayData) {
          return Expanded(
            child: _buildDayTask(
              dayData['day']!,
              dayData['date']!,
              dayData['task']!,
              dayData['isChecked'] as bool,
                  () => controller.toggleTask(dayData['day']!),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDayTask(
      String day,
      String date,
      String task,
      bool isChecked,
      VoidCallback onTap,
      ) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked ? const Color(0xFFb4ff39) : Colors.grey[700]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: isChecked
                ? Icon(
              Icons.check,
              color: const Color(0xFFb4ff39),
              size: 20.sp,
            )
                : null,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          task,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}