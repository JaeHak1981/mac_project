import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  runApp(
    MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
    )
  );
}