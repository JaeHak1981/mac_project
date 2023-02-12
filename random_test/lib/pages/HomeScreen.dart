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
  int maxNumberInt = 1000;
  List<int> randomNumber = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(maxNumberInt: maxNumberInt, onPressed: onSettingPressed,),
              _Body(randomNumber: randomNumber,),
              _Footer(maxNumberInt: maxNumberInt, onNumberGeneratePressed: onNumberGeneratePressed,)
            ],
          ),
        ),
      ),
    );
  }
  void onSettingPressed() async {
    final result =
    await Navigator.of(context).push<int>(MaterialPageRoute(
        builder: (BuildContext context) => SettingScreen(
          maxNumberInt: maxNumberInt,
        )));
    if (result != null) {
      setState(() {
        maxNumberInt = result;
      });
    }
  }
  void onNumberGeneratePressed() {
    final rand = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(rand.nextInt(maxNumberInt));
    }
    setState(() {
      randomNumber = numberSet.toList();
    });
  }
}

class _Header extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onPressed;

  const _Header({required this.maxNumberInt,required this.onPressed,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Random Numbers",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: redColor,
              size: 40,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumber;
  const _Body({required this.randomNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumber
            .asMap()
            .entries
            .map((e) => Padding(
          padding:
          EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
          child: NumberRow(numbersInt: e.value),
        ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onNumberGeneratePressed;
  const _Footer({required this.maxNumberInt, required this.onNumberGeneratePressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: redColor,
              padding: const EdgeInsets.all(15)),
          onPressed: onNumberGeneratePressed,
          child: const Text(
            'Number Generate',
            style: TextStyle(fontSize: 30),
          )),
    );
  }
}
