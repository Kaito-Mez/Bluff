import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/client.dart';

import '../../../resources/client_test_data.dart';
import '../../../resources/models/bet_test_data.dart';

void main() async {
  test('Players should be created when game is setup', () {
    Client client = getPlayerClient();
    List<String> playerNames = ["Joe", "Joseph", "Josephine", "Josephanie"];

    client.setupGame(playerNames);

    expect(client.players.length, 4);
    expect(client.players[0].numDice(), 7);
    expect(client.players[2].id, 2);
    expect(client.players[1].name, "Joseph");
  });

  group('Get Next Turn Tests:', () {
    Client client = getPlayerClient();
    List<String> playerNames = ["Joe", "Joseph", "Josephine", "Josephanie"];
    client.setupGame(playerNames);

    test('Should return next players ID', () {
      int expectedNextID = 1;

      expect(client.getNextTurn(getBet()), expectedNextID);
    });

    test('Should return next players ID', () {
      int currentBetId = 3;
      int expectedNextID = 0;

      expect(client.getNextTurn(getCustomIdBet(currentBetId)), expectedNextID);
    });
  });

  group('Get Num Die Tests: ', () {
    int totalNumDice = 30;
    Client client = getPlayerClient();

    test('Should give right number when perfectly divisible.', () {
      int numPlayers = 6;
      int expectedDicePerPlayer = 5;

      expect(client.getNumDicePerPlayer(totalNumDice, numPlayers),
          expectedDicePerPlayer);
    });

    test('Should give right number when not perfectly divisible', () {
      int numPlayers = 7;
      int expectedDicePerPlayer = 4;

      expect(client.getNumDicePerPlayer(totalNumDice, numPlayers),
          expectedDicePerPlayer);
    });

    test('Should give right number when .', () {
      int actualDicePerPlayer;
      int actualTotalDice;
      int numPlayers = 2;

      for (var i = 0; i < 10; i++) {
        actualDicePerPlayer =
            client.getNumDicePerPlayer(totalNumDice, numPlayers);
        actualTotalDice = actualDicePerPlayer * numPlayers;

        expect(actualTotalDice <= totalNumDice, true);

        numPlayers += 1;
      }
    });
  });
}
