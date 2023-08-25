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
    await addParties();
    await fetchAllRegions();
    // await localStorage.deleteAllData('parties');
  }

  fetchAllRegions() async {
    regions.clear();
    final res = await localStorage.rawQuery(
      '''
      SELECT * FROM regions join parties on regions.party_id = parties.id
      ''',
    );
    final regionsList = res.map((e) => Region.fromJson(e)).toList();
    regionsList.forEach((element) {
      regions.add(element);
    });
  }

  generateRegions() {
    List<Region> regions = [
      Region(
        offset: Offset(
          Get.height * 0.5,
          Get.width * 0.08,
        ),
        id: 1,
        name: 'Ouest',
        partyId: 1,
      ),
      Region(
        offset: Offset(
          Get.height * 0.8,
          Get.width * 0.15,
        ),
        id: 2,
        name: 'Centre',
        partyId: 2,
      ),
      Region(
        offset: Offset(
          Get.height * 0.35,
          Get.width * 0.25,
        ),
        id: 3,
        name: 'Est',
        partyId: 3,
      ),
      Region(
        offset: Offset(
          Get.height * 0.5,
          Get.width * 0.4,
        ),
        id: 4,
        name: 'Sud',
        partyId: 4,
      ),
      Region(
        offset: Offset(
          Get.height * 0.32,
          Get.width * 0.6,
        ),
        id: 5,
        name: 'Nord',
        partyId: 5,
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
        name: 'Parti de l\'Ouest',
        description: 'Le grand depart de Mounira pour l\'aventure',
      ),
      Party(
        id: 2,
        name: 'Parti du Centre',
        description: 'Premiere mission de Mounira',
      ),
      Party(
        id: 3,
        name: 'Parti de l\'Est',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 4,
        name: 'Parti du Sud',
        description: 'Mounira a la recherche de...',
      ),
      Party(
        id: 5,
        name: 'Parti du Nord',
        description: 'Mounira a la recherche de...',
      ),
    ];
    for (var party in parties) {
      localStorage.insertData(
        "parties",
        party.toJson(),
      );
    }
  }
}
