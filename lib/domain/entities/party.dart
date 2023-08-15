
class MiniGame {
  int id;
  String name;
  String description;
  DateTime startTime;
  DateTime endTime;
  int totalScore;
  Duration duration;
  int finalScore;

  MiniGame({
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

