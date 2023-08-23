class Stats {
  final int player_id;
  final int total_score;
  final int rank;

  Stats(
      {required this.player_id, required this.total_score, required this.rank});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
        player_id: json['player_id'],
        total_score: json['total_score'],
        rank: json['rank']);
  }

  Map<String, dynamic> toJson() {
    return {
      'player_id': player_id,
      'total_score': total_score,
      'rank': rank,
    };
  }
}
