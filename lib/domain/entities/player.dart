class Player {
  String id;
  String userName;
  int totalScore;
  int rank = 0;
  String? gender;

  Player({
    required this.id,
    required this.userName,
    this.totalScore = 0,
    this.gender,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      userName: json['name'],
      totalScore: json['player_stats']['total_score'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': userName,
      };
}
