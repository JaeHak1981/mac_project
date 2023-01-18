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
  List<int> randomNumbersList = [123, 456, 789];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _Header(),
              _Body(randomNumbersList: randomNumbersList),
              _Footer(onPressed: onNumbersGenerate)
            ],
          ),
        ),
      ),
    );
  }

  void onNumbersGenerate() {
    final rand = Random();
    final Set<int> newNumbersSet = {};
    while (newNumbersSet.length != 3) {
      final numbers = rand.nextInt(1000);
      newNumbersSet.add(numbers);
    }
    setState(() {
      randomNumbersList = newNumbersSet.toList();
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
        Text(
          "랜덤숫자생성하기",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        IconButton(
            onPressed: () {
              /* push는 list에서 add() 역할을 한다. list 끝에 추가한다.
                [HomeScreen(), SettingsScreen()
                 : HomeScreen에 추가로 SettingsScreen이 추가로 들어간다]
                Route는 일종의 Screen과 같은 동의어로 생각하면 된다.
                일단은 push하는 방법을 외운다. 추후 다른 방법도 배울거다*/
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return Settings_Screen();
              }));
            },
            icon: Icon(
              Icons.settings,
              color: redColor,
            ))
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbersList;

  const _Body({required this.randomNumbersList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: randomNumbersList
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
        child: Text('생성하기'),
      ),
    );
  }
}
