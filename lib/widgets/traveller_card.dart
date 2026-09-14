import 'package:flutter/material.dart';

import '../models/traveller.dart';

/// A reusable card used to display a single traveller in the list.
/// Kept "dumb" (no provider access) so it's easy to reuse anywhere
/// and easy to explain in a review: it just takes data + a callback.
class TravellerCard extends StatelessWidget {
  final Traveller traveller;
  final VoidCallback onTap;
  final bool isConnected;

  const TravellerCard({
    super.key,
    required this.traveller,
    required this.onTap,
    this.isConnected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text(
            traveller.avatarEmoji,
            style: const TextStyle(fontSize: 22),
          ),
        ),
        title: Text(
          '${traveller.name}, ${traveller.age}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text('${traveller.country} → ${traveller.destination}'),
        ),
        trailing: isConnected
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.chevron_right),
      ),
    );
  }
}
