import 'package:frontend/game/models/events.dart';

enum GameType { local, lan, online }

class NetEngine {
  GameType gameType;
  EventsChannel events;

  /// TODO Add sockets type thing

  NetEngine(this.gameType, this.events) {}

  //FOR ONLINE OR LAN PROBABLY
  void onServerBet(BetEventArgs args) {
    if (!identical(args.sender, this)) {
      events.betEvent.broadcast(args);
    }
  }
}
