class Bet {
  late int number;
  late int quantity;

  late int playerId;

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
  int verifyBet(int wildcard, List<int> dice) {
    int count = 0;
    for (int roll in dice) {
      if (roll == number || roll == wildcard) {
        count++;
      }
    }

    return count - quantity;
  }
}
