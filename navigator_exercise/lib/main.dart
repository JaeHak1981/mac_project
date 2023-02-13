
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigator_exercise/Screen/HomeScreen.dart';
import 'package:navigator_exercise/Screen/Route_One_Screen.dart';
import 'package:navigator_exercise/Screen/Route_Three_Screen.dart';
import 'package:navigator_exercise/Screen/Route_Two_Screen.dart';

const HOME_ROUTE = '/';
void main() =>
    runApp(MaterialApp(
      initialRoute: '/',
      // home: HomeScreen(),
      routes:{
        HOME_ROUTE : (context) => HomeScreen(),
        '/one' : (context)=> RouteOne(),
        '/two' : (context)=> RouteTwo(),
        '/three' : (context) => RouteThree(),
      },

    ));
