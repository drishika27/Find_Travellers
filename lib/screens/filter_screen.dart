import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/traveller_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = ref.watch(availableDestinationsProvider);
    final selectedDestination = ref.watch(destinationFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Filter by destination')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a destination',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: destinations.map((destination) {
                final isSelected = destination == selectedDestination;
                return ChoiceChip(
                  label: Text(destination),
                  selected: isSelected,
                  onSelected: (selected) {
                    ref.read(destinationFilterProvider.notifier).state =
                        selected ? destination : null;
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(destinationFilterProvider.notifier).state = null;
                      context.pop();
                    },
                    child: const Text('Clear filter'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.pop(),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
