import 'package:frontend/game/models/events/bet_event.dart';
import 'package:frontend/game/network/client_events_channel.dart';

enum GameType { local, lan, online }

class NetEngine {
  GameType gameType;
  ClientEventsChannel events;

  /// TODO Add sockets type thing

  NetEngine(this.gameType, this.events);

  //FOR ONLINE OR LAN PROBABLY
  void onServerBet(BetEventArgs args) {
    if (!identical(args.sender, this)) {
      events.betEvent.broadcast(args);
    }
  }
}
