import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/model/calender_model.dart';

class CalendarController extends GetxController {
  int selectedYear = DateTime.now().year;
  String selectedMonth = DateFormat('MMMM').format(DateTime.now());
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  List<DateTime> selectedDates = [];
  Map<String, bool> taskStatus = {
    'Mon': false,
    'Tues': false,
    'Wed': false,
    'Thurs': false,
    'Fri': false,
    'Sat': false,
    'Sun': false,
  };

  @override
  void onInit() {
    super.onInit();
    // Initialize with current week selection
    startDate = DateTime.now().subtract(Duration(days: 2));
    endDate = DateTime.now().add(Duration(days: 4));
    _generateSelectedDates();
  }

  void _generateSelectedDates() {
    selectedDates.clear();
    DateTime current = startDate;
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      selectedDates.add(current);
      current = current.add(const Duration(days: 1));
    }
  }

  String get dateRange {
    return '${startDate.day}th - ${endDate.day}th';
  }

  List<List<CalendarDay>> get calendarWeeks {
    final firstDayOfMonth = DateTime(selectedYear, _getMonthNumber(), 1);
    final lastDayOfMonth = DateTime(selectedYear, _getMonthNumber() + 1, 0);

    // Find the first day to display (may be from previous month)
    int firstWeekday = firstDayOfMonth.weekday % 7;
    DateTime startOfCalendar = firstDayOfMonth.subtract(Duration(days: firstWeekday));

    List<List<CalendarDay>> weeks = [];
    DateTime current = startOfCalendar;

    // Generate 5-6 weeks
    for (int week = 0; week < 6; week++) {
      List<CalendarDay> weekDays = [];
      for (int day = 0; day < 7; day++) {
        weekDays.add(CalendarDay(
          day: current.day,
          date: current,
          isCurrentMonth: current.month == firstDayOfMonth.month,
        ));
        current = current.add(const Duration(days: 1));
      }
      weeks.add(weekDays);

      // Stop if we've gone past the current month
      if (current.month != firstDayOfMonth.month && week >= 4) break;
    }

    return weeks;
  }

  int _getMonthNumber() {
    const months = {
      'January': 1, 'February': 2, 'March': 3, 'April': 4,
      'May': 5, 'June': 6, 'July': 7, 'August': 8,
      'September': 9, 'October': 10, 'November': 11, 'December': 12,
    };
    return months[selectedMonth] ?? 1;
  }

  List<Map<String, dynamic>> get weekDays {
    return [
      {'day': 'Mon', 'date': '8', 'task': 'Push', 'isChecked': taskStatus['Mon']},
      {'day': 'Tues', 'date': '9', 'task': 'Pull', 'isChecked': taskStatus['Tues']},
      {'day': 'Wed', 'date': '10', 'task': 'Rest', 'isChecked': taskStatus['Wed']},
      {'day': 'Thurs', 'date': '11', 'task': 'Push', 'isChecked': taskStatus['Thurs']},
      {'day': 'Fri', 'date': '12', 'task': 'Pull', 'isChecked': taskStatus['Fri']},
      {'day': 'Sat', 'date': '13', 'task': 'Rest', 'isChecked': taskStatus['Sat']},
      {'day': 'Sun', 'date': '14', 'task': 'Leg', 'isChecked': taskStatus['Sun']},
    ];
  }

  bool isDateSelected(DateTime date) {
    return selectedDates.any((d) =>
    d.year == date.year && d.month == date.month && d.day == date.day
    );
  }

  bool isDateInRange(DateTime date) {
    return date.isAfter(startDate.subtract(const Duration(days: 1))) &&
        date.isBefore(endDate.add(const Duration(days: 1)));
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  void selectDate(DateTime date) {
    startDate = date;
    endDate = date.add(const Duration(days: 7));
    _generateSelectedDates();
    update();
  }

  void toggleTask(String day) {
    taskStatus[day] = !taskStatus[day]!;
    update();
  }

  void showYearPicker() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text('Select Year', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final year = DateTime.now().year - 5 + index;

              return GetBuilder<CalendarController>(
                builder: (_) => Container(
                  color: (year == selectedYear)
                      ? Colors.white24   // highlight selected year
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(
                      year.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      selectedYear = year;
                      update();
                      Navigator.pop(Get.context!);

                      await Future.delayed(Duration(milliseconds: 120));
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }



  void showMonthPicker() {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2d2d2d),
        title: const Text('Select Month', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: 300,
          height: 400,
          child: ListView.builder(
            itemCount: months.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  months[index],
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  selectedMonth = months[index];
                  update();
                  Navigator.pop(Get.context!);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}