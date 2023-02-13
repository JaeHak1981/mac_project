import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/Route_Two_Screen.dart';

class RouteOne extends StatelessWidget {
  final int? numbers;

  const RouteOne({ this.numbers, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Route One', children: [
      Text(
        'arguments : ${numbers.toString()}',
        style: TextStyle(fontSize: 40),
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(123);
          },
          child: Text(
            'POP',
            style: TextStyle(fontSize: 40),
          )),
      ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RouteTwo(),
                settings: RouteSettings(arguments: 789)));
          },
          child: Text(
            'PUSH',
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ))
    ]);
  }
}
