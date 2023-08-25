import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
        children: [
            Expanded(child: _Logo()),
            Expanded(child: _Image()),
            Expanded(child: _Button()),
        ],
      ),
          )),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue[300]!,
                blurRadius: 12,
                spreadRadius: 5,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.videocam,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'LIVE',
                style: TextStyle(
                    color: Colors.white, fontSize: 30, letterSpacing: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('asset/img/home_img.png'),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(onPressed: (){}, child: Text('Enter', style: TextStyle(fontSize: 30),),),
        ],
      ),
    );
  }
}
