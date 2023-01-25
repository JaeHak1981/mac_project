import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';
import 'package:random_test/pages/Settings_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumber = 1000;
  List<int> randomNumber = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(
                randomNumber: randomNumber,
              ),
              _Footor(
                onPressed: onNumberGenerate,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSettingsPop() async {
    final result = await Navigator.of(context)
        .push<int>(MaterialPageRoute(builder: (BuildContext context) {
      return SettingsScreen();
    }));
    if (result != null) {
      setState(() {
        maxNumber = result!;
      });
    }
  }

  void onNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};
    while (newNumbers.length != 3) {
      final numbers = rand.nextInt(maxNumber);
      newNumbers.add(numbers);
      setState(() {
        randomNumber = newNumbers.toList();
      });
    }
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
          style: TextStyle(color: Colors.white, fontSize: 40),
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
                  padding: EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
                  child: Row(
                    children: e.value
                        .toString()
                        .split('')
                        .map((e) => Image.asset(
                              'asset/img/$e.png',
                              width: 50,
                              height: 70,
                            ))
                        .toList(),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _Footor extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footor({required this.onPressed, Key? key}) : super(key: key);

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
