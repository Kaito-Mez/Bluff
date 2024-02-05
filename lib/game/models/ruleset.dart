class Ruleset {
  ///Number of dice in play at the beginning of the game
  int numDice;

  ///Number of sides each dice has
  int numSides;

  ///Number of seconds a player has to make a bet before a random one is made
  int turnTime;

  ///If players win in risky ways then they can heal dice
  bool challenges;

  ///Players can't lose their final dice if they were not the better or caller
  bool guardianAngel;

  ///Players losing by a lot will be given extra info
  bool handicap;

  ///When your perfect bet is called you gain a dice in addition to opponents losing
  bool heal;

  ///Lost dice are still rolled but no player can see them
  bool mysteryDice;

  ///Order of players changes each round.
  bool randomizeSeats;

  ///Swap direction of play each round.
  bool swapDirection;

  ///Which sides of the dice are wildcards
  List<int> wildcards;

  Ruleset(
      {this.numDice = 30,
      this.numSides = 6,
      this.turnTime = -1,
      this.challenges = false,
      this.guardianAngel = true,
      this.handicap = false,
      this.heal = false,
      this.mysteryDice = false,
      this.randomizeSeats = false,
      this.swapDirection = false,
      this.wildcards = const <int>[6]});
}
