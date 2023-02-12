import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';

class RouteTwo extends StatefulWidget {
  const RouteTwo({Key? key}) : super(key: key);

  @override
  State<RouteTwo> createState() => _RouteTwoState();
}

class _RouteTwoState extends State<RouteTwo> {
  @override
  Widget build(BuildContext context) {
    final  arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text('arguments : ${arguments.toString()}', style: TextStyle(fontSize: 40),),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent, foregroundColor: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'POP',
              style: TextStyle(fontSize: 40),
            ))
      ],
    );
  }
}
