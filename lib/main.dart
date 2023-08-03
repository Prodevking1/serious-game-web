import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_game/presentation/routes/router.dart';
import 'package:flame_game/presentation/screens/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setOrientation(DeviceOrientation.portraitUp);
  await dotenv.load(fileName: '.env');

  /* GameWidget(
    game: MyGame(),
  ) */
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
  ).then((_) {
    runApp(const EntryApp());
  });
}

class MyGame extends FlameGame with TapDetector {
  @override
  Future<void> onLoad() async {
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawPaint(Paint()..color = Colors.red);
  }

  @override
  void onTapUp(TapUpInfo info) {
    print(
        'onTap location: (${info.eventPosition.game.x}, ${info.eventPosition.game.y})');
  }
}

class EntryApp extends StatelessWidget {
  const EntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
      getPages: AppRouter.getPage(),
      initialBinding: BaseBinding(),
    );
  }
}
