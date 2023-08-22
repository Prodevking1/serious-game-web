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
    await fetchAllRegions();
    // await generateRegions();
    // await localStorage.deleteAllData();
  }

  fetchAllRegions() async {
    regions.value = await localStorage.getRegions();
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
        party: Party(
          name: 'Parti de l\'Ouest',
        ),
      ),
      Region(
        offset: Offset(
          Get.height * 0.8,
          Get.width * 0.15,
        ),
        id: 2,
        name: 'Centre',
        party: Party(
          name: 'Parti du Centre',
        ),
      ),
      Region(
        offset: Offset(
          Get.height * 0.35,
          Get.width * 0.25,
        ),
        id: 3,
        name: 'Est',
        party: Party(
          name: 'Parti de l\'Est',
        ),
      ),
      Region(
        offset: Offset(
          Get.height * 0.5,
          Get.width * 0.4,
        ),
        id: 4,
        name: 'Sud',
        party: Party(
          name: 'Parti du Sud',
        ),
      ),
      Region(
        offset: Offset(
          Get.height * 0.32,
          Get.width * 0.6,
        ),
        id: 5,
        name: 'Nord',
        party: Party(
          name: 'Parti du Nord',
        ),
      ),
    ];
    for (var region in regions) {
      localStorage.addNewRegion(region);
    }
  }
}
