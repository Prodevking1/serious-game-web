class Stats {
  final int player_id;
  final int total_score;
  final int level;

  Stats(
      {required this.player_id,
      required this.total_score,
      required this.level});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      player_id: json['player_id'],
      total_score: json['total_score'],
      level: json['level'],
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_id': player_id,
      'score': total_score,
      'level': level,
      'id': 1,
    };
  }
}
