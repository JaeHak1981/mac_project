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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _TapPart(
              selectedDate: selectedDate, onPressed:  onHartPressed,
            ),
            _BottomPart(),
          ],
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
  _TapPart({required this.selectedDate,required this.onPressed,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Expanded(
        child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'U&I',
            style: textTheme.headline1,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난 날',
                style: textTheme.bodyText1,
              ),
              Text(
                '${selectedDate.year},${selectedDate.month},${selectedDate.day}',
                style: textTheme.bodyText2,
              ),
            ],
          ),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 40,
              )),
          Text(
            'D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays + 1}',
            style: textTheme.headline2,
          ),
        ],
      ),
    ));
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset('asset/img/middle_image.png'));
  }
}
