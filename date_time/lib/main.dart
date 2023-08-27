import 'package:date_time/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    theme: ThemeData(
        fontFamily: 'sunflower',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'parisienne',
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: TextStyle(color: Colors.white, fontSize: 50),
          headlineSmall: TextStyle(color: Colors.white, fontSize: 50),
        )),
  ));
}
