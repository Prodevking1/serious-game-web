import 'package:flame_game/domain/entities/line.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/person.dart';
import '../../domain/entities/region.dart';
import '../controllers/evolution_controller.dart';
import '../controllers/party_controller.dart';
import '../routes/router.dart';
import '../widgets/dialog_scene.dart';

class Level1Screen extends StatelessWidget {
  Level1Screen({
    super.key,
  });

  EvolutionController evolutionController = Get.find();

  PartyController partyController = Get.find();
  final Region? region = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
      ),
      Line(
          speaker: teacher,
          text:
              "Tu verras les réalités auxquelles sont confrontés de nombreux enfants. Certaines filles n'ont pas la chance d'aller à l'école."),
      Line(
          speaker: mounira,
          text:
              "C'est injuste ! Chaque enfant devrait pouvoir étudier et réaliser son potentiel."),
    ]);

    Dialogue dialogueWithHamidou =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          speaker: hamidou,
          text:
              "Dans mon village, seuls les garçons vont à l'école. Mes parents disent que ce n'est pas la peine de scolariser une fille."),
      Line(
          speaker: mounira,
          text:
              "Mais c'est si important que les filles soient instruites ! L'égalité des sexes passe par l'éducation. J'aimerais convaincre tes parents."),
    ]);

    Dialogue dialogueWithFarida =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          speaker: farida,
          text:
              "Moi j'ai dû arrêter l'école l'année dernière pour aider aux tâches ménagères et m'occuper de mes frères et sœurs."),
      Line(
          speaker: mounira,
          text:
              "Farida, tu mérites de poursuivre tes études et de décider de ton avenir ! Je vais me battre pour que tu aies cette chance."),
    ]);

    Dialogue dialogueWithDjamila =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          speaker: djamila,
          text:
              "Je veux être pilote d'avion pour voyager partout dans le monde. Mais on dit que c'est un métier d'homme."),
      Line(
          speaker: mounira,
          text:
              "Les filles peuvent faire ce qu'elles veulent comme les garçons. Je vais te montrer que tu peux réaliser ton rêve."),
    ]);

    Dialogue dialogueWithChief =
        Dialogue(description: "Le grand depart", lines: [
      Line(
          speaker: chief,
          text:
              "Le chemin vers le changement est long. Mais tu as la volonté d'agir pour l'égalité et l'éducation de tous."),
      Line(
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
        onDialogueEnd: () {
          partyController.incrementPartyScore(
            region: region!,
            score: PartyReward.basicRewardPoints,
          );
          evolutionController.incrementScore(PartyReward.basicRewardPoints);
          evolutionController.incrementLevel(1);
          Get.offAllNamed(AppRoutes.homePage);
        });
  }
}
