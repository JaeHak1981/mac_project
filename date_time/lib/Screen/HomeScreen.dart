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
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.pink[100],
          child: Column(
            children: [
              _TapPart(selectedDate: selectedDate, onPressed: onHartPressed,),
              _ButtomPart(),
            ],
          ),
        ),
      ),
    );
  }
  void onHartPressed() {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                maximumDate: DateTime.now(),
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
class _TapPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;
  const _TapPart({required this.selectedDate, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    DateTime now = DateTime.now();


    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.headlineLarge,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난 날',
                style: textTheme.headlineMedium,
              ),
              Text(
                '${selectedDate.year},${selectedDate.month},${selectedDate.day}',
                style: textTheme.headlineMedium,
              ),
            ],
          ),
          IconButton(
              onPressed: onPressed,
              color: Colors.red,
              iconSize: 40,
              icon: Icon(
                Icons.favorite,
              )),
          Text(
            'D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays+1}',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}


class _ButtomPart extends StatelessWidget {
  const _ButtomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Expanded(child: Image.asset('asset/img/middle_image.png'));
  }
}
