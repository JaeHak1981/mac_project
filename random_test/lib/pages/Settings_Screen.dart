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
  int maxNumberInt = 1000;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maxNumberInt = widget.numberInt;
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
              _Header(maxNumberInt: maxNumberInt),
              _Body(maxNumberInt: maxNumberInt, onSavePressed: onSavePressed),
            ],
          ),
        ),
      ),
    );
  }

  void onSavePressed(double val) {
    setState(() {
      maxNumberInt = val.toInt();
    });
  }
}

class _Header extends StatelessWidget {
  final int maxNumberInt;

  const _Header({required this.maxNumberInt, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(numbers: maxNumberInt),
    );
  }
}

class _Body extends StatelessWidget {
  final int maxNumberInt;
  final ValueChanged<double>? onSavePressed;

  const _Body(
      {required this.maxNumberInt, required this.onSavePressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
            min: 1000,
            max: 100000,
            inactiveColor: redColor,
            activeColor: Colors.yellow,
            value: maxNumberInt.toDouble(),
            onChanged: onSavePressed),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: redColor),
                onPressed: () {
                  Navigator.of(context).pop(maxNumberInt);
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(fontSize: 35),
                )))
      ],
    );
  }
}
