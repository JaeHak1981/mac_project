import 'package:date_time/page/BottomPart.dart';
import 'package:date_time/page/TapPart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            TapPart(
              selectedDate: selectedDate,
              onPressed: onHartPressed,
            ),
            BottomPart(),
          ]),
        ),
      ),
    );
  }
  void onHartPressed() {
    DateTime now = DateTime.now();
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              color: Colors.white,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                maximumDate: DateTime(now.year, now.month, now.day),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
          );
        });
  }
}
