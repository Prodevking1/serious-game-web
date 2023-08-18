import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/region.dart';
import '../routes/router.dart';

class RegionPreviewWidget extends StatelessWidget {
  final Region? region;
  final String destinationPage;
  const RegionPreviewWidget(
      {Key? key, this.region, this.destinationPage = AppRouter.level1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(destinationPage);
      },
      child: Column(
        children: [
          CustomCard(
            height: 35,
            width: 35,
            borderRadius: 100,
            backgroundColor: AppColors.tertiaryColor,
            child: region?.party.status != Status.notStarted
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
