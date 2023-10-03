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
    "Les filles devraient-elles être scolarisées comme les garçons ?": [
      "Oui, l'éducation profite à toute la société",
      "Oui, l'éducation est un droit pour tous",
      "Non, l'école ne sert à rien pour les filles",
      "Oui, l'éducation profite à toute la société"
    ],
    "Qu'est-ce qui empêche la scolarisation des filles dans notre village ?": [
      "Les traditions et le manque d'argent",
      "Les traditions sur le rôle des femmes",
      "Le manque d'argent des parents",
      "Les traditions et le manque d'argent"
    ],
    "Comment l'éducation rend-elle les filles plus autonomes ?": [
      "Plus de opportunités dans la vie",
      "Plus d'opportunités et confiance en soi",
      "Confiance en soi renforcée pour réaliser leurs rêves",
      "Plus d'opportunités et confiance en soi"
    ],
    "Une fille qui étudie peut-elle rester une bonne épouse ?": [
      "Oui, elle sera plus épanouie",
      "Non, elle ne respectera plus les traditions",
      "Oui, l'éducation aide à s'épanouir dans la tradition",
      "Oui, l'éducation aide à s'épanouir dans la tradition"
    ],
    "Comment motiver les parents à envoyer leurs filles à l'école ?": [
      "Expliquer les bienfaits et aider financièrement",
      "Expliquer les bienfaits de leur éducation",
      "Proposer des bourses et aides financières",
      "Expliquer les bienfaits et aider financièrement"
    ],
    "Quels changements pour le village avec plus de filles éduquées ?": [
      "Des conditions de vie améliorées",
      "Conditions de vie et société améliorées",
      "Une société plus égale et respectueuse",
      "Conditions de vie et société améliorées"
    ]
  };

  Future<bool> answerToQuestion(String selectedAnswer) async {
    final allAnswers = questionsWithAnswers.values.expand((answers) => answers);

    int occurrences =
        allAnswers.where((answer) => answer == selectedAnswer).length;
    return occurrences == 2;
  }
}
