import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/utils/bet_probability.dart';
import 'package:frontend/game/utils/double_to_precision.dart';

import '../../../../resources/game/models/bet_test_data.dart';

void main() async {
  group('getBetProbability() Tests:', () {
    int numSides, totalNumDice;
    List<int> wildcards, knownRolls;
    Bet bet;

    test('Should return 0 if bet is impossible', () {
      numSides = 4;
      totalNumDice = 7;
      wildcards = [4];
      knownRolls = [1, 3, 3, 4];
      bet = getTestBet(targetNumber: 2, betQuantity: 6);

      double expectedProb = 0;

      expect(
          getBetProbability(numSides, totalNumDice, bet, wildcards, knownRolls),
          expectedProb);
    });
    test('Should return 1 if bet is already made', () {
      numSides = 4;
      totalNumDice = 7;
      wildcards = [4];
      knownRolls = [1, 2, 3, 4];
      bet = getTestBet(betQuantity: 2);

      double expectedProb = 1;

      expect(
          getBetProbability(numSides, totalNumDice, bet, wildcards, knownRolls),
          expectedProb);
    });
    test('Should calculate correct probability for medium number of dice', () {
      numSides = 4;
      totalNumDice = 24;
      wildcards = [];
      knownRolls = [1, 3, 2, 4];
      bet = getTestBet(betQuantity: 7);

      double expectedProb = 0.38283;

      expect(
          doubleToPrecision(
              getBetProbability(
                  numSides, totalNumDice, bet, wildcards, knownRolls),
              5),
          expectedProb);
    });
    test('Should calculate correct probability for large number of dice', () {
      numSides = 5;
      totalNumDice = 70;
      wildcards = [5];
      knownRolls = [1, 3, 2, 4, 5, 5, 1];
      bet = getTestBet(betQuantity: 28);

      double expectedProb = 0.56805;

      expect(
          doubleToPrecision(
              getBetProbability(
                  numSides, totalNumDice, bet, wildcards, knownRolls),
              5),
          expectedProb);
    });
  });
  group('calcBinomialCDF() Tests:', () {
    int minForSuccess;
    int numTrials;
    double probPerTrial;
    test('Should calculate correct probability simple test', () {
      minForSuccess = 1;
      numTrials = 1;
      probPerTrial = 1 / 2;
      double expectedProb = 1 / 2;

      //Expect that CDF to 2 decimal places is 0.5 (actual is 0.50000001)
      expect(
          doubleToPrecision(
              calcBinomialCDF(minForSuccess, numTrials, probPerTrial), 2),
          expectedProb);
    });
    test('Should calculate correct probability for medium number of trials',
        () {
      minForSuccess = 6;
      numTrials = 20;
      probPerTrial = 1 / 4;
      double expectedProb = 0.38283;

      expect(
          doubleToPrecision(
              calcBinomialCDF(minForSuccess, numTrials, probPerTrial), 5),
          expectedProb);
    });
    test('Should calculate correct probability for large number of trials', () {
      minForSuccess = 25;
      numTrials = 63;
      probPerTrial = 2 / 5;
      double expectedProb = 0.56805;

      expect(
          doubleToPrecision(
              calcBinomialCDF(minForSuccess, numTrials, probPerTrial), 5),
          expectedProb);
    });

    test('Should return 1 when bet is guaranteed', () {
      minForSuccess = 0;
      numTrials = 63;
      probPerTrial = 1 / 100;
      double expectedProb = 1;

      expect(calcBinomialCDF(minForSuccess, numTrials, probPerTrial),
          expectedProb);
    });

    test('Should return 0 when bet is impossible', () {
      minForSuccess = 6;
      numTrials = 5;
      probPerTrial = 1 / 2;
      double expectedProb = 0;

      expect(calcBinomialCDF(minForSuccess, numTrials, probPerTrial),
          expectedProb);
    });
  });

  group('probOfSuccessfulRole() Tests:', () {
    int targetRole = 2;
    int numSides;
    List<int> wildcards;
    test('Should return 1/3 for default ruleset', () {
      numSides = 6;
      wildcards = [6];
      double expectedProb = 1 / 3;
      expect(
          probOfSuccessfulRole(targetRole, numSides, wildcards), expectedProb);
    });
    test(
        'Should return 3/5 for 5 sided die with 2 wildcards that aren\'t target',
        () {
      numSides = 5;
      wildcards = [1, 4, 6];
      double expectedProb = 3 / 5;
      expect(
          probOfSuccessfulRole(targetRole, numSides, wildcards), expectedProb);
    });
    test('Should return 1 if all sides are target or wildcard', () {
      numSides = 6;
      wildcards = [1, 3, 4, 5, 6];
      double expectedProb = 1;
      expect(
          probOfSuccessfulRole(targetRole, numSides, wildcards), expectedProb);
    });
  });
}
