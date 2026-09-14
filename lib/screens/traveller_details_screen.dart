import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mock_travellers.dart';
import '../models/traveller.dart';
import '../providers/traveller_provider.dart';

class TravellerDetailsScreen extends ConsumerStatefulWidget {
  final String travellerId;

  const TravellerDetailsScreen({super.key, required this.travellerId});

  @override
  ConsumerState<TravellerDetailsScreen> createState() =>
      _TravellerDetailsScreenState();
}

class _TravellerDetailsScreenState
    extends ConsumerState<TravellerDetailsScreen> {
  // Local UI-only state: whether we're mid "connecting" animation.
  // This does not belong in a global provider because no other
  // screen needs to know about it.
  bool _isConnecting = false;

  Future<void> _handleConnectPressed(Traveller traveller) async {
    setState(() => _isConnecting = true);

    // Simulate a network call with a short delay.
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    ref.read(connectionsProvider.notifier).toggleConnection(traveller.id);
    setState(() => _isConnecting = false);
  }

  @override
  Widget build(BuildContext context) {
    // Look the traveller up from the mock data by id. In a real app
    // this would come from a provider/repository; here the mock list
    // is small enough to search directly.
    final traveller = mockTravellers.firstWhere(
      (t) => t.id == widget.travellerId,
      orElse: () => throw StateError('Traveller not found'),
    );

    final connectedIds = ref.watch(connectionsProvider);
    final isConnected = connectedIds.contains(traveller.id);

    return Scaffold(
      appBar: AppBar(title: Text(traveller.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  traveller.avatarEmoji,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '${traveller.name}, ${traveller.age}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                traveller.country,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Heading to', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(traveller.destination, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Interests', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: traveller.interests
                  .map((interest) => Chip(label: Text(interest)))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text('About', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text(traveller.bio, style: const TextStyle(fontSize: 15, height: 1.4)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isConnecting ? null : () => _handleConnectPressed(traveller),
                icon: _isConnecting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(isConnected ? Icons.check : Icons.person_add),
                label: Text(
                  _isConnecting
                      ? 'Connecting...'
                      : (isConnected ? 'Connected' : 'Connect'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
