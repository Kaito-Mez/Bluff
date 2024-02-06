import "package:frontend/game/models/bet.dart";

/// Generate bet from playerID 0, betting 4 on 2's.
Bet getBet() {
  return Bet(playerId: 0, targetNumber: 2, betQuantity: 4);
}

/// Generate bet with custom playerID, betting 4 on 2's.
Bet getCustomIdBet(int playerId) {
  return Bet(playerId: playerId, targetNumber: 2, betQuantity: 4);
}
