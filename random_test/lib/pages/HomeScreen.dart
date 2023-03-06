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
  List<int> randomList = [123, 456, 789];
  int maxNumberInt = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(
                maxNumberInt: maxNumberInt,
                onPressed: onSettingPressed,
              ),
              _Body(
                randomList: randomList,
              ),
              _Footer(maxNumberInt: maxNumberInt, onPressed:onGeneratePressed,)
            ],
          ),
        ),
      ),
    );
  }
  void onGeneratePressed() {
    final rand = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(rand.nextInt(maxNumberInt));
    }
    setState(() {
      randomList = numberSet.toList();
    });
  }

  void onSettingPressed() async {
    final result = await Navigator.of(context)
        .push<int>(MaterialPageRoute(builder: (context) {
      return SettingScreen(
        maxNumberInt: maxNumberInt,
      );
    }));
    if (result != null) {
      maxNumberInt = result.toInt();
    }
  }
}

class _Header extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onPressed;

  const _Header({
    required this.maxNumberInt,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Random Numbers',
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.settings,
            color: redColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomList;

  const _Body({required this.randomList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomList
            .asMap()
            .entries
            .map((e) =>
            Padding(
              padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
              child: NumberRow(numberInt: e.value),
            ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onPressed;

  const _Footer({
    required this.maxNumberInt,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: redColor),
          onPressed: onPressed,
          child: const Text(
            'Number Generation',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),
    );
  }
}
