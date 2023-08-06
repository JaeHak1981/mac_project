import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_app_project/component/CustomVideoPlayer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      child: CustomVideoPlayer(video: video!, onNewVideo: onNewVideo ,),
    );
  }

  Widget renderVideoEmpty() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onPressed: onNewVideo,),
          SizedBox(
            height: 30,
          ),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideo() async {
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
              Color(0xFF000118),
            ]));
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onPressed;

  const _Logo({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Image.asset('asset/img/logo.png'));
  }
}

class _AppName extends StatelessWidget {
  const _AppName({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300);
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
        ),
      ],
    );
  }
}
