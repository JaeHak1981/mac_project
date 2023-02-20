import 'package:flutter/cupertino.dart';

class NumberRow extends StatelessWidget {
  final int numbersInt;
  const NumberRow({required this.numbersInt,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: numbersInt
          .toString()
          .split('')
          .map((e) => Image.asset(
        'asset/img/$e.png',
        width: 50,
        height: 70,
      ))
          .toList(),
    )
    ;
  }
}
