import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_state.dart';
import '../widgets/upgrade_card.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameProvider);
    final pet = state.pet;

    return Scaffold(
      appBar: AppBar(
        title: Text('${pet.name} 키우기'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 코인 표시
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Theme.of(context).colorScheme.primaryContainer,
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  '${state.coins.toStringAsFixed(1)} 코인',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '탭당 ${state.coinsPerTap} | 초당 ${state.coinsPerSecond.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // 펫 탭 영역
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => ref.read(gameProvider.notifier).tap(),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🐾', style: TextStyle(fontSize: 80)),
                      const SizedBox(height: 8),
                      Text(
                        pet.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text('Lv.${pet.level}'),
                      const SizedBox(height: 16),
                      _StatusBar(
                        label: '행복',
                        value: pet.happiness,
                        max: 100,
                        color: Colors.pink,
                      ),
                      const SizedBox(height: 8),
                      _StatusBar(
                        label: '배고픔',
                        value: pet.hunger,
                        max: 100,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '탭해서 코인 획득!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 업그레이드 목록
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.upgrades.length,
              itemBuilder: (context, index) {
                return UpgradeCard(upgrade: state.upgrades[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;

  const _StatusBar({
    required this.label,
    required this.value,
    required this.max,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(label, style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: value / max,
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text('$value', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
