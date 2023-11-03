import 'package:flame_game/data/source/local_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

import '../domain/entities/line.dart';
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
    player.stop();
  }

  void pauseAudio() {
    player.pause();
  }
}

class PlayerData {}

class Tts extends GetxController{
  FlutterTts flutterTts = FlutterTts();
  double pitchRate = 1;

  var voice = {'name': 'fr-fr-x-vlf-local', 'locale': 'fr-FR'};
  Future<void> speakText(Line line) async {
    await flutterTts.setLanguage('fr-FR');

    if (!["Hamidou", "Chef du village"].contains(line.speaker.name)) {
      pitchRate = 1;
    }
    switch (line.speaker.name) {
      case "Djamila":
        voice = {'name': 'fr-fr-x-frc-local', 'locale': 'fr-FR'};
        pitchRate = 1.3;
      case 'Mounira':
        voice = {'name': 'fr-fr-x-vlf-local', 'locale': 'fr-FR'};

      case "Enseignante":
        pitchRate = .8;
      case "Farida":
        pitchRate = 2;
      case "Hamidou":
        pitchRate = 1;
        voice = {'name': 'fr-fr-x-frb-network', 'locale': 'fr-FR'};

      case "Chef du village":
        voice = {'name': 'fr-fr-x-frb-network', 'locale': 'fr-FR'};
        pitchRate = .5;
    }
    await flutterTts.setPitch(pitchRate);

    flutterTts.setVoice(voice);

    await flutterTts.speak(line.text);
  }

  void stop() {
    flutterTts.stop();
  }
}
