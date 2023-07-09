import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/events.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

class Client {
  bool isAiClient = true;
  int turnIndex = 0;
  Ruleset ruleset;

  EventsChannel netEvents;
  late EventsChannel uiEvents;

  late Bet bet;
  late List<Player> players;

  Client(List<String> playerNames, this.ruleset, this.netEvents,
      {EventsChannel? uiEvents}) {
    setupGame(playerNames);

    if (uiEvents != null) {
      this.uiEvents = uiEvents;
      isAiClient = false;
      uiEvents.betEvent.subscribe((args) => onLocalBet(args!));
    }

    netEvents.betEvent.subscribe((args) => onNetBet(args!));
  }

  void setupGame(List<String> playerNames) {
    int numPlayers = playerNames.length;
    int numDice = ((ruleset.numDice / playerNames.length) - 0.5).round();
    int numSides = ruleset.numSides;

    players = List.generate(
        numPlayers,
        (index) => Player(index, playerNames[index],
            List.filled(numDice, Dice(numSides: numSides))));
  }

  void onNetBet(BetEventArgs args) {
    bet = args.bet;
    print("on bet");

    if (!isAiClient) {
      uiEvents.betEvent.broadcast(args);
    }
  }

  void onLocalBet(BetEventArgs args) {
    bet = args.bet;

    netEvents.betEvent.broadcast(args);
  }
}
