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
              const _Bottom()
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
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                maximumDate: DateTime.now(),
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
  final VoidCallback onPressed;

  final DateTime selectedDate;

  const _TapPart({
    required this.onPressed,
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('U&I', style: textTheme.headlineLarge),
        Column(
          children: [
            Text('우리 처음 만난 날', style: textTheme.bodySmall),
            Text(
              '${selectedDate.year},${selectedDate.month},${selectedDate.day}',
              style: textTheme.bodyLarge,
            ),
          ],
        ),
        IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 40,
            )),
        Text(
          'D+${DateTime(now.year, now.month, now.day).difference(selectedDate).inDays + 1}',
          style: textTheme.bodyMedium,
        ),
      ],
    ));
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset('asset/img/middle_image.png'));
  }
}
