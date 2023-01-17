import 'package:flutter/material.dart';
import 'package:page_view/page/HomeScreen.dart';

void main()=>runApp(PageApp());

class PageApp extends StatelessWidget {
  const PageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
