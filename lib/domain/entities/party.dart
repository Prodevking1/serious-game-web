import 'game_state.dart';

class Party {
  int? id;
  String? name;
  String? description;
  DateTime? startTime;
  DateTime? endTime;
  int? totalScore;
  Duration? duration;
  int? finalScore;
  Status? status;

  Party({
    this.id,
    this.name,
    this.description,
    this.startTime,
    this.endTime,
    this.totalScore,
    this.duration,
    this.finalScore,
    this.status = Status.notStarted,
  });

  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      totalScore: json['totalScore'],
      duration: json['duration'],
      finalScore: json['finalScore'],
      status: Status.values[json['status']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'totalScore': totalScore,
      'duration': duration,
      'finalScore': finalScore,
      'status': status?.index,
    };
  }
}
