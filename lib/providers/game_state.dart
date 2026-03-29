import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pet.dart';
import '../models/upgrade.dart';
import '../utils/constants.dart';

class GameState {
  final Pet pet;
  final double coins;
  final List<Upgrade> upgrades;

  const GameState({
    required this.pet,
    required this.coins,
    required this.upgrades,
  });

  int get coinsPerTap {
    return upgrades.fold(
      kBaseCoinsPerTap,
      (sum, u) => sum + u.tapBonus * u.count,
    );
  }

  double get coinsPerSecond {
    return upgrades.fold(
      kBaseCoinsPerSecond,
      (sum, u) => sum + u.incomePerSecond * u.count,
    );
  }

  GameState copyWith({
    Pet? pet,
    double? coins,
    List<Upgrade>? upgrades,
  }) {
    return GameState(
      pet: pet ?? this.pet,
      coins: coins ?? this.coins,
      upgrades: upgrades ?? this.upgrades,
    );
  }
}

final _initialUpgrades = [
  const Upgrade(
    id: 'food',
    name: '맛있는 음식',
    category: UpgradeCategory.food,
    cost: kFoodUpgradeCost,
    incomePerSecond: kFoodUpgradeIncome,
    tapBonus: kFoodUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'toy',
    name: '재미있는 장난감',
    category: UpgradeCategory.toy,
    cost: kToyUpgradeCost,
    incomePerSecond: kToyUpgradeIncome,
    tapBonus: kToyUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'house',
    name: '아늑한 집',
    category: UpgradeCategory.house,
    cost: kHouseUpgradeCost,
    incomePerSecond: kHouseUpgradeIncome,
    tapBonus: kHouseUpgradeTapBonus,
  ),
];

class GameNotifier extends Notifier<GameState> {
  Timer? _autoIncomeTimer;

  @override
  GameState build() {
    _startAutoIncome();
    ref.onDispose(() => _autoIncomeTimer?.cancel());

    return GameState(
      pet: Pet.initial('코코'),
      coins: 0.0,
      upgrades: _initialUpgrades,
    );
  }

  void _startAutoIncome() {
    _autoIncomeTimer = Timer.periodic(
      const Duration(milliseconds: kAutoIncomeIntervalMs),
      (_) {
        final income = state.coinsPerSecond * kAutoIncomeIntervalMs / 1000;
        if (income > 0) {
          state = state.copyWith(coins: state.coins + income);
        }
      },
    );
  }

  void tap() {
    state = state.copyWith(coins: state.coins + state.coinsPerTap);
  }

  bool buyUpgrade(String upgradeId) {
    final index = state.upgrades.indexWhere((u) => u.id == upgradeId);
    if (index == -1) return false;

    final upgrade = state.upgrades[index];
    if (state.coins < upgrade.currentCost) return false;

    final updatedUpgrades = List<Upgrade>.from(state.upgrades);
    updatedUpgrades[index] = upgrade.copyWith(count: upgrade.count + 1);

    state = state.copyWith(
      coins: state.coins - upgrade.currentCost,
      upgrades: updatedUpgrades,
    );
    return true;
  }
}

final gameProvider = NotifierProvider<GameNotifier, GameState>(GameNotifier.new);
