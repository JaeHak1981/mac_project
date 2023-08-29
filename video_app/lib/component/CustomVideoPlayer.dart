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
    initialController();
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.path != widget.video.path) {
      initialController();
    }
  }

  void initialController() async {
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
              if (showControls)
                _NewVideo(
                  onNewVideoPressed: widget.onNewVideo,
                ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Row(
                  children: [
                    Text(
                      '${videoController!.value.position.inMinutes}:${(videoController!.value.position.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                          min: 0,
                          max: videoController!.value.duration.inSeconds
                              .toDouble(),
                          value: videoController!.value.position.inSeconds
                              .toDouble(),
                          onChanged: (double val) {
                            videoController!
                                .seekTo(Duration(seconds: val.toInt()));
                          }),
                    ),
                    Text(
                      '${videoController!.value.duration.inMinutes}:${(videoController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void onPlayPressed() {
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;
    Duration position = Duration();
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - const Duration(seconds: 3);
    }
    videoController!.seekTo(position);
  }

  void onForwardPressed() {
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
            onPressed: onReversePressed,
            iconData: Icons.rotate_left,
          ),
          renderIconButton(
            onPressed: onPlayPressed,
            iconData: isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          renderIconButton(
            onPressed: onForwardPressed,
            iconData: Icons.rotate_right,
          ),
        ],
      ),
    );
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
  final VoidCallback onNewVideoPressed;

  const _NewVideo({required this.onNewVideoPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
          onPressed: onNewVideoPressed,
          icon: const Icon(
            Icons.photo_camera_back,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}
