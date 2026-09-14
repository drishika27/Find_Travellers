import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_travellers.dart';
import '../models/traveller.dart';

/// Simulates fetching travellers from "somewhere" (e.g. an API) by
/// adding a short artificial delay. This lets the UI demonstrate a
/// real loading state even though the data is actually local.
///
/// FutureProvider automatically gives us three states for free:
/// loading, data, and error (AsyncValue).
final travellersProvider = FutureProvider<List<Traveller>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 900));
  return mockTravellers;
});

/// The currently selected destination filter.
/// `null` means "no filter applied — show everyone".
final destinationFilterProvider = StateProvider<String?>((ref) => null);

/// Derives the filtered list of travellers from the raw list +
/// whatever filter is currently selected. Because this is a
/// `Provider` (not `FutureProvider`), it stays in sync automatically
/// whenever either `travellersProvider` or `destinationFilterProvider`
/// changes.
final filteredTravellersProvider = Provider<AsyncValue<List<Traveller>>>((ref) {
  final travellersAsync = ref.watch(travellersProvider);
  final selectedDestination = ref.watch(destinationFilterProvider);

  return travellersAsync.whenData((travellers) {
    if (selectedDestination == null || selectedDestination.isEmpty) {
      return travellers;
    }
    return travellers
        .where((traveller) => traveller.destination == selectedDestination)
        .toList();
  });
});

/// A small helper provider that returns the unique list of
/// destinations available, used to build the filter chips.
final availableDestinationsProvider = Provider<List<String>>((ref) {
  final destinations = mockTravellers.map((t) => t.destination).toSet().toList();
  destinations.sort();
  return destinations;
});

/// Tracks which traveller IDs the user has "connected" with.
/// This is purely local, in-memory state — nothing is sent anywhere.
class ConnectionsNotifier extends StateNotifier<Set<String>> {
  ConnectionsNotifier() : super(<String>{});

  bool isConnected(String travellerId) => state.contains(travellerId);

  void toggleConnection(String travellerId) {
    final updated = Set<String>.from(state);
    if (updated.contains(travellerId)) {
      updated.remove(travellerId);
    } else {
      updated.add(travellerId);
    }
    state = updated;
  }
}

final connectionsProvider =
    StateNotifierProvider<ConnectionsNotifier, Set<String>>(
  (ref) => ConnectionsNotifier(),
);
