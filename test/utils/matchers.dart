import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/bet.dart';

/// Compares a linked list of bets to a list of bets and expects all elements
/// to be the same in each.
void expectBetsToBe(LinkedList<Bet> actual, List<Bet> matcher) {
  if (actual.isNotEmpty) {
    Bet? raise = actual.first;
    for (var i = 0; i < matcher.length; i++) {
      expect(raise!, isNot(null));
      expect(raise.playerId, matcher[i].playerId);
      expect(raise.betQuantity, matcher[i].betQuantity);
      expect(raise.targetNumber, matcher[i].targetNumber);
      raise = raise.next;
    }
    expect(raise, null);
  } else {
    expect(actual.isEmpty, matcher.isEmpty);
  }
}
