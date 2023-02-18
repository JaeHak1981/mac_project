import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view/Screen/HomeScreen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: HomeScreen(),));
}