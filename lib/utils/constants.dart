import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle subtitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static AnimatedTextKit typewriterStyle(text) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          textAlign: TextAlign.center,
          cursor: '',
          text,
          textStyle: subtitle,
          speed: const Duration(milliseconds: 100),
        ),
      ],
    );
  }
}

class AppMedia {
  static const String introSound = 'assets/sounds/intro.mp3';
  static const String introBackgroundImage = 'assets/images/intro-bg.png';
  static const String mapImage = 'assets/images/3d-map.jpeg';
}

class AppColors {
  static const Color primaryColor = Color(0xff0743919);
  static const Color secondaryColor = Color(0xff026B52);
  static const Color tertiaryColor = Color(0xffFEEEC0);
}
