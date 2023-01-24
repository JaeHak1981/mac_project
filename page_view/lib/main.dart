import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view/page/HomeScreen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
