import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/traveller_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/traveller_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTravellersAsync = ref.watch(filteredTravellersProvider);
    final selectedDestination = ref.watch(destinationFilterProvider);
    final connectedIds = ref.watch(connectionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Travellers'),
        actions: [
          IconButton(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.push('/filter'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Show an active-filter chip so the user always knows what
          // they're currently looking at, with a quick way to clear it.
          if (selectedDestination != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text('Destination: $selectedDestination'),
                  onDeleted: () =>
                      ref.read(destinationFilterProvider.notifier).state = null,
                ),
              ),
            ),
          Expanded(
            child: filteredTravellersAsync.when(
              // Loading state: shown while travellersProvider's Future
              // is still resolving.
              loading: () => const Center(child: CircularProgressIndicator()),
              // Error state: shown if the (simulated) fetch fails.
              error: (error, stackTrace) => Center(
                child: Text('Something went wrong: $error'),
              ),
              // Data state: either an empty state or the real list.
              data: (travellers) {
                if (travellers.isEmpty) {
                  return const EmptyState(
                    message: 'No travellers match this filter.\nTry a different destination.',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  itemCount: travellers.length,
                  itemBuilder: (context, index) {
                    final traveller = travellers[index];
                    return TravellerCard(
                      traveller: traveller,
                      isConnected: connectedIds.contains(traveller.id),
                      onTap: () => context.push('/traveller/${traveller.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
