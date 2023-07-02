import 'dart:math';

class Dice {
  int numSides;

  late int currentRoll;

  Dice({this.numSides = 6});

  int roll() {
    final random = Random();

    currentRoll = random.nextInt(numSides) + 1;
    return currentRoll;
  }
}
