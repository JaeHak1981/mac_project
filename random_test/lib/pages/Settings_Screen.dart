import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';

class Settings_Screen extends StatefulWidget {
  final int maxNumber;

  const Settings_Screen({required this.maxNumber, Key? key}) : super(key: key);

  @override
  State<Settings_Screen> createState() => _Settings_ScreenState();
}

class _Settings_ScreenState extends State<Settings_Screen> {
  double maxNumber = 1000;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     maxNumber = widget.maxNumber.toDouble();
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
              _Body(maxNumber: maxNumber),
              _Footer(
                maxNumber: maxNumber,
                onPressed: onButtomPressed,
                onSliderChanged: onSliderChanged,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSliderChanged(double val) {
    setState(() {
      maxNumber = val;
    });
  }

  void onButtomPressed() {
    Navigator.of(context).pop(maxNumber.toInt());
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({required this.maxNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(number: maxNumber.toInt(),),
    );
  }
}

class _Footer extends StatelessWidget {
  final double maxNumber;
  final VoidCallback onPressed;
  final ValueChanged<double>? onSliderChanged;

  const _Footer(
      {required this.maxNumber,
      required this.onPressed,
      required this.onSliderChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            value: maxNumber,
            min: 1000,
            max: 100000,
            onChanged: onSliderChanged),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: redColor),
              onPressed: onPressed,
              child: Text('Save'),
            )),
      ],
    );
  }
}
