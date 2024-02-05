import "package:frontend/game/models/player.dart";

import "dice_test_data.dart";

/// Generate a player with id 0 named Joe with six 6-sided dice
Player getPlayer() {
  return Player(0, "Joe", getDice(6));
}
