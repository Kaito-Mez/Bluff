import 'package:event/event.dart';

class TurnEventArgs extends EventArgs {
  // ID of player whose turn it is
  final int playerID;
  final dynamic sender;

  TurnEventArgs(this.playerID, this.sender);
}
