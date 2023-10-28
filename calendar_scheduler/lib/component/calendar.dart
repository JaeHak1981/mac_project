import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;

  const Calendar(
      {required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeo = BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(8),
    );
    final defaultTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 25,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultBoxDeo,
        weekendDecoration: defaultBoxDeo,
        selectedDecoration: defaultBoxDeo.copyWith(
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: PRIMARY_COLOR,
          ),
        ),
        outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(color: PRIMARY_COLOR,),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
