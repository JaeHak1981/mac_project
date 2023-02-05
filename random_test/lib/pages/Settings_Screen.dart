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
  double numbersDouble = 1000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbersDouble = widget.maxNumberInt.toDouble();
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
              _Header(numbersDouble: numbersDouble),
              _Body(
                numbersDouble: numbersDouble,
                onSliderChange: onSliderChange,
                onPressed: onNavigatorPop,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onNavigatorPop() {
    Navigator.of(context).pop(numbersDouble.toInt());
  }

  void onSliderChange(double val) {
    setState(() {
      numbersDouble = val;
    });
  }
}

class _Header extends StatelessWidget {
  final double numbersDouble;

  const _Header({required this.numbersDouble, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numberInt: numbersDouble.toInt()),
    );
  }
}

class _Body extends StatelessWidget {
  final double numbersDouble;
  final ValueChanged<double>? onSliderChange;
  final VoidCallback onPressed;

  const _Body(
      {required this.onPressed,
      required this.numbersDouble,
      required this.onSliderChange,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            value: numbersDouble,
            min: 1000,
            max: 100000,
            onChanged: onSliderChange),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: redColor),
            onPressed: onPressed,
            child: Text('Save'),
          ),
        )
      ],
    );
  }
}
