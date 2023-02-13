import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';

class RouteThree extends StatelessWidget {
  const RouteThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;
    return MainLayout(
      title: 'Route Three',
      children: [
        Text('arguments : ${argument}', style: TextStyle(fontSize: 40),textAlign: TextAlign.center,),
        ElevatedButton(
          onPressed: () {Navigator.of(context).pop();},
          child: Text('POP', style: TextStyle(fontSize: 40),),
        )
      ],
    );
  }
}
