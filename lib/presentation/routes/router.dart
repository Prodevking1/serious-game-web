import 'package:flame_game/data/source/local_storage.dart';
import 'package:flame_game/presentation/controllers/evolution_controller.dart';
import 'package:flame_game/presentation/controllers/party_controller.dart';
import 'package:flame_game/presentation/controllers/region_controller.dart';
import 'package:flame_game/presentation/screens/intro_screen.dart';
import 'package:flame_game/presentation/screens/register_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../../domain/entities/player.dart';
import '../controllers/auth_controller.dart';
import '../screens/home_screen.dart';
import '../screens/part_1.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut(
      () => AuthController(),
    );
    Get.lazyPut(() => SupabaseClient(
        dotenv.env['SUPABASE_URL']!, dotenv.env['SUPABASE_KEY']!));
    Get.lazyPut(() => AuthController());
    Get.lazyPut(
      () => EvolutionController(),
    );
    Get.lazyPut(
      () => RegionController(),
    );
    Get.lazyPut(
      () => PartyController(),
    );
  }
}

class AppRoutes {
  static const initialPage = '/';
  static const introPage = '/intro';
  static const registerPage = '/register';
  static const homePage = '/home';
  static const profilePage = '/profile';
  static const level1 = '/level1';

  static List<GetPage<dynamic>> getPage() {
    return [
      GetPage(
        name: introPage,
        page: () => const IntroScreen(),
        binding: BaseBinding(),
      ),
      GetPage(
        name: registerPage,
        page: () => RegisterScreen(),
        binding: BaseBinding(),
      ),
      GetPage(
        name: homePage,
        page: () => HomeScreen(),
        binding: BaseBinding(),
      ),
      GetPage(
        name: level1,
        page: () => Level1Screen(),
        binding: BaseBinding(),
      ),
    ];
  }

  String initialRoute()  {
    LocalStorage localStorage = LocalStorage();


    var player;
    player = ( localStorage.getData('players'));
    return player!=null ? homePage : introPage;
  }
}
