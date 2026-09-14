/// A simple, plain data model for a traveller.
///
/// This app uses ONLY local mock data — there is no backend, no API,
/// and no database. This class exists purely so we have something
/// structured to display, filter, and navigate to.
class Traveller {
  final String id;
  final String name;
  final int age;
  final String country;
  final String destination;
  final List<String> interests;
  final String bio;
  final String avatarEmoji;

  const Traveller({
    required this.id,
    required this.name,
    required this.age,
    required this.country,
    required this.destination,
    required this.interests,
    required this.bio,
    required this.avatarEmoji,
  });
}
