import 'package:frontend/game/models/bet.dart';
import 'package:frontend/game/models/player.dart';
import 'package:frontend/game/models/ruleset.dart';

class AiEngine {
  Ruleset ruleset;
  double difficulty;
  double erraticness;

  AiEngine(this.ruleset, this.difficulty, this.erraticness) {}

  Bet makeBet(Player player, Bet bet) {
    return bet;
  }

  Bet nextBet(Player player, Bet bet) {
    Bet nextBet = Bet(playerId: player.id);

    return bet;
  }
}
