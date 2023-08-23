import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/stats.dart';

class EvolutionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  static final RxInt _totalScore = 0.obs;
  static final RxInt _level = 0.obs;

  static int get totalScore => _totalScore.value;
  static int get level => _level.value;

  @override
  void onInit() async {
    await fetchSavedStats();
    //await fetchCurrentLevel();
    super.onInit();
  }

  fetchSavedStats() {
    final stats = localStorage.getData("stats");
    print(stats);
    return localStorage.getData("stats");
  }

  /* incrementScore(int score) async {
    _totalScore.value += score;
    await saveScore();
  }

  incrementLevel(int level) async {
    _level.value += level;
    await updateLevel();
  } */

/*   fetchSavedScore() async {
    final res = await localStorage.getData("score");
    print(res);
    _totalScore.value = res;
  }

  fetchCurrentLevel() async {
    final res = await localStorage.getData("level");
    print(res);
    _level.value = res;
  } */

/*   Future<void> saveScore() async {
    try {
      await localStorage.insertData("score", _totalScore.value);
    } catch (e) {
      print(e);
    }
  } */

  Future<void> updateStats(Stats stats) async {
    try {
      await localStorage.updateData("stats", stats.toJson());
    } catch (e) {
      print(e);
    }
  }
}
