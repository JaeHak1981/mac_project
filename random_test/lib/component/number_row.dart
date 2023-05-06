import 'package:flutter/material.dart';

class NumberRow extends StatelessWidget {
  final int numbers;
  const NumberRow({required this.numbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: numbers
          .toString()
          .split('')
          .map((e) => Image.asset(
        'asset/img/$e.png',
        width: 50,
        height: 70,
      ))
          .toList(),
    );
  }
}
