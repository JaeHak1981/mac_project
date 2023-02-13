import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';

class RouteTwo extends StatelessWidget {
  const RouteTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(title: 'Route Two', children: [
      Text(
        'arguments : ${arguments}',
        style: TextStyle(
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'POP',
            style: TextStyle(fontSize: 40),
          )),
      ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
          
          Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text(
            'PUSH Named',
            style: TextStyle(fontSize: 40),
          ))
    ]);
  }
}
