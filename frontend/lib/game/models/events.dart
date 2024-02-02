import 'package:event/event.dart';
import 'package:frontend/game/models/bet.dart';

class EventsChannel {
  // Events

  /// When a player or ai places a bet
  Event<BetEventArgs> betEvent = Event<BetEventArgs>();

  /// When a player or ai calls a bluff
  Event<CallEventArgs> callEvent = Event<CallEventArgs>();

  //
  Event<TurnEventArgs> turnEvent = Event<TurnEventArgs>();

  /// When a player or ai reveals their hand after a bluff is called
  Event<RevealHandEventArgs> revealHandEvent = Event<RevealHandEventArgs>();
}

// Define the BetPlaced event
class BetEventArgs extends EventArgs {
  final Bet bet;
  final dynamic sender;

  BetEventArgs(this.bet, this.sender);
}

class CallEventArgs extends EventArgs {
  final int playerID;
  final dynamic sender;

  CallEventArgs(this.playerID, this.sender);
}

class TurnEventArgs extends EventArgs {
  // ID of player whose turn it is
  final int playerID;
  final dynamic sender;

  TurnEventArgs(this.playerID, this.sender);
}

class RevealHandEventArgs extends EventArgs {
  final int playerID;
  final List<int> hand;
  final dynamic sender;

  RevealHandEventArgs(this.playerID, this.hand, this.sender);
}

class RollEventArgs extends EventArgs {
  final dynamic sender;

  RollEventArgs(this.sender);
}
