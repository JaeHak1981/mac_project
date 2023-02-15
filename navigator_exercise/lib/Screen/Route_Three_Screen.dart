import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/HomeScreen.dart';

class RouteThree extends StatelessWidget {
  const RouteThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(title: 'Route Three', children: [
      ArgumentText(argument: argument.toString()),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: PushAndPopText(
            title: 'POP',
          )),
    ]);
  }
}
