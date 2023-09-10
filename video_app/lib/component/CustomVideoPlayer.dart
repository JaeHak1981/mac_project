import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onNewVideo;

  const CustomVideoPlayer({
    required this.video,
    required this.onNewVideo,
    super.key,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController;
  Duration currentPosition = Duration();
  bool showControls = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialControls();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.path != widget.video.path) {
      initialControls();
    }
  }

  void initialControls() async {
     currentPosition = Duration();
    videoController = VideoPlayerController.file(File(widget.video.path));
    await videoController!.initialize();
    videoController!.addListener(() {
      final currentPosition = videoController!.value.position;
      setState(() {
        this.currentPosition = currentPosition;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return AspectRatio(
        aspectRatio: videoController!.value.aspectRatio,
        child: GestureDetector(
          onTap: () {
            setState(() {
              showControls = !showControls;
            });
          },
          child: Stack(
            children: [
              VideoPlayer(videoController!),
              if (showControls)
                _Controls(
                  onReversePressed: onReversePressed,
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  isPlaying: videoController!.value.isPlaying,
                ),
              if (showControls) _NewVideo(onNewVideo: widget.onNewVideo),
              _SliderControls(
                  currentPosition: currentPosition,
                  maxPosition: videoController!.value.duration,
                  onSliderPressed: onSliderPressed)
            ],
          ),
        ));
  }

  onSliderPressed(double val) {
    videoController!.seekTo(Duration(seconds: val.toInt()));
  }

  onPlayPressed() {
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  onReversePressed() {
    final currentPosition = videoController!.value.position;
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;
    Duration position = maxPosition;
    if ((maxPosition - const Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + const Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls(
      {required this.onReversePressed,
      required this.onPlayPressed,
      required this.onForwardPressed,
      required this.isPlaying,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            renderIconButton(
                onPressed: onReversePressed, iconData: Icons.rotate_left),
            renderIconButton(
                onPressed: onPlayPressed,
                iconData: isPlaying ? Icons.pause : Icons.play_arrow),
            renderIconButton(
                onPressed: onForwardPressed, iconData: Icons.rotate_right),
          ],
        ));
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: Colors.white,
          size: 35,
        ));
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onNewVideo;

  const _NewVideo({
    required this.onNewVideo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
          onPressed: onNewVideo,
          icon: const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 35,
          )),
    );
  }
}

class _SliderControls extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double>? onSliderPressed;

  const _SliderControls(
      {required this.currentPosition,
      required this.maxPosition,
      required this.onSliderPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
            Expanded(
              child: Slider(
                  min: 0,
                  max: maxPosition.inSeconds.toDouble(),
                  value: currentPosition.inSeconds.toDouble(),
                  onChanged: onSliderPressed),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
