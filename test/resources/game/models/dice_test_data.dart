import "package:frontend/game/models/dice.dart";

/// Create a single die with 6 sides
Dice getTestDie({int numSides = 6}) {
  return Dice(6);
}

/// Create a number of dice with 6 sides and a equal to quantity
List<Dice> getTestDice({int numSides = 6, int numDice = 6}) {
  return List.filled(numDice, Dice(numSides));
}
