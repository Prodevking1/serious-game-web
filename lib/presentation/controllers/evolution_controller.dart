import 'package:get/get.dart';

import '../../data/source/local_storage.dart';

class EvolutionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  static final RxInt _totalScore = 0.obs;
  static final RxInt _level = 0.obs;

  static int get totalScore => _totalScore.value;
  static int get level => _level.value;

  @override
  void onInit() {
    print('init');
    // fetchSavedScore();
    super.onInit();
  }

  incrementScore(int score) {
    _totalScore.value += score;
    saveScore();
  }

  incrementLevel(int level) {
    _level.value += level;
    saveLevel();
  }

  fetchSavedScore() {
    final res = localStorage.getData("score");
    if (res != null) {
      _totalScore.value = res;
    }
  }

  fetchCurrentLevel() {
    final res = localStorage.getData("level");
    if (res != null) {
      _level.value = res;
    }
  }

  saveScore() {
    localStorage.saveData("score", _totalScore.value);
  }

  saveLevel() {
    LocalStorage().saveData("level", _level.value);
  }
}
