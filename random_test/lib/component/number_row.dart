import 'package:flutter/cupertino.dart';

class NumberRow extends StatelessWidget {
  final int numbersDouble;

  const NumberRow({required this.numbersDouble, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: numbersDouble
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
