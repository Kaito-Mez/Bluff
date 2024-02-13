import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/player.dart';

import '../../../../resources/game/models/dice_test_data.dart';
import '../../../../resources/game/models/player_test_data.dart';

void main() async {
  test('Setting dice should set new dice', () {
    int expectedNumDice = 6;
    List<int> expectedRole = List.of(<int>[-1, -1, -1, -1, -1, -1]);
    Player player = getPlayer();

    expect(player.numDice(), expectedNumDice);
    expect(player.currentRoll, expectedRole);

    expectedNumDice = 15;
    expectedRole = List.filled(expectedNumDice, -1);
    player.setDice(getDice(15));

    expect(player.numDice(), expectedNumDice);
    expect(player.currentRoll, expectedRole);
  });

  test('Rolling dice should set their values', () {
    List<int> expectedInitialRole = List.of(<int>[-1, -1, -1, -1, -1, -1]);
    Player player = getPlayer();

    expect(player.currentRoll, expectedInitialRole);

    List<int> roll = player.rollDice();

    expect(player.currentRoll, isNot(expectedInitialRole));
    expect(player.currentRoll, roll);
  });

  group("Modify Hand Size:", () {
    test('Adding dice should increase hand size', () {
      int expectedHandSize = 6;
      Player player = getPlayer();
      expect(player.numDice(), expectedHandSize);

      player.addDice(2, getDie());
      expectedHandSize = 8;

      expect(player.numDice(), expectedHandSize);
    });

    test('Discarding dice should decrease hand size', () {
      int expectedHandSize = 6;
      Player player = getPlayer();
      expect(player.numDice(), expectedHandSize);

      player.discardDice(4);
      expectedHandSize = 2;

      expect(player.numDice(), expectedHandSize);
    });

    test('Discarding to zero dice should mark player eliminated', () {
      int expectedHandSize = 6;
      Player player = getPlayer();
      bool expectedEliminated = false;

      expect(player.numDice(), expectedHandSize);
      expect(player.eliminated, expectedEliminated);

      player.discardDice(7);
      expectedHandSize = 0;
      expectedEliminated = true;

      expect(player.numDice(), expectedHandSize);
      expect(player.eliminated, expectedEliminated);
    });
  });
}
