import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';

class Footor extends StatelessWidget {
  final VoidCallback onPressed;
  const Footor({required this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: redColor),
        onPressed: onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}
