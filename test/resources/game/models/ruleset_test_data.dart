import "package:frontend/game/models/ruleset.dart";

/// Generates default ruleset with  30 and sides per dice 6.
Ruleset getTestRuleset(
    {int numDice = 30,
    int numSides = 6,
    int turnTime = -1,
    bool challenges = false,
    bool guardianAngel = true,
    bool handicap = false,
    bool heal = false,
    bool mysteryDice = false,
    bool randomizeSeats = false,
    bool swapDirection = false,
    List<int> wildcards = const <int>[6]}) {
  return Ruleset(
      numDice: numDice,
      numSides: numSides,
      turnTime: turnTime,
      challenges: challenges,
      guardianAngel: guardianAngel,
      handicap: handicap,
      heal: heal,
      mysteryDice: mysteryDice,
      randomizeSeats: randomizeSeats,
      swapDirection: swapDirection,
      wildcards: wildcards);
}
