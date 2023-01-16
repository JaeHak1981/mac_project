import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "랜덤숫자생성하기",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: redColor,
                      ))
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: randomNumbersList
                      .asMap()
                      .entries
                      .map((e) => Padding(
                            padding:
                                EdgeInsets.only(bottom: e.key == 2 ? 0 : 16),
                            child: Row(
                              children: e.value
                                  .toString()
                                  .split("")
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
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: redColor),
                      onPressed: () {
                        final rand = Random();
                        final Set<int> newNumbersSet = {};
                        while (newNumbersSet.length != 3) {
                          final numbers = rand.nextInt(1000);
                          newNumbersSet.add(numbers);
                        }
                        setState(() {
                          randomNumbersList = newNumbersSet.toList();
                        }); //연습 1212
                      },
                      child: Text('생성하기')))
            ],
          ),
        ),
      ),
    );
  }
}
