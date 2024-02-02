class Bet {
  int number;
  int quantity;

  int playerId;

  Bet({this.playerId = -1, this.number = -1, this.quantity = -1});

  void placeBet(int playerId, int number, int quantity) {
    this.playerId = playerId;
    this.number = number;
    this.quantity = quantity;
  }

  /// Return 0 means perfect bet,
  ///
  /// Positive number challenger loses dice,
  ///
  /// Negative number better loses dice
  int verifyBet(List<int> wildcards, List<int> dice) {
    int count = 0;

    for (int roll in dice) {
      if (roll == number || wildcards.contains(roll)) {
        count++;
      }
    }

    return count - quantity;
  }
}
