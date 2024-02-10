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
  probability = _calcBinomialCDF(neededForSuccess, numRolls, probPerRole);

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

double _calcBinomialCDF(int minForSuccess, int numDice, double probPerRole) {
  double probability;
  if (minForSuccess <= 0) {
    probability = 1;
  } else {
    probability = 0;
    //Is bet still possible with number of rolls left
    if (numDice > minForSuccess) {
      //Get prob that num rolled is at least the number required.
      for (int rollNum = minForSuccess; rollNum <= numDice; rollNum++) {
        probability += _calcBinomialPDF(rollNum, numDice, probPerRole);
      }
    }
  }

  return probability;
}

double _calcBinomialPDF(int numForSuccess, int numDice, double probPerRole) {
  double probability = 0;
  probability += _binomialCoefficient(numDice, numForSuccess) *
      pow(probPerRole, numForSuccess) *
      pow(1 - probPerRole, numDice - numForSuccess);

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
