import 'package:event/event.dart';

class CallEventArgs extends EventArgs {
  final int playerID;
  final dynamic sender;

  CallEventArgs(this.playerID, this.sender);
}
