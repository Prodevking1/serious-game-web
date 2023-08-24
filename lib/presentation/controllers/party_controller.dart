import 'package:flame_game/domain/entities/game_state.dart';
import 'package:flame_game/domain/entities/region.dart';
import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/party.dart';

class PartyController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  Future updatePartyStatus(Party party, Status newStatus) async {
    party.status = newStatus;
    await localStorage.updateData("parties", party.toJson());
  }
}
