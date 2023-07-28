import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int numberInt;

  const SettingScreen({required this.numberInt, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int numbers = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbers = widget.numberInt;
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
              _TopPart(numbers: numbers),
              _Body(numbers: numbers, onSliderChanged: onSliderChanged)
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      numbers = val.toInt();
    });
  }
}

class _TopPart extends StatelessWidget {
  final int numbers;

  const _TopPart({required this.numbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: numbers),
    );
  }
}

class _Body extends StatelessWidget {
  final int numbers;
  final ValueChanged<double> onSliderChanged;

  const _Body(
      {required this.numbers, required this.onSliderChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 100000,
            value: numbers.toDouble(),
            onChanged: onSliderChanged),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: redColor),
              onPressed: () {
                Navigator.of(context).pop<int>(numbers);
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.white, fontSize: 40),
              )),
        )
      ],
    );
  }
}
