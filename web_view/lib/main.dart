import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_view/page/HomeScreen.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized()
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
//     'https://bubbly-cause-fb4.notion.site/Class-c3284153a2074e9fa8423c193cba40bf'