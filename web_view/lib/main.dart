import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view/page/HomeScreen.dart';

void main()=>runApp(WebView());

class WebView extends StatelessWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
