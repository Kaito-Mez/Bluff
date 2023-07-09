// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/client.dart';
import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/dice.dart';
import 'package:frontend/game/models/events.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

import 'package:frontend/main.dart';

void main() async {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Bet Class Unit Tests', () {
    Bet bet = Bet();

    int wildcard = 6;
    List<int> dice = <int>[1, 2, 2, 3, 4, 5, 6, 6];

    /// Safe bet testcase
    int betQuant = 1;
    int betNumber = 2;
    bet.placeBet(0, betNumber, betQuant);
    expect(bet.verifyBet(wildcard, dice), 3);

    /// Perfect bet testcase
    betQuant = 4;
    bet.placeBet(0, betNumber, betQuant);
    expect(bet.verifyBet(wildcard, dice), 0);

    /// Incorrect bet testcase
    betQuant = 5;
    bet.placeBet(0, betNumber, betQuant);
    expect(bet.verifyBet(wildcard, dice), -1);
  });

  test('Dice Class Unit Tests', () {
    Dice sixSide = Dice();
    Dice twentySide = Dice(numSides: 20);

    expect(sixSide.numSides, 6);
    expect(twentySide.numSides, 20);

    expect(twentySide.roll(), twentySide.currentRoll);
  });

  test('Player Class Unit Tests', () {
    int numDice = 7;
    List<Dice> hand = List.filled(numDice, Dice());
    Player player = Player(0, "test", hand);

    expect(player.currentRoll, List.filled(numDice, -1));
    expect(player.numDice(), 7);

    player.discardDice(1);
    expect(player.numDice(), 6);

    player.discardDice(3);
    expect(player.numDice(), 3);
    expect(player.eliminated, false);

    player.discardDice(10);
    expect(player.numDice(), 0);
    expect(player.eliminated, true);

    Player player2 = Player(0, "test",
        [Dice(currentRoll: 6), Dice(currentRoll: 3), Dice(currentRoll: 4)]);

    expect(player2.currentRoll, List.of([6, 3, 4]));

    player2.addDice(3);
    expect(player2.currentRoll, List.of([6, 3, 4]));
    expect(player2.numDice(), 6);
  });

  test('Events Unit Test', () {
    EventsChannel events = EventsChannel();
    EventsChannel events2 = EventsChannel();

    Client client1 = Client(["player1"], Ruleset(), events);
    Client client2 = Client(["player32"], Ruleset(), events2);

    events.betEvent.broadcast(BetEventArgs(Bet()));
  });
}
