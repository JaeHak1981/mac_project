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
  List<int> numberList = [123, 456, 789];
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
              _Header(maxNumberInt: maxNumberInt, onSettingPressed: onSettingPressed),
              _Body(numberList: numberList),
              _Footer(onGeneratorPressed: onGeneratorPressed)
            ],
          ),
        ),
      ),
    );
  }
  void onSettingPressed() async {
    final result = await Navigator.of(context).push<int>(
        MaterialPageRoute(builder: (BuildContext context) {
          return SettingScreen(maxNumberInt: maxNumberInt,);
        }));
    if (result != null) {
      maxNumberInt = result;
    }
  }
  void onGeneratorPressed() {
    final rand = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(rand.nextInt(maxNumberInt));
    }
    setState(() {
      numberList = numberSet.toList();
    });
  }
}
class _Header extends StatelessWidget {

  final int maxNumberInt;
  final VoidCallback onSettingPressed;
  const _Header({required this.maxNumberInt,required this.onSettingPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('RandomNumbers',
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w200)),
        IconButton(
            onPressed:onSettingPressed ,
            color: redColor,
            iconSize: 40,
            icon: const Icon(
              Icons.settings,
            )),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numberList;
  const _Body({required this.numberList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numberList
            .asMap()
            .entries
            .map((e) => Padding(
          padding:
          EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
          child: NumberRow(numbers: e.value),
        ))
            .toList(),
      ),
    );
  }
}
class _Footer extends StatelessWidget {
  final VoidCallback onGeneratorPressed;
  const _Footer({ required this.onGeneratorPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style:
            ElevatedButton.styleFrom(backgroundColor: redColor),
            onPressed: onGeneratorPressed,
            child: const Text(
              'Generator',
              style: TextStyle(fontSize: 40),
            )));
  }
}
