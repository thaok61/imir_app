import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:imir_app/components/music_player.dart';

class MusicDao {
  final DatabaseReference musicRef = FirebaseDatabase.instance.ref('Releases');

  Stream<DatabaseEvent> getMusicStream() {
    return musicRef.orderByKey().onValue;
  }
}
