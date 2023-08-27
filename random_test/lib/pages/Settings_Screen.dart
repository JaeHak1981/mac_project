import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int numbers;

  const SettingScreen({required this.numbers, super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int startNumbers = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startNumbers = widget.numbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _Header(startNumbers: startNumbers),
            _Body(startNumbers: startNumbers, onSliderPressed: onSliderPressed)
          ],
        ),
      ),
    );
  }

  void onSliderPressed(double val) {
    setState(() {
      startNumbers = val.toInt();
    });
  }
}

class _Header extends StatelessWidget {
  final int startNumbers;

  const _Header({required this.startNumbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: startNumbers),
    );
  }
}

class _Body extends StatelessWidget {
  final int startNumbers;
  final ValueChanged<double>? onSliderPressed;

  const _Body({
    required this.startNumbers,
    required this.onSliderPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 10000,
            value: startNumbers.toDouble(),
            onChanged: onSliderPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: redColor),
              onPressed: () {
                Navigator.of(context).pop<int>(startNumbers);
              },
              child: const Text(
                'SAVE',
                style: TextStyle(color: Colors.white, fontSize: 35),
              )),
        )
      ],
    );
  }
}
