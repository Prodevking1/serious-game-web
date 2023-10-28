import 'package:flame_game/data/source/local_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

import '../domain/entities/player.dart';

class GameAudioPlayer extends GetxController {
  final player = AudioPlayer();

  playBackgroundMusic() {
    player.setAsset('assets/sounds/intro.mp3');
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  Future playClickSound() async {
    player.setAsset('assets/sounds/click.mp3');
    player.setLoopMode(LoopMode.off);
    player.play();
  }

  Future playFail() async {
    print('play fail');
    player.setAsset('assets/sounds/fail.mp3');
    player.setLoopMode(LoopMode.off);
    player.play();
  }

  void playCustom(String audioPath) {
    player.setAsset(audioPath);
    player.setLoopMode(LoopMode.off);
    player.play();
  }

  void stopAudio() {
    print('stop audio');
    player.stop();
  }

  void pauseAudio() {
    player.pause();
  }
}

class PlayerData {}
