import 'package:event/event.dart';
import 'package:frontend/game/models/bet.dart';

class BetEventArgs extends EventArgs {
  final Bet bet;
  final dynamic sender;

  BetEventArgs(this.bet, this.sender);
}
