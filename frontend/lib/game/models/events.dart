import 'package:event/event.dart';
import 'package:frontend/game/models/bet.dart';

class EventsChannel {
  // Events
  Event<BetEventArgs> betEvent = Event<BetEventArgs>();
  Event<CallEventArgs> callEvent = Event<CallEventArgs>();
}

// Define the BetPlaced event
class BetEventArgs extends EventArgs {
  final Bet bet;

  BetEventArgs(this.bet);
}

class CallEventArgs extends EventArgs {
  dynamic data;

  CallEventArgs(this.data);
}
