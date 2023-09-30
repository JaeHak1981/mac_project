import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final int scheduleCount;
  final Color color;

  const ScheduleCard(
      {required this.startTime,
      required this.endTime,
      required this.content,
      required this.scheduleCount,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PRIMARY_COLOR, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Time(startTime: startTime, endTime: endTime),
                SizedBox(width: 10),
                _Content(content: content),
                SizedBox(width: 10),
                _Category(color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
        color: PRIMARY_COLOR, fontWeight: FontWeight.w600, fontSize: 16);
    return Column(
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          '${endTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        )
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Text(
      '$content',
      style: TextStyle(fontSize: 20),
    ));
  }
}

class _Category extends StatelessWidget {
  final Color color;

  const _Category({
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
