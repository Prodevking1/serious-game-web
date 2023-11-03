/* import 'package:flame_game/presentation/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/party.dart';
import '../../domain/entities/region.dart';

class RegionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  RxList<Region> regions = <Region>[].obs;

  @override
  void onInit() async {
    super.onInit();

    await generateRegions();
    await fetchAllRegions();
    await addParties();

    // await localStorage.deleteAllData('regions');
    // await localStorage.deleteAllData('parties');
  }

  fetchAllRegions() async {
    regions.clear();
    final res = await localStorage.rawQuery(
      '''
      SELECT  * FROM regions join parties on regions.party_id = parties.id
      ''',
    );
    final regionsList = res.map((e) => Region.fromJson(e)).toList();
    for (var element in regionsList) {
      regions.add(element);
    }
  }

  generateRegions() {
    List<Region> regions = [
      Region(
        offset: const Offset(
          130,
          20,
        ),
        id: 1,
        name: 'Ouest',
        partyId: 1,
        route: AppRoutes.level1,
      ),
      Region(
        offset: const Offset(
          130,
          200,
        ),
        id: 2,
        name: 'Centre',
        partyId: 2,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          155,
          526,
        ),
        id: 3,
        name: 'Est',
        partyId: 3,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          250.8,
          414.0,
        ),
        id: 4,
        name: 'Sud',
        partyId: 4,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          238.0,
          152.0,
        ),
        id: 5,
        name: 'Nord',
        partyId: 5,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          180.8,
          385.0,
        ),
        id: 6,
        name: 'Sud-Est',
        partyId: 6,
        route: AppRoutes.level2,
      ),
    ];

    try {
      for (var region in regions) {
        localStorage.insertData(
          "regions",
          region.toJson(),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  addParties() {
    List<Party> parties = [
      Party(
        id: 1,
        name: 'Ouest',
        description: 'Le grand depart de Mounira pour l\'aventure',
      ),
      Party(
        id: 2,
        name: 'Centre',
        description: 'Premiere mission de Mounira',
      ),
      Party(
        id: 3,
        name: 'Est',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 4,
        name: 'Sud',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 5,
        name: 'Nord',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 6,
        name: 'Sud-Est',
        description: 'Mounira a la recherche de...',
      ),
    ];
    try {
      for (var party in parties) {
        localStorage.insertData(
          "parties",
          party.toJson(),
        );
      }
    } catch (e) {
      throw Exception('Error adding parties: $e');
    }
  }
}
 */
import 'package:flame_game/presentation/routes/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/party.dart';
import '../../domain/entities/region.dart';

class RegionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  RxList<Region> regions = <Region>[].obs;

  @override
  void onInit() async {
    super.onInit();
    // await generateRegions();
    // await addParties();
    await fetchAllRegions();
    // await localStorage.deleteAllData('regions');
    // await localStorage.deleteAllData('parties');

    if (regions.isEmpty) {
      await generateRegions();
      await fetchAllRegions();
    }

    // If no parties are fetched, generate and fetch
    if (regions.isEmpty) {
      await addParties();
      await fetchAllRegions();
    }
  }

  fetchAllRegions() async {
    regions.clear();
    final res = await localStorage.rawQuery(
      '''
      SELECT  * FROM regions join parties on regions.party_id = parties.id
      ''',
    );
    final regionsList = res.map((e) => Region.fromJson(e)).toList();
    for (var element in regionsList) {
      regions.add(element);
    }
  }

  generateRegions() {
    List<Region> regions = [
      Region(
        offset: const Offset(
          130,
          20,
        ),
        id: 1,
        name: 'Banfora',
        partyId: 1,
        route: AppRoutes.level1,
      ),
      Region(
        offset: const Offset(
          130,
          200,
        ),
        id: 2,
        name: 'Ouagadougou',
        partyId: 2,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          155,
          526,
        ),
        id: 3,
        name: 'Fada N\'Gourma',
        partyId: 3,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          250.8,
          414.0,
        ),
        id: 4,
        name: 'Bobo-Dioulasso',
        partyId: 4,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          238.0,
          152.0,
        ),
        id: 5,
        name: 'Ouahigouya',
        partyId: 5,
        route: AppRoutes.level2,
      ),
      Region(
        offset: const Offset(
          180.8,
          385.0,
        ),
        id: 6,
        name: 'Gaoua',
        partyId: 6,
        route: AppRoutes.level2,
      ),
    ];

    try {
      for (var region in regions) {
        localStorage.insertData(
          "regions",
          region.toJson(),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  addParties() {
    List<Party> parties = [
      Party(
        id: 1,
        name: 'Banfora',
        description: 'Le grand depart de Mounira pour l\'aventure',
      ),
      Party(
        id: 2,
        name: 'Ouagadougou',
        description: 'Premiere mission de Mounira',
      ),
      Party(
        id: 3,
        name: 'Fada N\'Gourma',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 4,
        name: 'Bobo-Dioulasso',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 5,
        name: 'Ouahigouya',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 6,
        name: 'Gaoua',
        description: 'Mounira a la recherche de...',
      ),
    ];
    try {
      for (var party in parties) {
        localStorage.insertData(
          "parties",
          party.toJson(),
        );
      }
    } catch (e) {
      throw Exception('Error adding parties: $e');
    }
  }
}
