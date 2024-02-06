class Bet {
  int targetNumber;
  int betQuantity;

  int playerId;

  /// Object representing the current bet.
  Bet({this.playerId = -1, this.targetNumber = -1, this.betQuantity = -1});

  /// Set the current bet
  void placeBet(int playerId, int targetNumber, int betQuantity) {
    this.playerId = playerId;
    this.targetNumber = targetNumber;
    this.betQuantity = betQuantity;
  }

  /// Provided the roll of all dice, checks the result of the bet.
  /// Return 0 means perfect bet (all non betters lose),
  ///
  /// Positive number challenger loses dice (caller loses),
  ///
  /// Negative number better loses dice (better loses)
  int verifyBet(List<int> wildcards, List<int> rolls) {
    int count = 0;

    for (int roll in rolls) {
      if (roll == targetNumber || wildcards.contains(roll)) {
        count++;
      }
    }

    return count - betQuantity;
  }
}
