import '../utils/constants.dart';

class Pet {
  final String name;
  final int level;
  final int happiness;
  final int hunger;

  const Pet({
    required this.name,
    required this.level,
    required this.happiness,
    required this.hunger,
  });

  factory Pet.initial(String name) {
    return Pet(
      name: name,
      level: kInitialLevel,
      happiness: kInitialHappiness,
      hunger: kInitialHunger,
    );
  }

  Pet copyWith({
    String? name,
    int? level,
    int? happiness,
    int? hunger,
  }) {
    return Pet(
      name: name ?? this.name,
      level: level ?? this.level,
      happiness: (happiness ?? this.happiness).clamp(kMinHappiness, kMaxHappiness),
      hunger: (hunger ?? this.hunger).clamp(kMinHunger, kMaxHunger),
    );
  }
}
