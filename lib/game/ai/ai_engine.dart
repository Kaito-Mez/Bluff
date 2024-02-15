import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

class AiEngine {
  Ruleset ruleset;
  double difficulty;
  double erraticness;

  AiEngine(this.ruleset, this.difficulty, this.erraticness);

  bool callBluff() {
    bool callBluff = false;
    return callBluff;
  }

  Bet makeBet(Player player, Bet lastBet) {
    /// Some sort of assign probabilities to all potential bets then eliminate
    /// all bets below some probability threshold based on difficulty then select
    /// an option based on erraticness.
    return lastBet;
  }
}
