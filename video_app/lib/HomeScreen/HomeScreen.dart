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
  TextStyle textStyle = const TextStyle(
      color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300);

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
        onNewVideo: onNewVideo,
      ),
    );
  }

  Widget renderVideoEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: onNewVideo, child: Image.asset('asset/img/logo.png')),
          const SizedBox(
            height: 30,
          ),
          Row(
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
          ),
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
