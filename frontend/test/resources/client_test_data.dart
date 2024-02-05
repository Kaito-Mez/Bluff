import "package:frontend/game/client.dart";
import "package:frontend/game/models/ruleset.dart";
import "package:frontend/game/network/client_events_channel.dart";
import 'network/client_events_channel_test_data.dart';

import "ruleset_test_data.dart";

/// Generate a player client with default ruleset
Client getPlayerClient() {
  return Client(0, getRuleset(), getClientEventsChannel(),
      uiEvents: getClientEventsChannel());
}

/// Generate an AI client with default ruleset
Client getAiClient() {
  return Client(0, getRuleset(), getClientEventsChannel());
}

/// Generate list of clients with one player and the rest being AI.
List<Client> getClients(int quantity) {
  ClientEventsChannel netEvents = getClientEventsChannel();
  ClientEventsChannel uiEvents = getClientEventsChannel();
  Ruleset ruleset = getRuleset();
  List<Client> clients = List.empty(growable: true);

  clients.add(Client(0, ruleset, netEvents, uiEvents: uiEvents));

  for (var i = 1; i < quantity; i++) {
    clients.add(Client(i, ruleset, netEvents));
  }

  return clients;
}
