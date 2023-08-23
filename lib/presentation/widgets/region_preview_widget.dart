import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/region.dart';
import '../routes/router.dart';

class RegionPreviewWidget extends StatelessWidget {
  final Region? region;
  final Function? onTap;
  const RegionPreviewWidget({Key? key, this.region, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (region?.party!.status == Status.notStarted) {
          onTap!();
        } else {
          Get.dialog(
            Dialog(
              child: CustomCard(
                width: Get.width * 0.8,
                height: Get.height * 0.8,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Tu as déjà commencé cette partie',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Veux-tu continuer cette partie ?',
                      style: AppTextStyles.body.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
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
                        ),
                      ],
                    )
                  ],
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
