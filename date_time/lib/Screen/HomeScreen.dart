import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TapPart(
                  selectedDate: selectedDate, onHartPressed: onHartPressed),
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
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
              ));
        });
  }
}

class _TapPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onHartPressed;

  const _TapPart({
    required this.selectedDate,
    required this.onHartPressed,
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
              ),
            ],
          ),
          IconButton(
              onPressed: onHartPressed,
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 60,
              )),
          Text(
            'D+ ${DateTime.now().difference(selectedDate).inDays + 1} ',
            style: textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Image.asset('asset/img/middle_image.png'));
  }
}
