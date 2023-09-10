import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime now = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _TapPart(
                onPressed: onHartPressed,
                selectedDate: selectedDate,
              ),
              _ButtonPart(),
            ],
          ),
        ),
      ),
    );
  }

  void onHartPressed() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              color: Colors.white,
              child: CupertinoDatePicker(
                  initialDateTime: selectedDate,
                  maximumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                  }),
            ),
          );
        });
  }
}

class _TapPart extends StatelessWidget {
  final VoidCallback onPressed;
  final DateTime selectedDate;

  const _TapPart({
    required this.onPressed,
    required this.selectedDate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

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
                '${selectedDate.year}, ${selectedDate.month}, ${selectedDate.day}',
                style: textTheme.headlineMedium,
              )
            ],
          ),
          IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 60,
              )),
          Text(
            'D+${DateTime.now().difference(selectedDate).inDays+1}',
            style: textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}

class _ButtonPart extends StatelessWidget {
  const _ButtonPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(child: Image.asset('asset/img/middle_image.png')));
  }
}
