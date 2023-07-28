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
              color: Colors.white, fontSize: 70, fontWeight: FontWeight.w700,
          fontFamily: 'parisienne'),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 45,
          ),
          headlineSmall: TextStyle(
              color: Colors.white, fontSize: 60, fontWeight: FontWeight.w700),
        )),
  ));
}
