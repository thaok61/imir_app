import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/components/animation_artwork.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:provider/provider.dart';

import '../utils.dart';
import 'music_player.dart';

class MaxSizeMusicPlayer extends StatelessWidget {
  final Music music;
  final double height;
  final double width;
  final maxImgSize;

  const MaxSizeMusicPlayer(
      {Key? key,
      required this.music,
      required this.height,
      required this.width})
      : maxImgSize = width * 0.4,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressIndicator = SliderTheme(
        data: SliderThemeData(
          trackHeight: 6,
          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
        ),
        child: Consumer<MusicStateManager>(
            builder: (context, musicStateManager, child) {
          Duration? currentPosition = musicStateManager.currentPosition;
          Duration? totalDuration = musicStateManager.totalDuration;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(currentPosition == null
                    ? '00:00'
                    : '${convertSecondsToString(currentPosition.inSeconds)}'),
                Flexible(
                  child: Slider(
                    value: currentPosition == null
                        ? 0
                        : currentPosition.inMilliseconds.toDouble(),
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      musicStateManager
                          .seekAudio(Duration(milliseconds: value.toInt()));
                    },
                    min: 0,
                    max: totalDuration == null
                        ? 20
                        : totalDuration.inMilliseconds.toDouble(),
                  ),
                ),
                Text(totalDuration == null
                    ? '00:00'
                    : '${convertSecondsToString(totalDuration.inSeconds)}'),
              ],
            ),
          );
        }));

    var percentageExpandedPlayer = percentageFromValueInRange(
        min:
            playerMaxHeight * miniplayerPercentageDeclaration + playerMinHeight,
        max: playerMaxHeight,
        value: height);
    if (percentageExpandedPlayer < 0) percentageExpandedPlayer = 0;
    final paddingVertical = valueFromPercentageInRange(
        min: 0, max: 10, percentage: percentageExpandedPlayer);
    final double heightWithoutPadding = height - paddingVertical * 2;
    final double imageSize =
        heightWithoutPadding > maxImgSize ? maxImgSize : heightWithoutPadding;
    final paddingLeft = valueFromPercentageInRange(
          min: 0,
          max: width - imageSize,
          percentage: percentageExpandedPlayer,
        ) /
        2;

    final buttonSkipForward = IconButton(
      icon: Icon(Icons.skip_next),
      iconSize: 33,
      onPressed: () {},
    );
    final buttonSkipBackwards = IconButton(
      icon: Icon(Icons.skip_previous),
      iconSize: 33,
      onPressed: () {},
    );

    final buttonPlayExpanded = Consumer<MusicStateManager>(
        builder: (context, musicStateManager, child) {
      bool isPlaying = musicStateManager.playerState == PlayerState.PLAYING;
      return IconButton(
        icon: isPlaying
            ? Icon(Icons.pause_circle_filled)
            : Icon(Icons.play_circle_filled),
        iconSize: 50,
        onPressed: () {
          isPlaying ? musicStateManager.pause() : musicStateManager.resume();
        },
      );
    });

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: paddingLeft,
                top: paddingVertical,
                bottom: paddingVertical),
            child: SizedBox(
              height: imageSize,
              child: AnimationArtwork(
                artWork: music.artWork,
                radius: imageSize / 2,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Opacity(
              opacity: percentageExpandedPlayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(child: Text(music.name)),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonSkipBackwards,
                        buttonPlayExpanded,
                        buttonSkipForward
                      ],
                    ),
                  ),
                  Flexible(child: progressIndicator),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
