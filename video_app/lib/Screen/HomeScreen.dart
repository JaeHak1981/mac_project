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
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }
  Widget renderVideo(){
    return Center(
      child: CustomVideoPlayer(video: video!,),
    );
  }
  Widget renderEmpty(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onLogoTap: onLogoTap),
          SizedBox(height: 30),
          _AppName(),
        ],
      ),
    );
  }

  void onLogoTap() async {
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
  final VoidCallback onLogoTap;

  const _Logo({required this.onLogoTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLogoTap,
      child: Image.asset('asset/image/logo.png'),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
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
        )
      ],
    );
  }
}
