import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view/page/HomeScreen.dart';

void main()=>runApp(WebViewApp());

class WebViewApp extends StatelessWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
