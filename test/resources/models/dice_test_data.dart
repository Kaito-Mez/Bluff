import "package:frontend/game/models/dice.dart";

/// Create a single die with 6 sides and a wildcard on 6
Dice getDie() {
  return Dice(6);
}

/// Create a number of dice with 6 sides and a wildcard on 6 equal to quantity
List<Dice> getDice(int quantity) {
  return List.filled(quantity, Dice(6));
}

/// Create a single custom dice
Dice getCustomDie(int numSides, List<int> wildcards) {
  return Dice(numSides);
}

/// Create a number of custom dice equal to quantity
List<Dice> getCustomDice(int numSides, List<int> wildcards, int quantity) {
  return List.filled(quantity, Dice(numSides));
}
