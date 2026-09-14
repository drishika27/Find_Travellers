# Find Travellers (Practice Project)

A small, **standalone** Flutter practice app. It is completely separate
from any other project — no shared code, no shared backend, no real
API/database/auth. Every traveller shown is hard-coded mock data in
`lib/data/mock_travellers.dart`.

## What it demonstrates
- Flutter widgets & layout (Cards, Chips, ListView, SingleChildScrollView)
- State management with `flutter_riverpod` (`FutureProvider`, `Provider`,
  `StateProvider`, `StateNotifierProvider`)
- Navigation with `go_router` (including a path parameter for the
  traveller detail route)
- Loading state (simulated async delay), empty state (filter with no
  matches), and a simulated "connect" action with its own loading state
- Filtering a list based on selected criteria
- A reusable widget (`TravellerCard`, `EmptyState`)

## Project structure
```
lib/
├── main.dart
├── models/traveller.dart
├── data/mock_travellers.dart
├── providers/traveller_provider.dart
├── router/app_router.dart
├── screens/
│   ├── home_screen.dart
│   ├── filter_screen.dart
│   └── traveller_details_screen.dart
└── widgets/
    ├── traveller_card.dart
    └── empty_state.dart
```

## How to run it

This zip contains only the `lib/` source + `pubspec.yaml` (no
`android/`/`ios/`/`web/` platform folders, since those are auto-generated
and machine-specific). Follow these steps on your machine:

```bash
# 1. Unzip the project
unzip find_travellers.zip
cd find_travellers

# 2. Generate the platform folders (android, ios, web, etc.)
#    for THIS project only — this does not touch any other project.
flutter create .

# 3. Install dependencies
flutter pub get

# 4. Run it (pick whichever target you have available)
flutter run                 # auto-detects a connected device/emulator
flutter run -d chrome       # run in a browser
flutter run -d windows      # run as a Windows desktop app
flutter run -d macos        # run as a macOS desktop app

# Optional: check for any static analysis issues
flutter analyze
```

> Prerequisite: the [Flutter SDK](https://docs.flutter.dev/get-started/install)
> must already be installed and on your PATH (`flutter doctor` should run
> without fatal errors).

## Explaining it in review (suggested talking points)
1. **Data flow**: `mock_travellers.dart` → `travellersProvider`
   (`FutureProvider`, simulates a fetch) → `filteredTravellersProvider`
   (`Provider`, combines data + filter) → `HomeScreen` (`ConsumerWidget`
   watches it and renders loading/empty/data states with `.when(...)`).
2. **Filtering**: `destinationFilterProvider` is a `StateProvider<String?>`
   set from `FilterScreen`; `filteredTravellersProvider` reacts to it
   automatically because it `ref.watch`es both providers.
3. **Navigation**: `go_router` routes are declared once in
   `app_router.dart`; `context.push('/traveller/$id')` passes the id as a
   path parameter, read back with `state.pathParameters['id']`.
4. **Simulated "connect" action**: `TravellerDetailsScreen` is a
   `ConsumerStatefulWidget` with its own local `_isConnecting` bool for
   the button's loading spinner, then commits the result to the shared
   `connectionsProvider` (`StateNotifierProvider`) so the checkmark also
   shows back on the home list.
# Find_Travellers
