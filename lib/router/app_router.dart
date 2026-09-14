import 'package:go_router/go_router.dart';

import '../screens/filter_screen.dart';
import '../screens/home_screen.dart';
import '../screens/traveller_details_screen.dart';

/// All navigation for the app lives here so it's easy to see the
/// whole route map at a glance.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/filter',
      builder: (context, state) => const FilterScreen(),
    ),
    GoRoute(
      path: '/traveller/:id',
      builder: (context, state) {
        final travellerId = state.pathParameters['id']!;
        return TravellerDetailsScreen(travellerId: travellerId);
      },
    ),
  ],
);
