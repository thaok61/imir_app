import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/components/animation_logo.dart';
import 'package:imir_app/components/music_card.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music.dart';
import 'package:imir_app/network/music_dao.dart';
import 'package:provider/provider.dart';

class MusicListScreen extends StatelessWidget {
  const MusicListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          leading: AnimationLogo(
            width: 30,
            height: 30,
          ),
          title: Text(
            '!! Hi, new fellow',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
          actions: [
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.repeat)
          ],
          backgroundColor: Colors.black,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.black,
                    Colors.white,
                  ])),
            ),
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
              StretchMode.blurBackground
            ],
          ),
          pinned: false,
          stretch: true,
          onStretchTrigger: () async {
            print('Load new data');
          },
        ),
        StreamBuilder(
          stream:
              Provider.of<MusicDao>(context, listen: false).getMusicStream(),
          builder: (context, snapshot) {
            var myMusicsSnapshot = Map<dynamic, dynamic>();
            if (snapshot.hasData) {
              myMusicsSnapshot = (snapshot.data as DatabaseEvent).snapshot.value
                  as Map<dynamic, dynamic>;
            }
            return _buildList(context, myMusicsSnapshot);
          },
        ),
      ],
    );
  }

  Widget _buildList(context, Map<dynamic, dynamic> listMusicsJson) {
    final musics = <Music>[];
    listMusicsJson.forEach((key, value) {
      musics.add(Music.fromJson(value));
    });
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return _buildMusicCard(context, musics, index);
    }, childCount: musics.length));
  }

  Widget _buildMusicCard(BuildContext context, List<Music> musics, int index) {
    final music = musics[index];
    return MusicCard(music: music);
  }
}
