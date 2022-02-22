import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/components/max_size_music_player.dart';
import 'package:imir_app/components/mini_size_music_player.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

const double playerMinHeight = 70;
const double playerMaxHeight = 370;
const miniplayerPercentageDeclaration = 0.2;

class MusicPlayer extends StatelessWidget {
  final Music music;

  const MusicPlayer({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MusicStateManager musicStateManager =
        Provider.of<MusicStateManager>(context);
    return Miniplayer(
        minHeight: playerMinHeight,
        maxHeight: playerMaxHeight,
        builder: (height, percentage) {
          final bool miniplayer = percentage < miniplayerPercentageDeclaration;
          final double width = MediaQuery.of(context).size.width;
          //Declare additional widgets (eg. SkipButton) and variables
          if (!miniplayer) {
            return MaxSizeMusicPlayer(
              music: music,
              height: height,
              width: width,
            );
          }
          //Miniplayer
          return MiniSizeMusicPlayer(
            music: music,
            height: height,
            width: width,
          );
        });
  }
}

