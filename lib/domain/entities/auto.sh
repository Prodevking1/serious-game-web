# Créer le fichier country.dart
echo '''
class Country {
  int id;
  String name;
  int totalRegions;

  Country({required this.id, required this.name, required this.totalRegions});
}
''' > country.dart

# Créer le fichier game_state.dart
echo '''
enum Status {
  notStarted,
  inProgress,
  won,
  lost,
  paused,
}

class GameState {
  int PartyId;

  GameState({required this.PartyId});
}
''' > game_state.dart

# Créer le fichier mini_game.dart
echo '''
class Party {
  int id;
  String name;
  String description;
  DateTime startTime;
  DateTime endTime;
  int totalScore;
  Duration duration;
  int finalScore;

  Party({
    required this.id,
    required this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.totalScore,
    required this.duration,
    required this.finalScore,
  });
}
''' > mini_game.dart

# Créer le fichier region.dart
echo '''
class Region {
  int id;
  String name;
  String description;
  Status status;

  Region({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });
}
''' > region.dart

# Créer le fichier non_player.dart
echo '''
class NonPlayer {
  int id;
  String name;
  String role;
  int age;

  NonPlayer({
    required this.id,
    required this.name,
    required this.role,
    required this.age,
  });
}
''' > non_player.dart

# Créer le fichier player.dart
echo '''
class Player {
  int id;
  String userName;

  Player({
    required this.id,
    required this.userName,
  });
}
''' > player.dart

# Créer le fichier line.dart
echo '''
class Line {
  String speaker;
  String text;

  Line({required this.speaker, required this.text});
}
''' > line.dart
