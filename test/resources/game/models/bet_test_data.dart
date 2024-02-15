import "package:frontend/game/models/bet.dart";

/// Generate a bet, defaults to playerID 0, betting 4 on 2's.
Bet getTestBet({int playerId = 0, int betQuantity = 4, int targetNumber = 2}) {
  return Bet(playerId, betQuantity, targetNumber);
}
