import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/scheduleCard.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: onDaySelected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,

            ),
            SizedBox(height: 8),
            TodayBanner(
              selectedDay: selectedDay,
              scheduleCount: 3,
            ),
            SizedBox(height: 8),
            ScheduleCard(
              startTime: 9,
              endTime: 11,
              content: 'Program Study',
              scheduleCount: 3,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
