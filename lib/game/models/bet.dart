class Bet {
  int number;
  int quantity;

  int playerId;

  /// Object representing the current bet.
  Bet({this.playerId = -1, this.number = -1, this.quantity = -1});

  /// Set the current bet
  void placeBet(int playerId, int number, int quantity) {
    this.playerId = playerId;
    this.number = number;
    this.quantity = quantity;
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
      if (roll == number || wildcards.contains(roll)) {
        count++;
      }
    }

    return count - quantity;
  }
}
