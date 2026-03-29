enum UpgradeCategory { food, toy, house }

class Upgrade {
  final String id;
  final String name;
  final UpgradeCategory category;
  final double cost;
  final double incomePerSecond;
  final int tapBonus;
  final int count;

  const Upgrade({
    required this.id,
    required this.name,
    required this.category,
    required this.cost,
    required this.incomePerSecond,
    required this.tapBonus,
    this.count = 0,
  });

  Upgrade copyWith({int? count}) {
    return Upgrade(
      id: id,
      name: name,
      category: category,
      cost: cost,
      incomePerSecond: incomePerSecond,
      tapBonus: tapBonus,
      count: count ?? this.count,
    );
  }

  double get currentCost => cost * (count + 1);
}
