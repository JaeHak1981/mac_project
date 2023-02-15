import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/HomeScreen.dart';
import 'package:navigator_exercise/Screen/Route_Three_Screen.dart';
import 'package:navigator_exercise/Screen/Route_Two_Screen.dart';

class RouteOne extends StatelessWidget {
  final int? number;

  RouteOne({this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Route One', children: [
      ArgumentText(argument: number.toString()),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: PushAndPopText(
            title: 'POP',
          )),
      OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RouteTwo(),
                settings: RouteSettings(arguments: 456)));
          },
          child: PushAndPopText(title: 'PUSH')),

    ]);
  }
}
