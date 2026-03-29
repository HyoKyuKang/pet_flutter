import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ai_companion.dart';
import '../models/upgrade.dart';
import '../utils/constants.dart';
import '../utils/dialogues.dart';
import '../utils/save_manager.dart';

class GameState {
  final AiCompanion ai;
  final double coins;
  final List<Upgrade> upgrades;
  final String? currentDialogue;
  final bool showStageUpEffect;

  const GameState({
    required this.ai,
    required this.coins,
    required this.upgrades,
    this.currentDialogue,
    this.showStageUpEffect = false,
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
    AiCompanion? ai,
    double? coins,
    List<Upgrade>? upgrades,
    String? Function()? currentDialogue,
    bool? showStageUpEffect,
  }) {
    return GameState(
      ai: ai ?? this.ai,
      coins: coins ?? this.coins,
      upgrades: upgrades ?? this.upgrades,
      currentDialogue:
          currentDialogue != null ? currentDialogue() : this.currentDialogue,
      showStageUpEffect: showStageUpEffect ?? this.showStageUpEffect,
    );
  }
}

final _initialUpgrades = [
  const Upgrade(
    id: 'memory',
    name: '메모리 확장',
    category: UpgradeCategory.memory,
    cost: kMemoryUpgradeCost,
    incomePerSecond: kMemoryUpgradeIncome,
    tapBonus: kMemoryUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'emotion',
    name: '감정 모듈',
    category: UpgradeCategory.emotion,
    cost: kEmotionUpgradeCost,
    incomePerSecond: kEmotionUpgradeIncome,
    tapBonus: kEmotionUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'language',
    name: '언어 능력',
    category: UpgradeCategory.language,
    cost: kLanguageUpgradeCost,
    incomePerSecond: kLanguageUpgradeIncome,
    tapBonus: kLanguageUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'reasoning',
    name: '추론 엔진',
    category: UpgradeCategory.reasoning,
    cost: kReasoningUpgradeCost,
    incomePerSecond: kReasoningUpgradeIncome,
    tapBonus: kReasoningUpgradeTapBonus,
  ),
  const Upgrade(
    id: 'creativity',
    name: '창의성 모듈',
    category: UpgradeCategory.creativity,
    cost: kCreativityUpgradeCost,
    incomePerSecond: kCreativityUpgradeIncome,
    tapBonus: kCreativityUpgradeTapBonus,
  ),
];

/// 성격 키워드 후보 목록 (3단계 진입 시 랜덤 선택)
const _personalityKeywords = [
  '호기심 많은',
  '수줍은',
  '다정한',
  '엉뚱한',
  '차분한',
  '낙천적인',
  '꼼꼼한',
  '용감한',
  '감성적인',
  '장난꾸러기',
];

/// SaveManager를 Provider로 관리하여 GameNotifier에서 접근할 수 있도록 한다.
final saveManagerProvider = Provider<SaveManager>((ref) {
  throw UnimplementedError(
    'saveManagerProvider must be overridden with a real SaveManager instance.',
  );
});

class GameNotifier extends Notifier<GameState> {
  Timer? _autoIncomeTimer;
  Timer? _idleDialogueTimer;
  Timer? _dialogueClearTimer;
  final _random = Random();

