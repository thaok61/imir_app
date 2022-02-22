
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:imir_app/network/music.dart';

class MusicStateManager extends ChangeNotifier {
  MusicStateManager() {
      _audioPlayer.onPlayerStateChanged.listen((event) {
        print('event: $event');
        _playerState = event;
        notifyListeners();
      });

      _audioPlayer.onDurationChanged.listen((event) {
        _totalDuration = event;
        print('_totalDuration: $event');
        notifyListeners();
      });

      _audioPlayer.onAudioPositionChanged.listen((event) {
        _currentPosition = event;
        notifyListeners();
      });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Music? _music = null;
  Music? get music => _music;

  PlayerState? _playerState = null;
  PlayerState? get playerState => _playerState;

  Duration? _totalDuration = null;
  Duration? get totalDuration => _totalDuration;

  Duration? _currentPosition = null;
  Duration? get currentPosition => _currentPosition;

  play(String url) async {
    int result = await _audioPlayer.play(url);
    if (result == 1) {
      print('play Success');
    }
  }

  void resume() async {
    int result = await _audioPlayer.resume();
    if (result == 1) {
      print('resume Success');
      notifyListeners();
    }
  }

  void pause() async {
    int result = await _audioPlayer.pause();
    if (result == 1) {
      print('pause Success');
      notifyListeners();
    }
  }

  void seekAudio(Duration duration) {
    _audioPlayer.seek(duration);
  }

  void setCurrentMusic(Music playingMusic) {
    _music = playingMusic;
    play(_music!.url);
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}