import '../utils/constants.dart';

enum UpgradeCategory { memory, emotion, language, reasoning, creativity }

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

  /// 업그레이드 가격: 기본 비용 * 1.5^count (복리 증가)
  double get currentCost {
    if (count == 0) return cost;
    return cost * _pow(kUpgradeCostMultiplier, count);
  }

  static double _pow(double base, int exponent) {
    double result = 1.0;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}
