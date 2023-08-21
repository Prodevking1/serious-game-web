import 'package:get_storage/get_storage.dart';

import '../../domain/entities/region.dart';

class LocalStorage {
  final box = GetStorage();

  addNewRegion(Region region) {
    if (box.read('regions') == null) {
      box.write('regions', [region.toJson()]);
    } else {
      box.read('regions').add(region.toJson());
    }
  }

  Future<List<Region>> getRegions() async {
    final regions = await box.read('regions');
    if (regions == null) {
      return [];
    } else {
      return regions.map<Region>((e) => Region.fromJson(e)).toList();
    }
  }

  saveData(String key, dynamic value) {
    print('save data');
    box.write(key, value);
  }

  dynamic getData(String key) {
    return box.read(key);
  }
}
