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
              _Header(
                onPressed: onSettinsPop,
              ),
              _Body(randomNumbers: randomNumbers),
              _Footor(
                onPressed: onNumbersGenerate,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSettinsPop() async {
    final int? result = await Navigator.of(context)
        .push<int>(MaterialPageRoute(builder: (BuildContext context) {
      return Settings_Screen();
    }));
    if (result != null) {
      setState(() {
        maxNumber = result;
      });
    }
    ;
  }

  void onNumbersGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};
    while (newNumbers.length != 3) {
      final numbers = rand.nextInt(maxNumber);
      newNumbers.add(numbers);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
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
        const Text(
          '숫자 생성하기',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.settings,
              color: redColor,
            )),
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
                  child: Row(
                    children: e.value
                        .toString()
                        .split('')
                        .map((e) => Image.asset(
                              'asset/img/$e.png',
                              width: 70,
                              height: 50,
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
