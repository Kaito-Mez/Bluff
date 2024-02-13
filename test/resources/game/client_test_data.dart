import "package:frontend/game/client.dart";
import "package:frontend/game/models/ruleset.dart";
import "package:frontend/game/network/client_events_channel.dart";
import 'network/client_events_channel_test_data.dart';

import 'models/ruleset_test_data.dart';

/// Generate a player client with default ruleset
Client getPlayerClient() {
  return Client(0, getTestRuleset(), getTestClientEventsChannel(),
      uiEvents: getTestClientEventsChannel());
}

/// Generate an AI client with default ruleset
Client getAiClient() {
  return Client(0, getTestRuleset(), getTestClientEventsChannel());
}

/// Generate list of clients with one player and the rest being AI.
List<Client> getClients(int quantity) {
  ClientEventsChannel netEvents = getTestClientEventsChannel();
  ClientEventsChannel uiEvents = getTestClientEventsChannel();
  Ruleset ruleset = getTestRuleset();
  List<Client> clients = List.empty(growable: true);

  clients.add(Client(0, ruleset, netEvents, uiEvents: uiEvents));

  for (var i = 1; i < quantity; i++) {
    clients.add(Client(i, ruleset, netEvents));
  }

  return clients;
}
