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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _TapPart(numbers: numbers),
            _Body(
              numbers: numbers,
              onChangedPressed: onChangedPressed,
              onPressed: onSavePressed,
            )
          ],
        ),
      ),
    );
  }

  void onChangedPressed(double val) {
    setState(() {
      numbers = val.toInt();
    });
  }

  void onSavePressed() {
    Navigator.of(context).pop<int>(numbers);
  }
}

class _TapPart extends StatelessWidget {
  final int numbers;

  const _TapPart({required this.numbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: numbers),
    );
  }
}

class _Body extends StatelessWidget {
  final int numbers;
  final ValueChanged<double>? onChangedPressed;
  final VoidCallback onPressed;

  const _Body(
      {required this.numbers,
      required this.onChangedPressed,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 100000,
            value: numbers.toDouble(),
            onChanged: onChangedPressed),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: redColor),
              onPressed: onPressed,
              child: const Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              )),
        )
      ],
    );
  }
}
