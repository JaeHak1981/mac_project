import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController(initialPage: 0);
  Timer? timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPosition = controller.page!.toInt();
      int nextPage = currentPosition + 1;
      if(nextPage > 4){
        nextPage = 0;
      }
      controller.animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
    if(timer !=null){
      timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text('PAGE VIEW TEST',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),),
      ),
      body: PageView(
        controller: controller,
        children: [1,2,3,4,5].map((e) => 
        Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover,)
        ).toList(),
      ),
    );
  }
}
