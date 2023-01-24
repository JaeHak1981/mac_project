import 'package:flutter/material.dart';
import 'package:random_test/constant/color.dart';

class Settings_Screen extends StatefulWidget {
  const Settings_Screen({Key? key}) : super(key: key);

  @override
  State<Settings_Screen> createState() => _Settings_ScreenState();
}

class _Settings_ScreenState extends State<Settings_Screen> {
  double maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                children: maxNumber.toInt()
                    .toString()
                    .split('')
                    .map((e) => Image.asset(
                          'asset/img/$e.png',
                          width: 50,
                          height: 70,
                        ))
                    .toList(),
              ),
            ),
            Slider(
                value: maxNumber,
                min: 1000,
                max: 100000,
                onChanged: (double val) {
                  setState(() {
                    maxNumber = val;
                  });
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: redColor),
              onPressed: () {
                Navigator.of(context).pop(maxNumber.toInt());
              },
              child: Text('저장'),
            )
          ],
        ),
      ),
    );
  }
}
