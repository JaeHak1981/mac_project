import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextStyle textStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: getNumbers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                // 데이터가 잇을 때 위젯 렌더링
              }

              if(snapshot.hasError){
                // 에러가 났을 때 위젯 렌더링
              }

              // 로딩중일때 위젯 렌더링

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'FutureBuilder',
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 40),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ConState : ${snapshot.connectionState}',
                    style: textStyle,
                  ),
                  Row(
                    children: [
                      Text(
                        'Date : ${snapshot.data}',
                        style: textStyle,
                      ),

                      if(snapshot.connectionState == ConnectionState.waiting)
                        CircularProgressIndicator(),
                    ],
                  ),
                  Text(
                    'Error : ${snapshot.error}',
                    style: textStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        'setState',
                        style: textStyle,
                      ))
                ],
              );
            }),
      ),
    );
  }

  Future<int> getNumbers() async {
    await Future.delayed(Duration(seconds: 2));
    final rand = Random();
   // throw Exception('에러가 발생');
    return rand.nextInt(100);
  }
}
