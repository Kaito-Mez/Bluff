import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/models/events.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';
import 'package:smartlogger/smartlogger.dart';

class Client {
  bool isAiClient = true;
  int clientID;
  Ruleset ruleset;

  EventsChannel netEvents;
  late EventsChannel uiEvents;

  late Bet bet;
  late Player player;
  late List<Player> players;

  Client(this.clientID, List<String> playerNames, this.ruleset, this.netEvents,
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
        (index) => Player(
            index, playerNames[index], List.filled(numDice, Dice(numSides))));
    player = players[clientID];
  }

  void onNetBet(BetEventArgs args) {
    bet = args.bet;

    if (!identical(args.sender, this)) {
      if (!isAiClient) {
        uiEvents.betEvent.broadcast(args);
        uiEvents.turnEvent.broadcast(TurnEventArgs(getNextTurn(bet), this));
      } else {
        Log.v("TODO: AI.ACT ON BET");
      }
    }
  }

  void onLocalBet(BetEventArgs args) {
    bet = args.bet;
    if (identical(args.sender, this)) {
      netEvents.betEvent.broadcast(args);
    }
  }

  void onNetCall(CallEventArgs args) {
    if (!identical(args.sender, this)) {
      netEvents.revealHandEvent
          .broadcast(RevealHandEventArgs(player.id, player.currentRoll, this));
    }
  }

  int getNextTurn(Bet bet) {
    return (bet.playerId + 1) % players.length;
  }
}
