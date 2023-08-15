import 'dart:math';

import 'package:flame_game/presentation/widgets/card_widget.dart';
import 'package:flame_game/presentation/widgets/region_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/region.dart';
import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Region> regions = [
    Region(
      id: 1,
      name: 'Ouest',
      status: Status.won,
    ),
    Region(
      id: 2,
      name: 'Centre',
      status: Status.notStarted,
    ),
    Region(
      id: 3,
      name: 'Est',
      status: Status.won,
    ),
    Region(
      id: 4,
      name: 'Sud',
      status: Status.notStarted,
    ),
    Region(
      id: 5,
      name: 'Nord',
      status: Status.notStarted,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                child: CustomCard(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    width: Get.width * 0.25,
                    height: 40,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Score: ',
                              style: AppTextStyles.body,
                            ),
                            Text('0', style: AppTextStyles.subtitle),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Level: ',
                              style: AppTextStyles.body,
                            ),
                            Text('0', style: AppTextStyles.subtitle),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            for (Region region in regions)
              Positioned(
                  left: Get.width * (Random().nextInt(100) * 0.01),
                  bottom: Get.height * (Random().nextInt(50) * 0.01),
                  child: RegionPreviewWidget(
                    region: region,
                  ))
          ],
        ),
      ),
    );
  }
}
