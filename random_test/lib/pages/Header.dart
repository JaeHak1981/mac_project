import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_test/pages/Settings_Screen.dart';

import '../constant/color.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "숫자생성하기",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SettingsScreen();
              }));
            },
            icon: Icon(
              Icons.settings,
              color: redColor,
            )),
      ],
    );
  }
}
