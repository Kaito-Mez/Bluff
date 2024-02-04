import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';
import 'package:frontend/game/models/events/bet_event.dart';
import 'package:frontend/game/models/events/call_event.dart';
import 'package:frontend/game/models/events/reveal_event.dart';
import 'package:frontend/game/models/events/roll_event.dart';
import 'package:frontend/game/models/events/turn_event.dart';
import 'package:frontend/game/network/client_events_channel.dart';
import 'package:smartlogger/smartlogger.dart';

class Client {
  bool isAiClient = true;
  int clientID;
  Ruleset ruleset;

  ClientEventsChannel netEvents;
  late ClientEventsChannel uiEvents;

  late Bet bet;
  late Player player;
  late List<Player> players;

  ///Client Object. Pass uiEvents channel if this client is the device's player.
  ///
  ///There is one client object per player on a device. IE if an AI is running
  ///on a device that device has one client for the player and one for the ai.
  Client(this.clientID, this.ruleset, this.netEvents,
      {ClientEventsChannel? uiEvents}) {
    if (uiEvents != null) {
      this.uiEvents = uiEvents;
      isAiClient = false;
      uiEvents.betEvent.subscribe((args) => onLocalBet(args!));
    }

    netEvents.betEvent.subscribe((args) => onNetBet(args!));
  }

  ///Setup all player objects.
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

  int getNextTurn(Bet bet) {
    return (bet.playerId + 1) % players.length;
  }

  ///Inbound

  ///On receiving a bet event from the net, pass it on to the UI.
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

  ///On receiving a bluff call event from the net, pass it on to the net.
  void onNetCall(CallEventArgs args) {
    if (!identical(args.sender, this)) {
      netEvents.revealEvent
          .broadcast(RevealEventArgs(player.id, player.currentRoll, this));
    }
  }

  ///Outbound

  ///On receiving a bet from the UI, pass it on to the net.
  void onLocalBet(BetEventArgs args) {
    bet = args.bet;
    if (identical(args.sender, this)) {
      netEvents.betEvent.broadcast(args);
    }
  }
}
