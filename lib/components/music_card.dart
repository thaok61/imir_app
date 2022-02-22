import 'package:flutter/material.dart';
import 'package:imir_app/models/app_state_manager.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:provider/provider.dart';

import 'circle_image.dart';

class MusicCard extends StatelessWidget {
  final Music music;

  const MusicCard({Key? key, required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MusicStateManager>(context, listen: false)
            .setCurrentMusic(music);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1
              Row(
                children: [
                  CircleImage(
                    imageProvider: music.artWork,
                    imageRadius: 28,
                  ),
                  // 2
                  const SizedBox(width: 8),
                  // 3
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        music.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        music.artist,
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    print('onPressed');
                  },
                  icon: Icon(Icons.more_vert))
            ],
          ),
        ),
      ),
    );
  }
}
