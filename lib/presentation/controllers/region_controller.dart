import 'package:get/get.dart';

import '../../data/source/local_storage.dart';
import '../../domain/entities/party.dart';
import '../../domain/entities/region.dart';

class RegionController extends GetxController {
  LocalStorage localStorage = LocalStorage();

  RxList<Region> regions = <Region>[].obs;

  @override
  void onInit() {
    super.onInit();

    //generateRegions();
    fetchAllRegions();
  }

  fetchAllRegions() {
    regions.value = localStorage.getRegions() ?? [];
  }

  generateRegions() {
    List<Region> regions = [
      Region(
        id: 1,
        name: 'Ouest',
        party: Party(
          name: 'Parti de l\'Ouest',
        ),
      ),
      Region(
        id: 2,
        name: 'Centre',
        party: Party(
          name: 'Parti du Centre',
        ),
      ),
      Region(
        id: 3,
        name: 'Est',
        party: Party(
          name: 'Parti de l\'Est',
        ),
      ),
      Region(
        id: 4,
        name: 'Sud',
        party: Party(
          name: 'Parti du Sud',
        ),
      ),
      Region(
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
