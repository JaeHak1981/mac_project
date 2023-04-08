import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumberInt;

  const SettingScreen({required this.maxNumberInt, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double numberDouble = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberDouble = widget.maxNumberInt.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(numberDouble: numberDouble),
              _Body(
                numberDouble: numberDouble,
                onNavigatorPressed: onNavigatorPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onNavigatorPressed(double val) {
    setState(() {
      numberDouble = val;
    });
  }
}

class _Header extends StatelessWidget {
  final double numberDouble;

  const _Header({required this.numberDouble, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: numberDouble.toInt()),
    );
  }
}

class _Body extends StatelessWidget {
  final double numberDouble;
  final ValueChanged<double>? onNavigatorPressed;

  const _Body(
      {required this.numberDouble, required this.onNavigatorPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            value: numberDouble,
            min: 1000,
            max: 100000,
            onChanged: onNavigatorPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: redColor),
            onPressed: () {
              Navigator.of(context).pop(numberDouble.toInt());
            },
            child: Text(
              'SAVE',
              style: TextStyle(fontSize: 40),
            ),
          ),
        )
      ],
    );
  }
}
