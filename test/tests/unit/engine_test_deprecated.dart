/*import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/client.dart';
import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/network/client_events_channel.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

void main() async {
  test('Client Unit Test', () {
    List<String> playerNames = ["Joe", "Joseph", "Josephine", "Josephanie"];
    int numsides = 3;
    int numdice = 43;
    Ruleset ruleset = Ruleset(numDice: numdice, numSides: numsides);
    ClientEventsChannel netEvents = ClientEventsChannel();
    ClientEventsChannel uiEvents = ClientEventsChannel();

    // Some sort of constructor test.
    Client client =
        Client(3, playerNames, ruleset, netEvents, uiEvents: uiEvents);

    expect(client.players.length, 4);
    expect(client.players[0].numDice(), 10);
    expect(client.players[2].id, 2);
    expect(client.players[1].name, "Joseph");

    //Get next turn test
    // Not Players turn
    Bet bet = Bet(playerId: 1);
    expect(client.getNextTurn(bet), 2);
    // Is Players turn
    bet = Bet(playerId: 2);
    expect(client.getNextTurn(bet), client.clientID);
    // Was just players turn
    bet = Bet(playerId: 3);
    expect(client.getNextTurn(bet), 0);
  });

  test('Client BlackBox', () async {
    int numsides = 3;
    int numdice = 43;
    List<String> playerNames = ["Joe", "Joseph", "Josephine", "Josephanie"];
    Ruleset ruleset = Ruleset(numDice: numdice, numSides: numsides);
    ClientEventsChannel netEvents = ClientEventsChannel();
    ClientEventsChannel uiEvents = ClientEventsChannel();

    Client player =
        Client(0, playerNames, ruleset, netEvents, uiEvents: uiEvents);
    Client ai1 = Client(1, playerNames, ruleset, netEvents);
    Client ai2 = Client(2, playerNames, ruleset, netEvents);

    int betQuantity = 1;
    int betNum = 1;
    int playerId = 0;
    Bet bet = Bet(playerId: playerId, number: betNum, quantity: betQuantity);

    uiEvents.betEvent.subscribe((args) {
      args = args!;
      expect(args.bet.number, betNum);
      expect(args.bet.quantity, betQuantity);
      expect(args.bet.playerId, playerId);
    });

    netEvents.betEvent.broadcast(BetEventArgs(bet, -1));

    await Future.delayed(const Duration(milliseconds: 500));
  });
}
*/