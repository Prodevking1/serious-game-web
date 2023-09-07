import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flame_game/presentation/controllers/party_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/line.dart';
import '../../domain/entities/person.dart';
import '../../utils/constants.dart';
import '../controllers/evolution_controller.dart';
import '../widgets/button_widget.dart';
import '../widgets/card_widget.dart';

class Level2Screen extends StatefulWidget {
  const Level2Screen({Key? key}) : super(key: key);

  @override
  _Part2State createState() => _Part2State();
}

class _Part2State extends State<Level2Screen> with TickerProviderStateMixin {
  static PartyController partyController = Get.find();
  EvolutionController evolutionController = Get.find();

  int _currentLineIndex = 0;
  int _currentDialogueIndex = 0;

  final int answerDuration = 30;
  bool isCorrectAnswer = false;
  int? correctAnswerIndex;
  int currentPossibleAnswersIndex = 0;

  final allQuestions = partyController.questionsWithAnswers.values;
  final allQuestionsTitle = partyController.questionsWithAnswers.keys;

  List possiblesAnswers = [];
  String? currentQuestionTitle;

  int? currentIndex;
  bool isAnimating = false;

  final CountDownController _countDownController = CountDownController();

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showPartyObjectivesWidget();
    });
    getCorrectAnswerIndex();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Person mounira = Person(name: 'Mounira', imagePath: AppMedia.mounira);
    final Person teacher =
        Person(name: 'Enseignante', imagePath: AppMedia.teacher);

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

    final dialogue = [dialogueWithTeacher];

    Dialogue currentDialogue =
        dialogue[_currentDialogueIndex % dialogue.length];
    List<Line> lines = currentDialogue.lines;
    Line currentLine = lines[_currentLineIndex];
    String currentSpeaker =
        lines[_currentLineIndex % lines.length].speaker.name;

    nextLine() async {
      if (_currentDialogueIndex == dialogue.length - 1 &&
          _currentLineIndex == lines.length - 1) {}
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
      // backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Lottie.asset(
              AppMedia.animtedBackground,
              options: LottieOptions(enableMergePaths: true),
              height: Get.height,
              width: Get.width,
              fit: BoxFit.fill,
            ),
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

            Positioned(
                top: Get.height * 0.07,
                left: Get.width * 0.3,
                child: Obx(() => Text(
                      '${EvolutionController.totalScore} 🏆',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ))),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: CircularCountDownTimer(
                  duration: answerDuration,
                  initialDuration: 0,
                  controller: _countDownController,
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 5,
                  ringColor: Colors.grey[300]!,
                  fillColor: Colors.red,
                  fillGradient: null,
                  backgroundColor: Colors.white,
                  strokeWidth: 2.0,
                  strokeCap: StrokeCap.round,
                  /* textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold), */
                  textFormat: CountdownTextFormat.SS,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {},
                  onComplete: () {
                    partyController
                        .answerToQuestion(
                            possiblesAnswers[currentPossibleAnswersIndex])
                        .then((value) {
                      if (value) {
                        rewardCorrectAnswer();
                        setState(() {
                          isAnimating = true;
                        });

                        Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            isAnimating = false;
                            isCorrectAnswer = false;
                          });
                        });
                      } else {
                        setState(() {
                          isAnimating = true;
                        });

                        Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            isAnimating = false;
                          });
                          nextQuestions();
                        });
                      }
                    });
                  },
                  onChange: (String timeStamp) {
                    debugPrint('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    return Function.apply(defaultFormatterFunction, [duration]);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.height / 1.85,
                  right: Get.height / 1.85,
                  top: Get.height / 3),
              child: CustomCard(
                backgroundColor: Colors.white,
                height: 45,
                borderRadius: 15,
                child: Center(
                  child: Text(
                    currentQuestionTitle!,
                    style: AppTextStyles.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Get.height / 1.85,
                  right: Get.height / 1.85,
                  top: Get.height / 1.8),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 24 / 6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      partyController
                          .answerToQuestion(possiblesAnswers[index])
                          .then((value) {
                        if (value) {
                          rewardCorrectAnswer();
                          setState(() {
                            currentIndex = index;
                            isAnimating = true;
                          });

                          Timer(const Duration(milliseconds: 500), () {
                            setState(() {
                              isAnimating = false;
                              isCorrectAnswer = false;
                            });
                          });
                        } else {
                          punishWrongAnswer();
                          currentIndex = index;
                          setState(() {
                            isAnimating = true;
                          });

                          Timer(const Duration(milliseconds: 500), () {
                            setState(() {
                              isAnimating = false;
                            });
                            nextQuestions();
                          });
                        }
                      });
                    },
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        Color? succesBgColor = Colors.green;
                        Color? wrongBgColor = Colors.red[500];
                        Color? bgColor;

                        if (isAnimating) {
                          bgColor = (correctAnswerIndex == index)
                              ? succesBgColor
                              : currentIndex == index
                                  ? wrongBgColor
                                  : Colors.grey[200];
                        }
                        return AnimatedContainer(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: bgColor ?? Colors.grey[200],
                          ),
                          duration: const Duration(milliseconds: 500),
                          child: Center(
                            child: Text(
                              possiblesAnswers[index],
                              style: AppTextStyles.body.copyWith(fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
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

  startCountDown() {
    _countDownController.start();
  }

  pauseCountDown() {
    _countDownController.pause();
  }

  resumeCountDown() {
    _countDownController.resume();
  }

  restartCountDown() {
    _countDownController.restart();
  }

  rewardCorrectAnswer() {
    evolutionController.rewardPlayer();
    setState(() {
      isCorrectAnswer = !isCorrectAnswer;
    });
  }

  punishWrongAnswer() {
    evolutionController.punishPlayer();
  }

  getCorrectAnswerIndex() {
    setState(() {
      possiblesAnswers = allQuestions.elementAt(currentPossibleAnswersIndex);
      currentQuestionTitle =
          allQuestionsTitle.elementAt(currentPossibleAnswersIndex);
    });
    final list = allQuestions.elementAt(currentPossibleAnswersIndex);
    final elementCount = [];
    for (int i = 0; i < list.length; i++) {
      final answer = list[i];
      if (elementCount.contains(answer)) {
        setState(() {
          correctAnswerIndex = elementCount.indexOf(answer);
        });
      } else {
        elementCount.add(answer);
      }
    }
  }

  void nextQuestions() {
    setState(() {
      currentPossibleAnswersIndex++;
      getCorrectAnswerIndex();
    });
  }

  showPartyObjectivesWidget() {
    Get.dialog(
      barrierDismissible: true,
      AlertDialog(
        title: const Center(
          child: Text(
            '🎯 Objectifs de la mission',
            style: AppTextStyles.title,
          ),
        ),
        content: const SizedBox(
          width: 300,
          child: Text(
            "Tu dois réussir à convaincre la mère de Djamila de la laisser aller à l'école en repondant correctement aux questions.",
            style: AppTextStyles.body,
          ),
        ),
        actions: [
          CustomGameButton(
            text: 'Je commence',
            onPressed: () {
              Get.back();
            },
          )
        ],
      ),
    );
  }
}
