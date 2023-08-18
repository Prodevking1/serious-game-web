import 'dart:math';

import 'package:flame_game/presentation/controllers/region_controller.dart';
import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/presentation/widgets/region_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/region.dart';
import '../../utils/constants.dart';
import '../controllers/evolution_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final EvolutionController evolutionController = Get.find();
  final RegionController regionController = Get.find();

  @override
  Widget build(BuildContext context) {
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
              return _buildContent();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
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
            child: Obx(() => CustomCard(
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
                )),
          ),
        ),
        for (Region region in regionController.regions)
          Positioned(
            left: Get.width * (Random().nextInt(100) * 0.01),
            bottom: Get.height * (Random().nextInt(50) * 0.01),
            child: RegionPreviewWidget(
              region: region,
            ),
          ),
      ],
    );
  }
}
