import 'package:date_time/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 60,
              fontFamily: 'parisienne'),
          headlineMedium: TextStyle(color: Colors.white, fontSize: 50),
          headlineSmall: TextStyle(
              color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700),
        )),
  ));
}
