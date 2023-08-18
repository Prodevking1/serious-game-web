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
