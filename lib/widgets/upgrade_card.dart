import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/upgrade.dart';
import '../providers/game_state.dart';

class UpgradeCard extends ConsumerWidget {
  final Upgrade upgrade;

  const UpgradeCard({super.key, required this.upgrade});

  IconData _icon() {
    switch (upgrade.category) {
      case UpgradeCategory.memory:
        return Icons.memory;
      case UpgradeCategory.emotion:
        return Icons.favorite;
      case UpgradeCategory.language:
        return Icons.translate;
      case UpgradeCategory.reasoning:
        return Icons.psychology;
      case UpgradeCategory.creativity:
        return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coins = ref.watch(gameProvider.select((s) => s.coins));
    final canAfford = coins >= upgrade.currentCost;

    return Card(
      child: ListTile(
        leading: Icon(_icon(), size: 32),
        title: Text(upgrade.name),
        subtitle: Text(
          '+${upgrade.tapBonus} 탭  |  +${upgrade.incomePerSecond}/초  |  구매: ${upgrade.count}개',
        ),
        trailing: ElevatedButton(
          onPressed: canAfford
              ? () => ref.read(gameProvider.notifier).buyUpgrade(upgrade.id)
              : null,
          child: Text('${upgrade.currentCost.toStringAsFixed(0)} 코인'),
        ),
      ),
    );
  }
}
