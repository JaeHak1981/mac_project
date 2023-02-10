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
              _Header(maxNumberInt: maxNumberInt, onNavigatorPressed: onNavigatorPressed,),
              _Body(randomNumber: randomNumber),
              _Footer(maxNumberInt: maxNumberInt, onNumberGenerate: onNumberGenerate,),
            ],
          ),
        ),
      ),
    );
  }
  void onNumberGenerate() {
    final random = Random();
    final Set<int> numberSet = {};
    while (numberSet.length != 3) {
      numberSet.add(random.nextInt(maxNumberInt));
    }
    setState(() {
      randomNumber = numberSet.toList();
    });
  }
  void onNavigatorPressed() async {
    final result = await Navigator.of(context).push<int>(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                SettingScreen(maxNumberInt: maxNumberInt,)));
    if(result != null){
      setState(() {
        maxNumberInt = result;
      });
    }
  }
}
class _Header extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onNavigatorPressed;
  const _Header({required this.maxNumberInt, required this.onNavigatorPressed, Key? key}) : super(key: key);

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
            onPressed: onNavigatorPressed,
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
          child: NumberRow(maxNumberDouble: e.value),
        ))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final int maxNumberInt;
  final VoidCallback onNumberGenerate;
  const _Footer({required this.maxNumberInt,required this.onNumberGenerate,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(12)),
          onPressed: onNumberGenerate,
          child: const Text(
            'Numbers Generate',
            style: TextStyle(color: Colors.white, fontSize: 30),
          )),
    );
  }
}

