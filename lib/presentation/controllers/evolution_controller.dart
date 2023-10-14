import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/stats.dart';

class EvolutionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  // AuthController authController = Get.find();
  AuthController authController = AuthController();

  SupabaseClient supabaseClient = Get.find();

  static final RxInt _totalScore = 0.obs;
  static final RxInt _level = 0.obs;

  static int get totalScore => _totalScore.value;
  static int get level => _level.value;

  Player? _player;

  RxList<Player> players = <Player>[].obs;

  @override
  void onInit() async {
    await getRanking();
    await fetchSavedStats();
    _player = await authController.getCurrentPlayer();
    // await localStorage.deleteAllData("stats");
    super.onInit();
  }

  fetchSavedStats() async {
    // final stats = await localStorage.getData("stats");
    // _totalScore.value = stats.first["score"];
    // _level.value = stats.first["level"];
  }

  Future incrementScoreAndLevel({required int score}) async {
    _totalScore.value += score;
    _level.value += 1;
    await updateStats();
  }

  Future updateStats() async {
    if (_player != null) {
      Stats newStats = Stats(
          player_id: _player!.id,
          total_score: _totalScore.value,
          level: _level.value);

      try {
        await localStorage.updateData(
          "stats",
          newStats.toJson(),
        );

        await supabaseClient.from("player_stats").upsert({
          "player_id": _player!.id,
          "total_score": _totalScore.value,
          "level": _level.value,
        });
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  void punishPlayer() {
    _totalScore.value -= PartyReward.wrongAnswerPenalty;
  }

  void rewardPlayer() {
    _totalScore.value += PartyReward.correctAnswerReward;
  }

  Future resetStats() async {
    _totalScore.value = 0;
    _level.value = 0;
    await updateStats();
  }

  Future getRanking() async {
    final res = await supabaseClient
        .from("players")
        .select("id, name, gender, player_stats(total_score)");
    if (res != null) {
      players.clear();
      res.forEach((element) {
        players.add(Player.fromJson(element));
      });
      return res;
    }
  }
}
