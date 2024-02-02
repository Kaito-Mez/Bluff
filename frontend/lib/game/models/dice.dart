import 'dart:math';

class Dice {
  int numSides;

  int currentRoll;

  Dice(this.numSides, {this.currentRoll = -1});

  int roll() {
    final random = Random();

    currentRoll = random.nextInt(numSides) + 1;
    return currentRoll;
  }
}
