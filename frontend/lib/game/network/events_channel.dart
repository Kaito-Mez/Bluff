import 'package:event/event.dart';
import 'package:frontend/game/models/events/bet_event.dart';
import 'package:frontend/game/models/events/call_event.dart';
import 'package:frontend/game/models/events/reveal_event.dart';
import 'package:frontend/game/models/events/roll_event.dart';
import 'package:frontend/game/models/events/turn_event.dart';

class EventsChannel {
  // Events

  /// When a player or ai places a bet
  Event<BetEventArgs> betEvent = Event<BetEventArgs>();

  /// When a player or ai calls a bluff
  Event<CallEventArgs> callEvent = Event<CallEventArgs>();


  /// When a player or ai reveals their hand after a bluff is called
  Event<RevealEventArgs> revealEvent = Event<RevealEventArgs>();
  
  

  // When a new turn starts.
  Event<TurnEventArgs> turnEvent = Event<TurnEventArgs>();
}
