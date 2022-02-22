import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoBackground extends StatefulWidget {
  const VideoBackground({Key? key}) : super(key: key);

  @override
  _VideoBackgroundState createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
  late VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoPlayerController.value.size.width,
          height: _videoPlayerController.value.size.height,
          child: VideoPlayer(_videoPlayerController),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Random random = new Random();
    _videoPlayerController =
        VideoPlayerController.asset('assets/splash_video.mp4')
    ..initialize().then((_) {
      // int randomDuration = random.nextInt(16);
      // _videoPlayerController.seekTo(Duration(seconds: randomDuration));
      _videoPlayerController.play();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
  }
}
