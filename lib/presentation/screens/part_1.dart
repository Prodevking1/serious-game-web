import 'package:flame_game/domain/entities/line.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/person.dart';
import '../widgets/dialog_scene.dart';

class Level1Screen extends StatelessWidget {
  const Level1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final Person aissa = Person(name: 'Aissa', imagePath: AppMedia.aissa);
    final Person teacher =
        Person(name: 'Enseignante', imagePath: AppMedia.teacher);

    Dialogue dialogue = Dialogue(description: 'Le grand depart.', lines: [
      Line(
        speaker: aissa,
        text:
            "Je suis prête à entreprendre ce voyage pour en apprendre plus sur notre pays.",
      ),
      Line(
          speaker: teacher,
          text:
              "Tu verras les réalités auxquelles sont confrontés de nombreux enfants. Certaines filles n'ont pas la chance d'aller à l'école."),
    ]);
    return /* Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: Get.height / 1,
                  width: Get.width / 4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppMedia.aissa,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            /* Container(
              // Your background image or map image goes here
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    AppMedia.mapImage,
                  ),
                ),
              ),
            ), */
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 35),
                child: CustomGameButton(
                  text: 'Suivant',
                  color: AppColors.secondaryColor,
                  width: Get.width / 4,
                  onPressed: () {
                    setState(() {
                      _currentLineIndex++;
                    });
                  },
                ),
              ),
            ),
            //const SizedBox(height: 30),
            Positioned(
              top: Get.height * 0.1,
              left: Get.width / 3.18,
              child: CustomCard(
                /* width: Get.width,
                height: Get.height, */
                padding: const EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        _currentLineIndex % 2 == 0 ? 'Aïssa' : nonPlayer1.name!,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 10,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        dialogue1.lines[_currentLineIndex%dialogue1.lines.length],
                        style: AppTextStyles.body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: Get.height / 1,
                  width: Get.width / 4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: AppColors.secondaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppMedia.teacher,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ); */

        DialogScene(dialogue: dialogue);
  }
}
