import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlay extends StatefulWidget {
  final XFile video;

  const CustomVideoPlay({required this.video, Key? key}) : super(key: key);

  @override
  State<CustomVideoPlay> createState() => _CustomVideoPlayState();
}

class _CustomVideoPlayState extends State<CustomVideoPlay> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialControllor();
  }

  initialControllor() async {
    videoPlayerController = VideoPlayerController.file(File(widget.video.path));
    await videoPlayerController!.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return CircularProgressIndicator();
    }
    return AspectRatio(
        aspectRatio: videoPlayerController!.value.aspectRatio,
        child: Stack(children: [
          VideoPlayer(videoPlayerController!),
          _Controls(),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {},
              color: Colors.white,
              iconSize: 30,
              icon: Icon(Icons.photo_camera_back),
            ),
          ),
        ]));
  }
}

class _Controls extends StatelessWidget {
  const _Controls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(onPressed: () {}, iconData: Icons.rotate_left),
          renderIconButton(onPressed: () {}, iconData: Icons.rotate_left),
          renderIconButton(onPressed: () {}, iconData: Icons.rotate_right),
        ],
      ),
    );
  }

  Widget renderIconButton({
    required VoidCallback onPressed,
    required IconData iconData,
  }) {
    return IconButton(
      onPressed: onPressed,
      color: Colors.white,
      iconSize: 30,
      icon: Icon(iconData),
    );
  }
}
