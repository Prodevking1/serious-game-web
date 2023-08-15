import 'package:flame_game/presentation/widgets/button_widget.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/line.dart';
import '../../utils/constants.dart';

class DialogScene extends StatefulWidget {
  final Dialogue dialogue;
  const DialogScene({super.key, required this.dialogue});

  @override
  _DialogSceneState createState() => _DialogSceneState();
}

class _DialogSceneState extends State<DialogScene> {
  int _currentLineIndex = 0;

  @override
  Widget build(BuildContext context) {
    Dialogue dialogue = widget.dialogue;
    List<Line> lines = dialogue.lines;
    List<String> dialoglines = lines.map((e) => e.text).toList();

    String currentSpeaker =
        lines[_currentLineIndex % lines.length].speaker.name;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: currentSpeaker == 'Aissa' ? 1 : 0.3,
                  child: Container(
                    height: Get.height / 1,
                    width: Get.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          dialogue.lines[0].speaker.imagePath,
                        ),
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
                padding: const EdgeInsets.only(bottom: 20, right: 15),
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
              left: Get.width * 0.317,
              child: CustomCard(
                borderRadius: 15,
                width: Get.width * 0.36,
                padding: const EdgeInsets.all(20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Expanded(
                        flex: 5,
                        child: Text(
                          widget
                              .dialogue
                              .lines[_currentLineIndex %
                                  widget.dialogue.lines.length]
                              .speaker
                              .name,
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 10,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        lines[_currentLineIndex % widget.dialogue.lines.length]
                            .text,
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
                child: Opacity(
                  opacity: currentSpeaker != 'Aissa' ? 1 : 0.3,
                  child: Container(
                    height: Get.height / 1,
                    width: Get.width / 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          dialogue.lines[1].speaker.imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
