import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Settings Screen', style: TextStyle(color: redColor, fontSize: 80),),
      ),
    );
  }
}
