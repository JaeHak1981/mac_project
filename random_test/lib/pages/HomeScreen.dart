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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _TapPart(onPressed: onSettingButton),
              _Body(numberList: numberList),
              _BottonPart(
                onPressed: onGenerator,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSettingButton() async {
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

  void onGenerator() {
    final render = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(render.nextInt(numbers));
    }
    setState(() {
      numberList = numberSet.toList();
    });
  }
}

class _TapPart extends StatelessWidget {
  final VoidCallback onPressed;

  const _TapPart({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'RandomNumbers',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: Colors.red,
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

class _BottonPart extends StatelessWidget {
  final VoidCallback onPressed;

  const _BottonPart({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: redColor),
          onPressed: onPressed,
          child: const Text(
            'Generator',
            style: TextStyle(color: Colors.white, fontSize: 40),
          )),
    );
  }
}
