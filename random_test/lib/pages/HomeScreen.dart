import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';
import 'package:random_test/pages/Body.dart';
import 'package:random_test/pages/Footor.dart';
import 'package:random_test/pages/Header.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Header(),
              Body(randomNumbers: randomNumbers,),
              Footor(onPressed: onNumbersGenerate ,)
            ],
          ),
        ),
      ),
    );
  }
  void onNumbersGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {}  ;
    while(newNumbers.length != 3){
      final numbers = rand.nextInt(1000);
      newNumbers.add(numbers);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }
}
