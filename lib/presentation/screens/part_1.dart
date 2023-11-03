import 'package:flame_game/domain/entities/game_state.dart';
import 'package:flame_game/domain/entities/line.dart';
import 'package:flame_game/presentation/controllers/region_controller.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/person.dart';
import '../../domain/entities/region.dart';
import '../../utils/helpers.dart';
import '../controllers/evolution_controller.dart';
import '../controllers/party_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/button_widget.dart';
import '../widgets/dialog_scene.dart';

class Level1Screen extends StatelessWidget {
  Level1Screen({
    super.key,
  });

  EvolutionController evolutionController = Get.find();
  PartyController partyController = Get.find();
  final Region? region = Get.arguments;
  Tts tts = Get.put(Tts());

  @override
  Widget build(BuildContext context) {
    print(region!.party!.status);
    final Person mounira = Person(name: 'Mounira', imagePath: AppMedia.mounira);
    final Person teacher =
        Person(name: 'Enseignante', imagePath: AppMedia.teacher);

    final Person farida = Person(name: 'Farida', imagePath: AppMedia.safi);
    final Person djamila = Person(name: 'Djamila', imagePath: AppMedia.djamila);

    final Person hamidou = Person(name: 'Hamidou', imagePath: AppMedia.hamidou);
    final Person chief =
        Person(name: 'Chef du village', imagePath: AppMedia.chief);

    Dialogue dialogueWithTeacher =
        Dialogue(description: 'Le grand depart.', lines: [
      Line(
        speaker: mounira,
        text:
            "Je suis prête à entreprendre ce voyage pour en apprendre plus sur notre pays.",
        audioPath: "assets/sounds/b1.ogg",
      ),
      Line(
          audioPath: AppMedia.introSound,
          speaker: teacher,
          text:
              "Tu verras les réalités auxquelles sont confrontés de nombreux enfants. Certaines filles n'ont pas la chance d'aller à l'école."),
      Line(
          audioPath: "assets/sounds/2.ogg",
          speaker: mounira,
          text:
              "C'est injuste ! Chaque enfant devrait pouvoir étudier et réaliser son potentiel."),
    ]);

    Dialogue dialogueWithHamidou =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          audioPath: AppMedia.introSound,
          speaker: hamidou,
          text:
              "Dans mon village, seuls les garçons vont à l'école. Mes parents disent que ce n'est pas la peine de scolariser une fille."),
      Line(
          audioPath: "assets/sounds/3.ogg",
          speaker: mounira,
          text:
              "Mais c'est si important que les filles soient instruites ! L'égalité des sexes passe par l'éducation. J'aimerais convaincre tes parents."),
    ]);

    Dialogue dialogueWithFarida =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          audioPath: AppMedia.introSound,
          speaker: farida,
          text:
              "Moi j'ai dû arrêter l'école l'année dernière pour aider aux tâches ménagères et m'occuper de mes frères et sœurs."),
      Line(
          audioPath: "assets/sounds/4.ogg",
          speaker: mounira,
          text:
              "Farida, tu mérites de poursuivre tes études et de décider de ton avenir ! Je vais me battre pour que tu aies cette chance."),
    ]);

    Dialogue dialogueWithDjamila =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          audioPath: AppMedia.introSound,
          speaker: djamila,
          text:
              "Je veux être pilote d'avion pour voyager partout dans le monde. Mais on dit que c'est un métier d'homme."),
      Line(
          audioPath: "assets/sounds/5.ogg",
          speaker: mounira,
          text:
              "Les filles peuvent faire ce qu'elles veulent comme les garçons. Je vais te montrer que tu peux réaliser ton rêve."),
    ]);

    Dialogue dialogueWithChief =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          audioPath: AppMedia.introSound,
          speaker: chief,
          text:
              "Le chemin vers le changement est long. Mais tu as la volonté d'agir pour l'égalité et l'éducation de tous."),
      Line(
          audioPath: "assets/sounds/6.ogg",
          speaker: mounira,
          text:
              "Oui, ce voyage sera l'occasion d'en apprendre plus et de sensibiliser sur ces enjeux. Le changement viendra !"),
    ]);

    return DialogScene(
        dialogue: [
          dialogueWithTeacher,
          dialogueWithHamidou,
          dialogueWithFarida,
          dialogueWithDjamila,
          dialogueWithChief
        ],
        onDialogueEnd: () async {
          tts.flutterTts.stop();

          await partyController.updatePartyStatus(region!.party!, Status.won);

          Get.dialog(
            barrierDismissible: false,
            AlertDialog(
              title: const Center(
                child: Text(
                  '🎉 Bravo ! Tu viens de gagner ${PartyReward.basicRewardPoints} points',
                  style: AppTextStyles.subtitle,
                ),
              ),
              content: const SizedBox(
                width: 300,
                child: Text(
                  "L'éducation est très importante pour les filles autant que pour les garçons !",
                  style: AppTextStyles.body,
                ),
              ),
              actions: [
                CustomGameButton(
                  text: 'Continuer',
                  onPressed: () async {
                    Get.offAllNamed(AppRoutes.homePage);
                    await evolutionController.incrementScoreAndLevel(
                        score: PartyReward.basicRewardPoints);
                  },
                )
              ],
            ),
          );
          Get.find<RegionController>().onInit();
          Get.find<EvolutionController>().onInit();
          // Get.offAllNamed(AppRoutes.homePage);
        });
  }
}
