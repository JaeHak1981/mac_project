import 'package:date_time/Screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: HomeScreen(),
    theme: ThemeData(
      fontFamily: 'sunflower',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(color: Colors.white, fontSize: 60, fontFamily: 'parisienne'),
        bodySmall: TextStyle(color: Colors.white,fontSize: 40),
        bodyLarge: TextStyle(color: Colors.white,fontSize: 40),
        bodyMedium: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w700)



      )
    ),
  ));
}