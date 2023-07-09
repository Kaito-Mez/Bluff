class Ruleset {
  ///Number of dice in play at the beginning of the game
  int numDice;

  ///Number of sides each dice has
  int numSides;

  ///Number of seconds a player has to make a bet before a random one is made
  int turnTime;

  ///Players losing by a lot will be given extra info
  bool handicap;

  ///When your perfect bet is called you gain a dice in addition to opponents losing
  bool heal;

  ///Lost dice are still rolled but no player can see them
  bool mysteryDice;

  ///Players can't lose their final dice if they were not the better or caller
  bool guardianAngel;

  ///If players win in risky ways then they can heal dice
  bool challenges;

  Ruleset(
      {this.numDice = 30,
      this.numSides = 6,
      this.turnTime = -1,
      this.handicap = false,
      this.heal = false,
      this.mysteryDice = false,
      this.guardianAngel = true,
      this.challenges = false});
}
