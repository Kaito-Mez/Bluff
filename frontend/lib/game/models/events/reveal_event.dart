import 'package:event/event.dart';

class RevealEventArgs extends EventArgs {
  final int playerID;
  final List<int> hand;
  final dynamic sender;

  RevealEventArgs(this.playerID, this.hand, this.sender);
}
