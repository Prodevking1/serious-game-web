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

  //Part 2
  Map<String, List<String>> questionsWithAnswers = {
    "Mais à quoi servira l'école pour ma fille ?": [
      "Se marier et s'occuper de la maison",
      "Savoir lire, écrire et avoir un métier",
      "Cuisiner et obéir à son mari",
      "Savoir lire, écrire et avoir un métier"
    ],
    "Nous n'avons pas les moyens de scolariser tous nos enfants. Que faire ?": [
      "Envooyer seulement les garçons à l'école",
      "Retirer tous les enfants de l'école",
      "Scolariser filles et garçons car c'est un droit essentiel",
      "Scolariser filles et garçons car c'est un droit essentiel"
    ],
    "Mon mari refuse d'envoyer notre fille à l'école. Comment le convaincre ?":
        [
      "Ne rien dire pour éviter les conflits",
      "Expliquer que l'éducation bénéficie à toute la famille",
      "Interdire à sa fille de lui parler tant qu'il n'accepte pas",
      "Expliquer que l'éducation bénéficie à toute la famille"
    ],
  };

  Future<bool> answerToQuestion(String selectedAnswer) async {
    final allAnswers = questionsWithAnswers.values.expand((answers) => answers);

    int occurrences =
        allAnswers.where((answer) => answer == selectedAnswer).length;
    return occurrences == 2;
  }
}
