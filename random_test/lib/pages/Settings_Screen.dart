import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int numberInt;

  const SettingScreen({required this.numberInt, Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int numberInt = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numberInt = widget.numberInt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              _Header(numberInt: numberInt),
              _Body(numberInt: numberInt, onSliderPressed: onSliderPressed)
            ],
          ),
        ),
      ),
    );
  }

  void onSliderPressed(double val) {
    setState(() {
      numberInt = val.toInt();
    });
  }
}

class _Header extends StatelessWidget {
  final int numberInt;

  const _Header({required this.numberInt, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          NumberRow(numbers: numberInt),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int numberInt;
  final ValueChanged<double>? onSliderPressed;

  const _Body(
      {required this.numberInt, required this.onSliderPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 100000,
            value: numberInt.toDouble(),
            onChanged: onSliderPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: redColor),
              onPressed: () {
                Navigator.of(context).pop(numberInt);
              },
              child: const Text(
                'SAVE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              )),
        )
      ],
    );
  }
}
