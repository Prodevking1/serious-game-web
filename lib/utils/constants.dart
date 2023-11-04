import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  static AnimatedTextKit typewriterStyle(text) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          textAlign: TextAlign.center,
          cursor: '',
          text,
          textStyle: subtitle,
          speed: const Duration(milliseconds: 50),
        ),
      ],
    );
  }
}

class AppMedia {
  static const String introSound = 'assets/sounds/intro.mp3';
  static const String introBackgroundImage = 'assets/images/intro-bg.png';
  static const String mapImage = 'assets/images/3d-map.jpeg';
  static const String mounira = 'assets/images/mounira.png';
  static const String teacher = 'assets/images/teacher.png';
  static const String hamidou = 'assets/images/hamidou.png';
  static const String safi = 'assets/images/safi.png';
  static const String djamila = 'assets/images/safi.png';
  static const String chief = 'assets/images/chief.png';
  static const String olderWoman = 'assets/images/older.png';

  static const String animtedBackground = 'assets/animations/background.json';
  static const String animatedSPeaker = 'assets/animations/speaker.json';
}

class AppColors {
  static const Color primaryColor = Color(0xff0743919);
  static const Color secondaryColor = Color(0xff026B52);
  static const Color tertiaryColor = Color(0xffffd700);
}

class PartyReward {
  static const int basicRewardPoints = 100;
  static const int bonusRewardPoints = 50;

  static const int wrongAnswerPenalty = 10;
  static const int correctAnswerReward = 20;
}
