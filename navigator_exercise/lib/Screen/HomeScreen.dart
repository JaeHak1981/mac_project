import 'package:flutter/material.dart';
import 'package:navigator_exercise/Layout/Main_Layout.dart';
import 'package:navigator_exercise/Screen/Route_One_Screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? number;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Home Screen',
      children: [
        Text('arguments : ${number.toString()}', style: TextStyle(fontSize: 40),textAlign: TextAlign.center,),
        ElevatedButton(
            onPressed: () async{
             final result = await Navigator.of(context).push<int>(MaterialPageRoute(builder:(context)=>RouteOne(numbers:456) ));
             if(result != null){
               setState(() {
                 number = result;
               });
             }
            },
            child: Text(
              'PUSH',
              style: TextStyle(fontSize: 40),
            ))
      ],
    );
  }
}
