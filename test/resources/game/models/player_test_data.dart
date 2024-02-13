import "package:frontend/game/models/player.dart";
import "dice_test_data.dart";

/// Generate a player with id 0 named Joe with six 6-sided dice
Player getTestPlayer(
    {int id = 0, String name = "Joe", int numSides = 6, int numDice = 6}) {
  return Player(id, name, getTestDice(numSides: numSides, numDice: numDice));
}
