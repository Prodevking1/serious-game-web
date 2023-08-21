import 'package:get/get.dart';

import '../../data/source/local_storage.dart';

class EvolutionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  static final RxInt _totalScore = 0.obs;
  static final RxInt _level = 0.obs;

  static int get totalScore => _totalScore.value;
  static int get level => _level.value;

  @override
  void onInit() async {
    await fetchSavedScore();
    await fetchCurrentLevel();
    super.onInit();
  }

  incrementScore(int score) async {
    _totalScore.value += score;
    await saveScore();
  }

  incrementLevel(int level) async {
    _level.value += level;
    await saveLevel();
  }

  fetchSavedScore() async {
    final res = await localStorage.getData("score");
    print(res);
    if (res != null) {
      _totalScore.value = res;
    }
  }

  fetchCurrentLevel() async {
    final res = await localStorage.getData("level");
    print(res);
    if (res != null) {
      _level.value = res;
    }
  }

  Future<void> saveScore() async {
    try {
      await localStorage.saveData("score", _totalScore.value);
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveLevel() async {
    try {
      await localStorage.saveData("level", _level.value);
    } catch (e) {
      print(e);
    }
  }
}
