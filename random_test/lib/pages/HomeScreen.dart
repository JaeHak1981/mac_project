import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              _Header(),
              _Body(randomNumbers: randomNumbers),
              _Footer(onPressed: onNumbeergenerate)
            ],
          ),
        ),
      ),
    );
  }

  void onNumbeergenerate() {
    final rand = Random();
    final Set<int> newNumbersSet = {};
    while (newNumbersSet.length != 3) {
      final numbers = rand.nextInt(1000);
      newNumbersSet.add(numbers);
    }
    setState(() {
      randomNumbers = newNumbersSet.toList();
    });
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랜덤숫자생성하기',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
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
    ));
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
          child: const Text('생성하기'),
        ));
  }
}
