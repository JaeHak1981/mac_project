import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_call/screen/home_screen.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
    )
  );
}