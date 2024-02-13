import "package:frontend/game/models/ruleset.dart";

/// Generates default ruleset with  30 and sides per dice 6.
Ruleset getTestRuleset(
    {numDice = 30,
    numSides = 6,
    turnTime = -1,
    challenges = false,
    guardianAngel = true,
    handicap = false,
    heal = false,
    mysteryDice = false,
    randomizeSeats = false,
    swapDirection = false,
    wildcards = const <int>[6]}) {
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
