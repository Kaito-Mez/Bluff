import 'dart:math';
import 'package:frontend/game/models/bet.dart';

double getBetProbability(int numSides, int totalNumDice, Bet bet,
    List<int> wildcards, List<int> knownRolls) {
  int numRolls = totalNumDice - knownRolls.length;
  int neededForSuccess = bet.betQuantity;

  double probability = 0;

  for (var roll in knownRolls) {
    if (roll == bet.targetNumber || wildcards.contains(roll)) {
      neededForSuccess -= 1;
    }
  }

  double probPerRole =
      _probOfSuccessfulRole(bet.targetNumber, numSides, wildcards);
  probability = _calcBetProbability(
      bet.targetNumber, neededForSuccess, numRolls, probPerRole);

  return probability;
}

int _binomialCoefficient(int n, int k) {
  return _factorial(n) ~/ (_factorial(k) * _factorial(n - k));
}

int _factorial(int n) {
  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * _factorial(n - 1);
  }
}

double _calcBetProbability(
    int targetNumber, int neededForSuccess, int numDice, double probPerRole) {
  double probability;
  if (neededForSuccess <= 0) {
    probability = 1;
  } else if (neededForSuccess > numDice) {
    probability = 0;
  } else {
    probability = 0;
    for (int rollNum = neededForSuccess; rollNum <= numDice; rollNum++) {
      probability += _binomialCoefficient(numDice, rollNum) *
          pow(probPerRole, rollNum) *
          pow(1 - probPerRole, numDice - rollNum);
    }
  }

  return probability;
}

///Get the probability of each die landing on the target side.
double _probOfSuccessfulRole(
    int targetRole, int numSides, List<int> wildcards) {
  int numerator = 0;
  int denominator = numSides;

  for (var i = 0; i < denominator; i++) {
    if (i == targetRole || wildcards.contains(i)) {
      numerator += 1;
    }
  }

  return numerator / denominator;
}
