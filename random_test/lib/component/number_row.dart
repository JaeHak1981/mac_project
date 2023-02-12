import 'package:flutter/cupertino.dart';

class NumberRow extends StatelessWidget {
  final int maxNumberDouble;
  const NumberRow({required this.maxNumberDouble,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: maxNumberDouble
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