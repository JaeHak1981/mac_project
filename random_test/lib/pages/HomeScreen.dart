import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';
import 'package:random_test/pages/Settings_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(onPressed: onSettingPop),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onRandomNumber)
            ],
          ),
        ),
      ),
    );
  }

  void onSettingPop() async {
    final result = await Navigator.of(context)
        .push<int>(MaterialPageRoute(builder: (BuildContext context) {
      return Settings_Screen(maxNumber: maxNumber,);
    }));
    if (result != null) {
      maxNumber = result.toInt();
    }
  }

  void onRandomNumber() {
    final random = Random();
    final Set<int> numbersSet = {};
    while (numbersSet.length != 3) {
      final int numbers = random.nextInt(maxNumber);
      numbersSet.add(numbers);
    }
    setState(() {
      randomNumbers = numbersSet.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '숫자생성하기',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: redColor,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;

  const _Body({required this.randomNumbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
                  child: NumberRow(number: e.value,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: redColor),
        onPressed: onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}
