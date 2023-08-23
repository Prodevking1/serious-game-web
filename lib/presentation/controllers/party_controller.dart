import 'package:flame_game/domain/entities/game_state.dart';
import 'package:flame_game/domain/entities/region.dart';
import 'package:get/get.dart';

import '../../data/source/local_storage.dart';

class PartyController extends GetxController {
  LocalStorage localStorage = LocalStorage();

 /*  updateRegionStatus(Status status) {
    localStorage.saveData("region", "region");
  }

  void updateGameStatus(Status gameState) {}

  incrementPartyScore({required Region region, required int score}) {
    region.party.finalScore = (region.party.finalScore ?? 0) + score;
    localStorage.saveData("region", region.toJson());
  } */
}