  @override
  GameState build() {
    _startAutoIncome();
    _startIdleDialogue();
    ref.onDispose(() {
      _autoIncomeTimer?.cancel();
      _idleDialogueTimer?.cancel();
      _dialogueClearTimer?.cancel();
    });

    final saveManager = ref.read(saveManagerProvider);
    if (saveManager.hasSaveData()) {
      final savedCoins = saveManager.loadCoins() ?? 0.0;
      final savedUpgrades = saveManager.loadUpgrades(_initialUpgrades);
      final savedAi = saveManager.loadAiState();
      return GameState(
        ai: savedAi ?? AiCompanion.initial(),
        coins: savedCoins,
        upgrades: savedUpgrades,
      );
    }

    return GameState(
      ai: AiCompanion.initial(),
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

  void _startIdleDialogue() {
    _idleDialogueTimer = Timer.periodic(
      const Duration(milliseconds: kIdleDialogueIntervalMs),
      (_) {
        final dialogues = kIdleDialogues[state.ai.stage];
        if (dialogues != null && dialogues.isNotEmpty) {
          final text = dialogues[_random.nextInt(dialogues.length)];
          _showDialogue(text);
        }
      },
    );
  }

  void _showDialogue(String text) {
    _dialogueClearTimer?.cancel();
    state = state.copyWith(currentDialogue: () => text);
    _dialogueClearTimer = Timer(
      const Duration(milliseconds: kDialogueDisplayDurationMs),
      () {
        state = state.copyWith(currentDialogue: () => null);
      },
    );
  }

  void tap() {
    final ai = state.ai;
    final newGrowthPoints = ai.growthPoints + kGrowthPerTap;
    final newInteractions = ai.totalInteractions + 1;

    state = state.copyWith(
      coins: state.coins + state.coinsPerTap,
      ai: ai.copyWith(
        growthPoints: newGrowthPoints,
        totalInteractions: newInteractions,
      ),
    );

    _checkStageUp();

    // 탭 반응 대사 표시
    final dialogues = kTapDialogues[state.ai.stage];
    if (dialogues != null && dialogues.isNotEmpty) {
      final text = dialogues[_random.nextInt(dialogues.length)];
      _showDialogue(text);
    }

    _save();
  }

  void _checkStageUp() {
    final ai = state.ai;
    if (!ai.canStageUp) return;

    final newStage = ai.nextStage;
    if (newStage == null) return;

    var updatedAi = ai.copyWith(stage: newStage);

    // 3단계(자아 형성) 진입 시 성격 키워드 생성
    if (newStage == GrowthStage.selfForming && ai.personality.isEmpty) {
      final shuffled = List<String>.from(_personalityKeywords)..shuffle(_random);
      updatedAi = updatedAi.copyWith(personality: shuffled.take(2).toList());
    }

    state = state.copyWith(
      ai: updatedAi,
      showStageUpEffect: true,
    );

    // 단계 전환 대사 표시
    final stageUpText = kStageUpDialogues[newStage];
    if (stageUpText != null) {
      _showDialogue(stageUpText);
    }
  }

  void dismissStageUpEffect() {
    state = state.copyWith(showStageUpEffect: false);
  }

  bool buyUpgrade(String upgradeId) {
    final index = state.upgrades.indexWhere((u) => u.id == upgradeId);
    if (index == -1) return false;

    final upgrade = state.upgrades[index];
    if (state.coins < upgrade.currentCost) return false;

    final updatedUpgrades = List<Upgrade>.from(state.upgrades);
    updatedUpgrades[index] = upgrade.copyWith(count: upgrade.count + 1);

    // 업그레이드 구매 시 성장 포인트 보너스
    final growthBonus = upgrade.currentCost * kGrowthPerCoin;
    final newGrowthPoints = state.ai.growthPoints + growthBonus;

    state = state.copyWith(
      coins: state.coins - upgrade.currentCost,
      upgrades: updatedUpgrades,
      ai: state.ai.copyWith(growthPoints: newGrowthPoints),
    );

    _checkStageUp();

    // 첫 구매 시 마일스톤 대사
    if (upgrade.count == 0) {
      _showDialogue('${upgrade.name}... 새로운 모듈이 설치되었습니다!');
    }

    _save();
    return true;
  }

  /// 현재 상태를 SharedPreferences에 저장한다.
  void _save() {
    ref.read(saveManagerProvider).save(
      coins: state.coins,
      upgrades: state.upgrades,
      ai: state.ai,
    );
  }
}

final gameProvider =
    NotifierProvider<GameNotifier, GameState>(GameNotifier.new);
