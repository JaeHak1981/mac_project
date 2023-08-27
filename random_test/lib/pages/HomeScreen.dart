import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/component/number_row.dart';
import 'package:random_test/constant/color.dart';
import 'package:random_test/pages/Settings_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numberList = [123, 456, 789];
  int numbers = 1000;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _Header(numbers: numbers, onPressed: onSettingPressed),
                _Body(numberList: numberList),
                _Bottom(onPressed: onGenerator),
              ],
            ),
          )),
    );
  }

  void onGenerator() {
    final rand = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(rand.nextInt(numbers));
    }
    setState(() {
      numberList = numberSet.toList();
    });
  }

  void onSettingPressed() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return SettingScreen(
        numbers: numbers,
      );
    }));

    if (result != null) {
      numbers = result;
    }
  }
}

class _Header extends StatelessWidget {
  final int numbers;
  final VoidCallback onPressed;

  const _Header({required this.numbers, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'RadomNumbers',
          style: TextStyle(color: Colors.white, fontSize: 35),
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
  final List<int> numberList;

  const _Body({required this.numberList, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numberList
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
                  child: NumberRow(numbers: e.value),
                ))
            .toList(),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final VoidCallback onPressed;

  const _Bottom({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: onPressed,
        child: const Text(
          'Generator',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
