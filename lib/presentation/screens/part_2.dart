import 'dart:async';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flame_game/presentation/controllers/party_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/dialog.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/line.dart';
import '../../domain/entities/person.dart';
import '../../domain/entities/region.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../controllers/evolution_controller.dart';
import '../routes/app_routes.dart';
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
  final Region region = Get.arguments;

  int _currentLineIndex = 0;
  int _currentDialogueIndex = 0;
  int _correctsAnswersNumber = 0;

  final int answerDuration = 25;
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

  final GameAudioPlayer gameAudioPlayer = Get.find();

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
                opacity: 0.8,
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
            Positioned(
              top: Get.height * 0.07,
              left: Get.width * 0.3,
              child: Obx(
                () => AnimatedFlipCounter(
                  suffix: " 🏆",
                  duration: const Duration(milliseconds: 500),
                  value: EvolutionController.totalScore.toDouble(),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
                  textFormat: CountdownTextFormat.SS,
                  isReverse: true,
                  isReverseAnimation: true,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {},
                  onComplete: () async {
                    gameAudioPlayer.playClickSound();

                    partyController
                        .answerToQuestion(
                      possiblesAnswers[currentPossibleAnswersIndex],
                    )
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
                        punishWrongAnswer();

                        setState(() {
                          isAnimating = true;
                        });

                        Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            isAnimating = false;
                          });
                          nextQuestions();
                          _countDownController.restart();
                        });
                      }
                    });
                  },
                  onChange: (String timeStamp) {},
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
                      if (currentPossibleAnswersIndex ==
                          allQuestions.length - 1) {
                        _buildFinishPartyWidget();
                      }
                      _countDownController.restart();
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
                            nextQuestions();
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
                            if (currentPossibleAnswersIndex ==
                                allQuestions.length - 1) {
                              _buildFinishPartyWidget();
                            } else {
                              nextQuestions();
                            }
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
                opacity: 0.8,
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
    _correctsAnswersNumber++;
    evolutionController.rewardPlayer();
    setState(() {
      isCorrectAnswer = !isCorrectAnswer;
    });
  }

  punishWrongAnswer() {
    evolutionController.punishPlayer();
  }

  getCorrectAnswerIndex() {
    print(possiblesAnswers.length);

    setState(
      () {
        /* possiblesAnswers = allQuestions.elementAt(currentPossibleAnswersIndex);
      currentQuestionTitle =
          allQuestionsTitle.elementAt(currentPossibleAnswersIndex); */
        if (currentPossibleAnswersIndex < allQuestions.length) {
          possiblesAnswers =
              allQuestions.elementAt(currentPossibleAnswersIndex);
          if (currentPossibleAnswersIndex < allQuestionsTitle.length) {
            currentQuestionTitle =
                allQuestionsTitle.elementAt(currentPossibleAnswersIndex);
          }
        }
      },
    );
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

  /* void nextQuestions() {
    setState(() {
      currentPossibleAnswersIndex++;
      getCorrectAnswerIndex();
    });
  } */
  void nextQuestions() {
    if (currentPossibleAnswersIndex < allQuestions.length - 1) {
      setState(() {
        currentPossibleAnswersIndex++;
        getCorrectAnswerIndex();
      });
    }
  }

  showPartyObjectivesWidget() {
    Get.dialog(
      barrierDismissible: false,
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
              startCountDown();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  _buildFinishPartyWidget() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                _correctsAnswersNumber >= allQuestions.length / 2.5
                    ? '🎉 Bravo !'
                    : '😢 Dommage !',
                style: AppTextStyles.title,
              ),
            ),
            content: SizedBox(
              width: 300,
              child: Text(
                _correctsAnswersNumber >= allQuestions.length
                    ? "Tu as réussi à convaincre la mère de Djamila de la laisser aller à l'école."
                    : "Tu n'as pas réussi à convaincre la mère de Djamila de la laisser aller à l'école.",
                style: AppTextStyles.body,
              ),
            ),
            actions: [
              CustomGameButton(
                text: 'Revenir à l\'accueil',
                onPressed: () async {
                  await evolutionController.updateStats();
                  await partyController.updatePartyStatus(
                      region.party!,
                      _correctsAnswersNumber >= allQuestions.length
                          ? Status.won
                          : Status.lost);
                  Get.offAllNamed(AppRoutes.homePage);
                },
              )
            ],
          );
        });
  }
}
