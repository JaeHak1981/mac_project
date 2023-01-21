import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Settings Screen', style: TextStyle(
          color: Colors.blue,
          fontSize: 100
        ),),
      ),
    );
  }
}
