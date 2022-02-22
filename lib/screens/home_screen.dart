import 'package:flutter/material.dart';
import 'package:imir_app/components/music_player.dart';
import 'package:imir_app/models/app_state_manager.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:imir_app/screens/music_list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MusicStateManager>(
        builder: (context, appStateManager, child) {
          Music? music = appStateManager.music;
          return Stack(children: [
            MusicListScreen(),
            if (music != null) MusicPlayer(music: music)
          ]);
        },
      ),
    );
  }
}
