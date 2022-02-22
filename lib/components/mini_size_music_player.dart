import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/components/animation_artwork.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:imir_app/network/music_dao.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'music_player.dart';

class MiniSizeMusicPlayer extends StatelessWidget {
  final Music music;
  final double height;
  final double width;

  const MiniSizeMusicPlayer(
      {Key? key,
      required this.music,
      required this.height,
      required this.width,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final maxImgSize = width * 0.4;
    final percentageMiniplayer = percentageFromValueInRange(
        min: playerMinHeight,
        max:
            playerMaxHeight * miniplayerPercentageDeclaration + playerMinHeight,
        value: height);

    final elementOpacity = 1 - 1 * percentageMiniplayer;
    final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

    final buttonPlay = Consumer<MusicStateManager>(
        builder: (context, musicStateManager, child) {
      bool isPlaying = musicStateManager.playerState == PlayerState.PLAYING;
      return IconButton(
        icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        onPressed: () {
          isPlaying ? musicStateManager.pause() : musicStateManager.resume();
        },
      );
    });

    final progressIndicator = Consumer<MusicStateManager>(
        builder: (context, musicStateManager, child) {
      double percentProgressBar = 0.0;
      if (musicStateManager.totalDuration != null &&
          musicStateManager.currentPosition != null) {
        percentProgressBar = musicStateManager.currentPosition!.inMilliseconds /
            musicStateManager.totalDuration!.inMilliseconds;
      }
      return LinearProgressIndicator(value: percentProgressBar);
    });

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: maxImgSize),
                  child: AnimationArtwork(
                    radius: playerMinHeight / 2 - 8,
                    artWork: music.artWork,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Opacity(
                    opacity: elementOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(music.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontSize: 16)),
                        Text(
                          music.artist,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .color!
                                        .withOpacity(0.55),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Opacity(
                  opacity: elementOpacity,
                  child: buttonPlay,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: progressIndicatorHeight,
          child: Opacity(
            opacity: elementOpacity,
            child: progressIndicator,
          ),
        ),
      ],
    );
  }
}
