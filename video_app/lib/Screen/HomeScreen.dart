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
      body: Container(
        decoration: getBoxDecoration(),
        child: video == null ? renderVideoEmpty() : renderVideo(),
      ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _Logo(
          onPressed: onNewVideoPressed,
        ),
        const SizedBox(height: 30),
        const _AppName(),
      ],
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
          Color(0xFFF000118),
        ]));
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onPressed;

  const _Logo({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed, child: Image.asset('asset/image/logo.png'));
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('VIDEO', style: textStyle),
        Text('PLAYER', style: textStyle.copyWith(fontWeight: FontWeight.w700)),
      ],
    );
  }
}
