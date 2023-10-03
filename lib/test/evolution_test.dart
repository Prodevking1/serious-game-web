import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flame_game/presentation/controllers/auth_controller.dart';
import 'package:flame_game/presentation/controllers/evolution_controller.dart';

import '../utils/constants.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  group('Evolution du joueur', () {
    // test('Augmenter score et level', () async {
    //   // Arrange
    //   final evolutionController = EvolutionController();
    //   final initialTotalScore = EvolutionController.totalScore;
    //   final initialLevel = EvolutionController.level;

    //   // Act
    //   await evolutionController.incrementScoreAndLevel(score: 100);

    //   // Assert
    //   expect(EvolutionController.totalScore, equals(initialTotalScore + 100));
    //   expect(EvolutionController.level, equals(initialLevel + 1));
    // });

    // test('Punir le joueur', () async {
    //   // Arrange
    //   final evolutionController = EvolutionController();
    //   final initialTotalScore = EvolutionController.totalScore;

    //   // Act
    //   evolutionController.punishPlayer();

    //   // Assert
    //   expect(EvolutionController.totalScore,
    //       equals(initialTotalScore - PartyReward.wrongAnswerPenalty));
    // });

    test('Recompenser le joueur', () async {
      // Arrange
      final evolutionController = EvolutionController();
      final initialTotalScore = EvolutionController.totalScore;

      // Act
      evolutionController.rewardPlayer();

      // Assert
      expect(EvolutionController.totalScore,
          equals(initialTotalScore + PartyReward.correctAnswerReward));
    });
  });
}
