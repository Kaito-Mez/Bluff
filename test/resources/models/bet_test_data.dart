import "package:frontend/game/models/bet.dart";

/// Generate a bet, defaults to playerID 0, betting 4 on 2's.
Bet getTestBet({int playerId = 0, int targetNumber = 2, int betQuantity = 4}) {
  return Bet(playerId: 0, targetNumber: 2, betQuantity: 4);
}
