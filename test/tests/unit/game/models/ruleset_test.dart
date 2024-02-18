import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/ruleset.dart';

import '../../../../resources/game/models/bet_test_data.dart';
import '../../../../resources/game/models/ruleset_test_data.dart';
import '../../../../utils/matchers.dart';

void main() async {
  group("getLargestValidBetNum() Tests:", () {
    Ruleset ruleset;
    test(
        'Should return highest non-wildcard number when highest number is a wildcard',
        () {
      ruleset = getTestRuleset();
      int expectedLargestRoll = 5;

      expect(ruleset.getLargestValidBetNum(), expectedLargestRoll);
    });
    test('Should return highest number when highest number isn\'t a wildcard',
        () {
      ruleset = getTestRuleset(wildcards: [3]);
      int expectedLargestRoll = 6;

      expect(ruleset.getLargestValidBetNum(), expectedLargestRoll);
    });
    test('Should return highest non-wildcard number on non-standard die', () {
      ruleset = getTestRuleset(numSides: 23, wildcards: [1, 5, 19, 22, 23]);
      int expectedLargestRoll = 21;

      expect(ruleset.getLargestValidBetNum(), expectedLargestRoll);
    });
  });

  group("getSmallestValidBetNum() Tests:", () {
    Ruleset ruleset;
    test(
        'Should return lowest non-wildcard number when lowest number is a wildcard',
        () {
      ruleset = getTestRuleset(wildcards: [1]);
      int expectedSmallestRole = 2;

      expect(ruleset.getSmallestValidBetNum(), expectedSmallestRole);
    });
    test('Should return lowest number when lowest number isn\'t a wildcard',
        () {
      ruleset = getTestRuleset();
      int expectedSmallestRole = 1;

      expect(ruleset.getSmallestValidBetNum(), expectedSmallestRole);
    });
    test('Should return lowest non-wildcard number on non-standard die', () {
      ruleset = getTestRuleset(numSides: 23, wildcards: [1, 2, 5, 19, 22]);
      int expectedSmallestRole = 3;

      expect(ruleset.getSmallestValidBetNum(), expectedSmallestRole);
    });
  });
  group("getValidBetNumbers() Tests:", () {
    Ruleset ruleset;
    test('Should return all when there is no wildcard', () {
      ruleset = getTestRuleset(wildcards: []);
      List<int> expectedValidBets = [1, 2, 3, 4, 5, 6];

      expect(ruleset.getValidBetNums(), expectedValidBets);
    });
    test('Should return all but wildcard when there is one wildcard', () {
      ruleset = getTestRuleset();
      List<int> expectedValidBets = [1, 2, 3, 4, 5];

      expect(ruleset.getValidBetNums(), expectedValidBets);
    });
    test('Should return all but wildcards on non-standard die', () {
      ruleset = getTestRuleset(numSides: 14, wildcards: [1, 5, 10, 11, 13]);
      List<int> expectedValidBets = [2, 3, 4, 6, 7, 8, 9, 12, 14];

      expect(ruleset.getValidBetNums(), expectedValidBets);
    });
  });
  group("getValidRaises() Tests:", () {
    int playerId = 0;
    Bet initialBet;
    Ruleset ruleset;
    List<int> validBetNums;
    LinkedList<Bet> raises;
    test("Should return all valid raises", () {
      initialBet = getTestBet(targetNumber: 4, betQuantity: 8);
      ruleset = getTestRuleset(totalNumDice: 10);
      raises = ruleset.getValidRaises(playerId, initialBet);

      List<Bet> expectedRaises = [
        getTestBet(betQuantity: 8, targetNumber: 5),
        getTestBet(betQuantity: 9, targetNumber: 1),
        getTestBet(betQuantity: 9, targetNumber: 2),
        getTestBet(betQuantity: 9, targetNumber: 3),
        getTestBet(betQuantity: 9, targetNumber: 4),
        getTestBet(betQuantity: 9, targetNumber: 5),
        getTestBet(betQuantity: 10, targetNumber: 1),
        getTestBet(betQuantity: 10, targetNumber: 2),
        getTestBet(betQuantity: 10, targetNumber: 3),
        getTestBet(betQuantity: 10, targetNumber: 4),
        getTestBet(betQuantity: 10, targetNumber: 5)
      ];

      expectBetsToBe(raises, expectedRaises);
    });
    test("Should return empty list if there are no valid raises", () {
      initialBet = getTestBet(betQuantity: 8, targetNumber: 5);
      ruleset = getTestRuleset(totalNumDice: 8);
      raises = ruleset.getValidRaises(playerId, initialBet);

      List<Bet> expectedRaises = List.empty();

      expectBetsToBe(raises, expectedRaises);
    });
    test("All bets should be larger than the predecessor", () {
      initialBet = getTestBet(betQuantity: 8, targetNumber: 5);
      ruleset = getTestRuleset(totalNumDice: 30);
      raises = ruleset.getValidRaises(playerId, initialBet);
      validBetNums = ruleset.getValidBetNums();

      for (var raise in raises) {
        // Bet should always be at least the previous quantity
        expect(raise.betQuantity >= initialBet.betQuantity, true);
        // Bet should always be at most the total number of dice
        expect(raise.betQuantity <= ruleset.totalNumDice, true);
        // Bet should always be a valid number
        expect(validBetNums.contains(raise.targetNumber), true);

        // If the target number is lower in the raise, then
        if (raise.targetNumber <= initialBet.targetNumber) {
          // The bet should have a larger quantity
          expect(raise.betQuantity > initialBet.betQuantity, true);
        }

        // And if the bet is the same quantity, then
        if (raise.betQuantity == initialBet.betQuantity) {
          // The bet should have a larger target number
          expect(raise.targetNumber > initialBet.targetNumber, true);
        }

        initialBet = raise;
      }
    });
  });
}
