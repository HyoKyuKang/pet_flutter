import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_state.dart';
import '../screens/stage_up_screen.dart';
import '../widgets/ai_avatar.dart';
import '../widgets/coin_display.dart';
import '../widgets/dialogue_bubble.dart';
import '../widgets/growth_progress.dart';
import '../widgets/upgrade_card.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  bool _animateAvatar = false;

  void _onTap() {
    ref.read(gameProvider.notifier).tap();
    setState(() => _animateAvatar = true);
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _animateAvatar = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameProvider);
    final ai = state.ai;

    return Scaffold(
      appBar: AppBar(
        title: Text('${ai.name} 키우기'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const CoinDisplay(),
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: _onTap,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AiAvatar(
                            stage: ai.stage,
                            animate: _animateAvatar,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ai.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          DialogueBubble(text: state.currentDialogue),
                          const SizedBox(height: 8),
                          GrowthProgress(ai: ai),
                          const SizedBox(height: 16),
                          const Text(
                            '탭해서 대화하기',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
          if (state.showStageUpEffect) const StageUpScreen(),
        ],
      ),
    );
  }
}
