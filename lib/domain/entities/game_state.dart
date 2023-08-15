enum Status {
  notStarted,
  inProgress,
  won,
  lost,
  paused,
}

class GameState {
  int miniGameId;
  GameState({required this.miniGameId});
}
