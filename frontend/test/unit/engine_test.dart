import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/client.dart';
import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/models/events.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

void main() async {


  test('Dice Class Unit Tests', () {
    Dice sixSide = Dice(6);
    Dice twentySide = Dice(20);

    expect(sixSide.numSides, 6);
    expect(twentySide.numSides, 20);

    expect(twentySide.roll(), twentySide.currentRoll);
  });

  test('Player Class Unit Tests', () {
    int numDice = 7;
    List<Dice> hand = List.filled(numDice, Dice(6));
    Player player = Player(0, "test", hand);

    expect(player.currentRoll, List.filled(numDice, -1));
    expect(player.numDice(), 7);

    player.discardDice(1);
    expect(player.numDice(), 6);

    player.discardDice(3);
    expect(player.numDice(), 3);
    expect(player.eliminated, false);

    player.discardDice(10);
    expect(player.numDice(), 0);
    expect(player.eliminated, true);

    Player player2 = Player(0, "test", [
      Dice(6, currentRoll: 6),
      Dice(6, currentRoll: 3),
      Dice(6, currentRoll: 4)
    ]);

    expect(player2.currentRoll, List.of([6, 3, 4]));

    player2.addDice(3, Dice(6));
    expect(player2.currentRoll, List.of([6, 3, 4]));
    expect(player2.numDice(), 6);
  });

  test('Client Unit Test', () {
    List<String> playerNames = ["Joe", "Joseph", "Josephine", "Josephanie"];
    int numsides = 3;
    int numdice = 43;
    Ruleset ruleset = Ruleset(numDice: numdice, numSides: numsides);
    EventsChannel netEvents = EventsChannel();
    EventsChannel uiEvents = EventsChannel();

    Client client =
        Client(3, playerNames, ruleset, netEvents, uiEvents: uiEvents);

    expect(client.players.length, 4);
    expect(client.players[0].numDice(), 10);
    expect(client.players[2].id, 2);
    expect(client.players[1].name, "Joseph");

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
    EventsChannel netEvents = EventsChannel();
    EventsChannel uiEvents = EventsChannel();

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
