import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calendar(
      {required this.selectedDay,
      required this.focusedDay,
      required this.onDaySelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
    );
    final defaultTextStyle = TextStyle(fontWeight: FontWeight.w700);
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: PRIMARY_COLOR, width: 1),
        ),
        selectedTextStyle: defaultTextStyle.copyWith(color: PRIMARY_COLOR),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
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
