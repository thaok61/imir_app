import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:provider/provider.dart';

class AnimationArtwork extends StatefulWidget {
  final String artWork;
  final double radius;

  const AnimationArtwork(
      {Key? key, required this.artWork, required this.radius})
      : super(key: key);

  @override
  State<AnimationArtwork> createState() => _AnimationArtworkState();
}

class _AnimationArtworkState extends State<AnimationArtwork>
    with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: Duration(seconds: 30),
    vsync: this,
  );
  late Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicStateManager>(
        builder: (context, musicStateManager, child) {
      if (musicStateManager.playerState == PlayerState.PLAYING) {
        _controller.repeat();
      } else {
        _controller.stop();
      }

      return RotationTransition(
        turns: _animation,
        child: ClipOval(
          child: SizedBox.fromSize(
            child: Image.network(
              widget.artWork,
              fit: BoxFit.cover,
            ),
            size: Size.fromRadius(widget.radius),
          ),
        ),
      );
    });
  }
}
