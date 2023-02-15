import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/Route_One_Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(title: 'Home Screen', children: [
      ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => RouteOne(number: 123,)));
          },
          child: PushAndPopText(
            title: 'PUSH',
          )),
    ]);
  }
}
class ArgumentText extends StatelessWidget {
  final String argument;
  const ArgumentText({required this.argument, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(' Argument : ${argument}', style: TextStyle(fontSize: 40), textAlign: TextAlign.center,);
  }
}

class PushAndPopText extends StatelessWidget {
  final String title;

  const PushAndPopText({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 40),
    );
  }
}
