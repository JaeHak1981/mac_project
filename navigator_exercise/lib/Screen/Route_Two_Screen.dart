import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/HomeScreen.dart';
import 'package:navigator_exercise/Screen/Route_Three_Screen.dart';

class RouteTwo extends StatelessWidget {
  const RouteTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(title: 'Route Two', children: [
      ArgumentText(argument: argument.toString()),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: PushAndPopText(
            title: 'POP',
          )),
      OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: PushAndPopText(
            title: 'PUSH Named',
          )),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/three');
          },
          child: PushAndPopText(
            title: 'Push Replace Named',
          )),
      OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
                (route) => route.settings.name == '/home');
          },
          child: PushAndPopText(title: 'Push And Remove Until', ))
    ]);
  }
}
