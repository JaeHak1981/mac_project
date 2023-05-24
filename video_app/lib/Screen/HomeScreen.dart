import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_app/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderVideoEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  Widget renderVideoEmpty() {
    return Container(
      decoration: getBoxDecoration(),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onNewVideoPressed: onNewVideoPressed,
          ),
          const SizedBox(
            height: 30,
          ),
          const _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    setState(() {
      this.video = video;
    });
  }

  BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color(0xFF2A3A7C),
          Color(0xfff000118),
        ]));
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onNewVideoPressed;

  const _Logo({required this.onNewVideoPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onNewVideoPressed, child: Image.asset('asset/image/logo.png'));
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, fontSize: 30);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
