import 'game_state.dart';

class Region {
  int? id;
  String name;
  String? description;
  Status status;

  Region({
    this.id,
    required this.name,
    this.description,
    required this.status,
  });
}
