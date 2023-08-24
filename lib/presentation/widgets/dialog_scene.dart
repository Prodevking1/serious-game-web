import 'package:flame_game/presentation/widgets/button_widget.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/line.dart';
import '../../utils/constants.dart';

class DialogScene extends StatefulWidget {
  final List<Dialogue> dialogue;
  final Function onDialogueEnd;

  const DialogScene(
      {super.key, required this.dialogue, required this.onDialogueEnd});

  @override
  _DialogSceneState createState() => _DialogSceneState();
}

class _DialogSceneState extends State<DialogScene> {
  int _currentLineIndex = 0;
  int _currentDialogueIndex = 0;

  @override
  Widget build(BuildContext context) {
    Dialogue currentDialogue =
        widget.dialogue[_currentDialogueIndex % widget.dialogue.length];
    List<Line> lines = currentDialogue.lines;
    Line currentLine = lines[_currentLineIndex];

    String currentSpeaker =
        lines[_currentLineIndex % lines.length].speaker.name;

    nextLine() async {
      if (_currentDialogueIndex == widget.dialogue.length - 1 &&
          _currentLineIndex == lines.length - 1) {
        await widget.onDialogueEnd.call();
      }
      if (_currentLineIndex == lines.length - 1) {
        setState(() {
          _currentLineIndex = 0;
          _currentDialogueIndex++;
        });
      } else {
        setState(() {
          _currentLineIndex++;
        });
      }
    }

    void _previousLine() {
      setState(() {
        _currentLineIndex--;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Opacity(
                opacity: currentSpeaker == 'Mounira' ? 1 : 0.3,
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
                      image: AssetImage(currentDialogue.lines
                          .where((element) => element.speaker.name == 'Mounira')
                          .first
                          .speaker
                          .imagePath),
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
                    nextLine();
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
                      child: Text(
                        currentLine.speaker.name,
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
                        currentLine.text,
                        style: AppTextStyles.body,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Opacity(
                opacity: currentSpeaker != 'Mounira' ? 1 : 0.3,
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
                      image: AssetImage(currentDialogue.lines
                          .where((element) => element.speaker.name != 'Mounira')
                          .first
                          .speaker
                          .imagePath),
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
