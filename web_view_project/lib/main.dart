import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view_project/HomeScreen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}