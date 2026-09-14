import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';

void main() {
  // ProviderScope must wrap the whole app so any widget can access
  // Riverpod providers.
  runApp(const ProviderScope(child: FindTravellersApp()));
}

class FindTravellersApp extends StatelessWidget {
  const FindTravellersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Find Travellers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      routerConfig: appRouter,
    );
  }
}
