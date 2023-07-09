import 'package:frontend/game/models/dice.dart';

class Player {
  int id;
  String name;
  bool eliminated = false;
  late List<Dice> hand;
  late List<int> currentRoll;

  Player(this.id, this.name, List<Dice> dice) {
    setDice(dice);
  }

  int numDice() => hand.length;

  void discardDice(int numDice) {
    for (var i = 0; i < numDice; i++) {
      if (hand.isNotEmpty) {
        hand.removeLast();
      } else {
        eliminated = true;
      }
    }
  }

  void addDice(int numDice) {
    for (int i = 0; i < numDice; i++) {
      hand.add(Dice());
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

  void setDice(List<Dice> newDice) {
    hand = List.from(newDice);
    List<int> roll = List.empty(growable: true);

    for (Dice dice in newDice) {
      roll.add(dice.currentRoll);
    }
    currentRoll = roll;
  }
}
