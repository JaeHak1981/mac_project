import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  const ScheduleCard(
      {required this.startTime,
      required this.endTime,
      required this.content,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: PRIMARY_COLOR),
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Time(startTime: startTime, endTime: endTime),
                const SizedBox(width: 10),
                _Content(content: content),
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
      color: PRIMARY_COLOR,
      fontWeight: FontWeight.w700,
    );
    return Column(
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle.copyWith(fontWeight: FontWeight.w500),
        ),
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
    return Expanded(child: Text(content));
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
      width: 12, height: 12,
      decoration: BoxDecoration(
        color: color, shape: BoxShape.circle
      ),
    );
  }
}
