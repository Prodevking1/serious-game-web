import 'package:flame_game/data/source/local_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

import '../domain/entities/player.dart';

class GameAudioPlayer {
  final player = AudioPlayer();

  void playAudio(String url, {bool isLooping = false}) {
    player.setAsset(url);
    player.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    player.play();
  }

  void stopAudio() {
    player.stop();
  }

  void pauseAudio() {
    player.pause();
  }
}

class PlayerData {
  
}
