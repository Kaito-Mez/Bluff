import "package:frontend/game/client.dart";
import "network/events_channel_test_data.dart";

import "ruleset_test_data.dart";

/// Generate a player client with default ruleset
Client getPlayerClient() {
  return Client(0, getRuleset(), getEventsChannel(),
      uiEvents: getEventsChannel());
}

/// Generate an AI client with default ruleset
Client getAiClient() {
  return Client(0, getRuleset(), getEventsChannel());
}
