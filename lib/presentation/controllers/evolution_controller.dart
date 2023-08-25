import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/stats.dart';

class EvolutionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  AuthController authController = Get.find();

  static final RxInt _totalScore = 0.obs;
  static final RxInt _level = 0.obs;

  static int get totalScore => _totalScore.value;
  static int get level => _level.value;

  Player? _player;

  @override
  void onInit() async {
    await fetchSavedStats();
    // _player = await authController.getCurrentPlayer();
    // await localStorage.deleteAllData("stats");
    super.onInit();
  }

  fetchSavedStats() async {
    final stats = await localStorage.getData("stats");
    _totalScore.value = stats.first["score"];
    _level.value = stats.first["level"];
  }

  Future incrementScoreAndLevel({required int score}) async {
    _totalScore.value += score;
    _level.value += 1;
    await updateStats();
  }

  Future updateStats() async {
    _player = await authController.getCurrentPlayer();

    if (_player != null) {
      Stats newStats = Stats(
          player_id: _player!.id,
          total_score: _totalScore.value,
          level: _level.value);
      print(newStats.toJson());

      try {
        await localStorage.updateData(
          "stats",
          newStats.toJson(),
        );
      } catch (e) {
        print(e);
      }
    }
  }
}
