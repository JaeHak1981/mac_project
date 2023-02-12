import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';

class RouteOneScreen extends StatelessWidget {
  const RouteOneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Route ONe', children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('POP'),
      )
    ]);
  }
}
