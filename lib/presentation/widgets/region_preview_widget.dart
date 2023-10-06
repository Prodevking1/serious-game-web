import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/region.dart';
import '../../utils/helpers.dart';
import '../routes/app_routes.dart';

class RegionPreviewWidget extends StatelessWidget {
  final Region? region;
  final Function? onTap;
  RegionPreviewWidget({Key? key, this.region, this.onTap}) : super(key: key);
  final GameAudioPlayer gameAudioPlayer = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        gameAudioPlayer.playClickSound();
        if (region?.party!.status == Status.notStarted) {
          onTap!();
        } else {
          Get.dialog(
            transitionCurve: Curves.easeInOut,
            Dialog(
              child: CustomCard(
                width: Get.width * 0.5,
                height: Get.height * 0.5,
                padding: const EdgeInsets.all(20),
                borderRadius: 15,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 30,
                          ),
                          Text(
                            'Tu as déjà terminer cette partie',
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Veux-tu rejouer?',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /* CustomCard(
                            width: Get.width * 0.2,
                            height: Get.height * 0.05,
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Non',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          CustomCard(
                            width: Get.width * 0.2,
                            height: Get.height * 0.05,
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                /* Get.back();
                              Get.toNamed(AppRoutes.gameScreen,
                                  arguments: GameState(
                                      region: region,
                                      party: region?.party,
                                      person: region?.party.person)); */
                              },
                              child: Text(
                                'Oui',
                                style: AppTextStyles.body.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ), */
                          TextButton(
                              onPressed: () {
                                gameAudioPlayer
                                    .playClickSound()
                                    .then((value) => Get.back());
                                // Get.back();
                              },
                              child: Text(
                                'Non',
                                style: AppTextStyles.body
                                    .copyWith(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                gameAudioPlayer.playClickSound();
                                onTap!();
                              },
                              child: Text(
                                'Oui',
                                style: AppTextStyles.body
                                    .copyWith(color: Colors.green),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          CustomCard(
            height: 35,
            width: 35,
            borderRadius: 100,
            backgroundColor: AppColors.tertiaryColor,
            child: region?.party!.status != Status.notStarted
                ? const Center(
                    child: Icon(
                    Icons.check_rounded,
                    color: Colors.black,
                  ))
                : const Center(
                    child: Icon(
                      Icons.lock_outline,
                    ),
                  ),
          ),
          Text(
            region?.name ?? '',
            style: AppTextStyles.body.copyWith(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
