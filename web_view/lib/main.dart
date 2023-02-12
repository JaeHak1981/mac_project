import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view/page/HomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
