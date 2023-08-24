class Player {
  int id;
  String userName;

  Player({
    required this.id,
    required this.userName,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      userName: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': userName,
      };
}
