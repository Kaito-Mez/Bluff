import 'package:frontend/game/models/dice.dart';

class Player {
  late List<Dice> hand;
  late List<int> currentRoll;
  Player(this.hand);

  int numDice() => hand.length;

  void discardDice(int numDice) {
    for (var i = 0; i < numDice; i++) {
      if (hand.isNotEmpty) {
        hand.removeLast();
      }
    }
  }

  List<int> rollDice() {
    List<int> results = List.empty(growable: true);
    for (var dice in hand) {
      results.add(dice.roll());
    }

    currentRoll = results;
    return results;
  }
}
