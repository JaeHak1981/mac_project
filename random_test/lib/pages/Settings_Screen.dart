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
  double maxNumberDouble = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxNumberDouble = widget.maxNumberInt.toDouble();
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
              _Header(
                maxNumberDouble: maxNumberDouble,
              ),
              _Body(
                maxNumberDouble: maxNumberDouble,
                onSliderPressed: onSliderPressed,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderPressed(val) {
    setState(() {
      maxNumberDouble = val;
    });
  }
}

class _Header extends StatelessWidget {
  final double maxNumberDouble;

  const _Header({required this.maxNumberDouble, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(maxNumberDouble: maxNumberDouble.toInt()),
    );
  }
}

class _Body extends StatelessWidget {
  final double maxNumberDouble;
  final ValueChanged<double>? onSliderPressed;

  const _Body(
      {required this.maxNumberDouble, required this.onSliderPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            activeColor: Colors.yellow,
            inactiveColor: Colors.green,
            value: maxNumberDouble,
            min: 1000,
            max: 100000,
            onChanged: onSliderPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: redColor,
                foregroundColor: Colors.yellow,
                padding: const EdgeInsets.all(12)),
            onPressed: () {
              Navigator.of(context).pop(maxNumberDouble.toInt());
            },
            child: const Text(
              'SAVE',
              style: TextStyle(fontSize: 30),
            ),
          ),
        )
      ],
    );
  }
}
