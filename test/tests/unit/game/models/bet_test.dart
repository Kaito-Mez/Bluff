import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/bet.dart';

void main() async {
  test('Placing a bet should reflect data correctly', () {
    Bet bet = Bet();

    int betQuant = 1;
    int betNumber = 2;
    bet.placeBet(0, betNumber, betQuant);

    expect(bet.playerId, 0);
    expect(bet.betQuantity, betQuant);
    expect(bet.targetNumber, betNumber);
  });

  group('Verify Bet:', () {
    // GIVEN:
    int betNumber = 2;
    List<int> wildcard = [6];
    List<int> diceRoll = <int>[1, 2, 2, 3, 4, 5, 6, 6];
    Bet bet = Bet();

    test('Bet should be under (Caller loses)', () {
      // GIVEN:
      int betQuant = 1;

      // WHEN:
      bet.placeBet(0, betNumber, betQuant);

      // THEN:
      expect(bet.verifyBet(wildcard, diceRoll), 3);
    });

    test('Bet should be over (Better loses)', () {
      // GIVEN:
      int betQuant = 5;

      // WHEN:
      bet.placeBet(0, betNumber, betQuant);

      // THEN:
      expect(bet.verifyBet(wildcard, diceRoll), -1);
    });

    test('Bet should be perfect (All but Better loses)', () {
      // GIVEN:
      int betQuant = 4;

      // WHEN:
      bet.placeBet(0, betNumber, betQuant);

      // THEN:
      expect(bet.verifyBet(wildcard, diceRoll), 0);
    });
  });
}
