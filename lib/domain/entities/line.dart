import 'package:flame_game/domain/entities/person.dart';

class Line {
  Person speaker;
  String text;
  String audioPath;

  Line({required this.speaker, required this.text, this.audioPath = ''});
}
