import 'dart:math';

import 'package:flame_game/presentation/controllers/region_controller.dart';
import 'package:flame_game/presentation/routes/app_routes.dart';
import 'package:flame_game/presentation/screens/leader_board_page.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/presentation/widgets/region_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/region.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../controllers/evolution_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final EvolutionController evolutionController = Get.find();
  final RegionController regionController = Get.find();
  final Set<Offset> usedOffsets = {};
  final GameAudioPlayer gameAudioPlayer = Get.find();

  @override
  Widget build(BuildContext context) {
    // gameAudioPlayer.playBackgroundMusic();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<void>(
          future: regionController.fetchAllRegions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return _buildContent(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                AppMedia.mapImage,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Obx(() {
              // regionController.fetchAllRegions();
              return CustomCard(
                backgroundColor: Colors.yellow,
                padding: const EdgeInsets.only(left: 20, right: 20),
                width: Get.width * 0.35,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Score: ',
                          style: AppTextStyles.body,
                        ),
                        Text(EvolutionController.totalScore.toString(),
                            style: AppTextStyles.subtitle),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Level: ',
                          style: AppTextStyles.body,
                        ),
                        Text(EvolutionController.level.toString(),
                            style: AppTextStyles.subtitle),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        GestureDetector(
          onTap: () => _showLeaderboardHover(context),
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.group_outlined,
                      color: Colors.yellow,
                      size: 45,
                    ),
                    Text('Voir le classement',
                        style: AppTextStyles.body
                            .copyWith(color: Colors.yellow, fontSize: 13)),
                  ],
                )),
          ),
        ),
        Obx(
          () => Stack(
            children: [
              ...regionController.regions.map(
                (region) {
                  return Positioned(
                    top: region.offset!.dy,
                    left: region.offset!.dx,
                    child: RegionPreviewWidget(
                      region: region,
                      onTap: () {
                        gameAudioPlayer.stopAudio();
                        Get.toNamed(region.route!, arguments: region);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLeaderboardHover(BuildContext context) {
    final overlay = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
        builder: (context) => Stack(
              children: [
                Positioned(
                  top: 20.0,
                  // left: Get.width / 2,
                  right: 125,
                  bottom: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 500,
                    height: 250,
                    child: LeaderboardPage(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                      onTap: () => overlayEntry?.remove(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 42,
                        ),
                      )),
                ),
              ],
            ));

    overlay.insert(overlayEntry);
  }
}
