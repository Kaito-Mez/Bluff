import 'dart:math';

class Dice {
  late int numSides;

  late int currentRoll;

  Dice(this.numSides);

  int roll() {
    final random = Random();

    currentRoll = random.nextInt(numSides) + 1;
    return currentRoll;
  }
}
