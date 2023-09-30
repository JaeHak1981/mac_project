import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(initialPage: 0);

  List<Widget> children = [1, 2, 3, 4, 5].map((e) => Image.asset(
    'asset/img/image_$e.jpeg',
    fit: BoxFit.cover,
  )).toList();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;
      int maxPage = children.length - 1;

      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: children,
      ),
    );
  }
}
