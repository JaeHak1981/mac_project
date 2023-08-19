import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int numbers;

  const SettingScreen({
    required this.numbers,
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int numbers = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbers = widget.numbers;
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
              _Header(numbers: numbers),
              _Body(numbers: numbers, onSliderPressed: onSliderPressed)
            ],
          ),
        ),
      ),
    );
  }

  void onSliderPressed(double val) {
    setState(() {
      numbers = val.toInt();
    });
  }
}

class _Header extends StatelessWidget {
  final int numbers;

  const _Header({required this.numbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: numbers),
    );
  }
}

class _Body extends StatelessWidget {
  final int numbers;
  final ValueChanged<double>? onSliderPressed;

  const _Body(
      {required this.numbers, required this.onSliderPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 100000,
            value: numbers.toDouble(),
            onChanged: onSliderPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop<int>(numbers);
              },
              child: const Text(
                'SAVE',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              )),
        )
      ],
    );
  }
}
