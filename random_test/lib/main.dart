import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_test/pages/HomeScreen.dart';

void main()=>runApp(RandomApp());

class RandomApp extends StatelessWidget {
  const RandomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
