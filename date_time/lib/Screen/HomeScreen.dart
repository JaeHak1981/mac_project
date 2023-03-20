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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TapPart(
                selectedDate: selectedDate,
                onPressed: onHartPressed,
              ),
              _BottomPart(),
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

  const _TapPart(
      {required this.selectedDate, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    DateTime now = DateTime.now();


    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              style: textTheme.headlineSmall,
            ),
          ],
        ),
        IconButton(
            onPressed: onPressed,
            color: Colors.red,
            icon: Icon(
              Icons.favorite,
              size: 50,
            )),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays + 1}',
          style: textTheme.bodyLarge,
        ),
      ],
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
