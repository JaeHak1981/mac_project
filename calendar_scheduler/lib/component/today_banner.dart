import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;

  const TodayBanner({
    required this.scheduleCount,
    required this.selectedDay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: PRIMARY_COLOR
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일', style: textStyle,),

              Text('$scheduleCount개', style: textStyle,),
            ],
          ),
        ),
      ),
    );
  }
}
