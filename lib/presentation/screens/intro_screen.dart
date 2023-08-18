import 'package:flame_game/presentation/routes/router.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flame_game/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    //GameAudioPlayer().playAudio(AppMedia.introSound, isLooping: true);
  }

  @override
  void dispose() {
    GameAudioPlayer().stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onTap: () {},
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppMedia.introBackgroundImage,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: Get.width / 5,
                top: Get.height / 2.5,
                child: CustomCard(
                  width: Get.width * 0.3,
                  height: Get.height * 0.3,
                  padding: const EdgeInsets.all(10),
                  child: AppTextStyles.typewriterStyle(
                    "Salut ! \n Moi c'est Aissa. Commençons l'aventure 😃",
                  ),
                ),
              ),
              Positioned(
                left: Get.width / 6,
                top: Get.height * 0.8,
                child: CustomGameButton(
                  width: Get.width * 0.38,
                  text: 'Commencer le jeu',
                  onPressed: () {
                    Get.offAllNamed(AppRouter.registerPage);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    ));
  }
}
