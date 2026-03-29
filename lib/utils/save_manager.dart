import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ai_companion.dart';
import '../models/upgrade.dart';

/// SharedPreferences 기반 저장/불러오기 관리자.
class SaveManager {
  static const _keyCoins = 'coins';
  static const _keyUpgradePrefix = 'upgrade_count_';
  static const _keyStage = 'ai_stage';
  static const _keyGrowthPoints = 'ai_growth_points';
  static const _keyTotalInteractions = 'ai_total_interactions';
  static const _keyPersonality = 'ai_personality';
  static const _keyAiName = 'ai_name';

  final SharedPreferences _prefs;

  SaveManager(this._prefs);

  /// SharedPreferences 인스턴스를 초기화하고 SaveManager를 생성한다.
  static Future<SaveManager> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SaveManager(prefs);
  }

  /// 코인, 업그레이드, AI 상태를 저장한다.
  Future<void> save({
    required double coins,
    required List<Upgrade> upgrades,
    required AiCompanion ai,
  }) async {
    await _prefs.setDouble(_keyCoins, coins);
    for (final upgrade in upgrades) {
      await _prefs.setInt('$_keyUpgradePrefix${upgrade.id}', upgrade.count);
    }
    await saveAiState(ai);
  }

  /// AI 상태를 저장한다.
  Future<void> saveAiState(AiCompanion ai) async {
    await _prefs.setInt(_keyStage, ai.stage.index);
    await _prefs.setDouble(_keyGrowthPoints, ai.growthPoints);
    await _prefs.setInt(_keyTotalInteractions, ai.totalInteractions);
    await _prefs.setString(_keyPersonality, jsonEncode(ai.personality));
    await _prefs.setString(_keyAiName, ai.name);
  }

  /// 저장된 AI 상태를 불러온다. 저장 데이터가 없으면 null 반환.
  AiCompanion? loadAiState() {
    if (!_prefs.containsKey(_keyStage)) return null;

    final stageIndex = _prefs.getInt(_keyStage) ?? 0;
    final growthPoints = _prefs.getDouble(_keyGrowthPoints) ?? 0.0;
    final totalInteractions = _prefs.getInt(_keyTotalInteractions) ?? 0;
    final personalityJson = _prefs.getString(_keyPersonality);
    final name = _prefs.getString(_keyAiName) ?? 'AI-001';

    List<String> personality = [];
    if (personalityJson != null) {
      final decoded = jsonDecode(personalityJson);
      if (decoded is List) {
        personality = decoded.cast<String>();
      }
    }

    return AiCompanion(
      name: name,
      stage: GrowthStage.values[stageIndex.clamp(0, GrowthStage.values.length - 1)],
      growthPoints: growthPoints,
      totalInteractions: totalInteractions,
      personality: personality,
    );
  }

  /// 저장된 코인을 불러온다. 저장 데이터가 없으면 null 반환.
  double? loadCoins() {
    return _prefs.getDouble(_keyCoins);
  }

  /// 저장된 업그레이드 구매 횟수를 불러와 기존 업그레이드 목록에 적용한다.
  List<Upgrade> loadUpgrades(List<Upgrade> defaults) {
    return defaults.map((upgrade) {
      final savedCount = _prefs.getInt('$_keyUpgradePrefix${upgrade.id}');
      if (savedCount != null && savedCount > 0) {
        return upgrade.copyWith(count: savedCount);
      }
      return upgrade;
    }).toList();
  }

  /// 저장 데이터가 존재하는지 확인한다.
  bool hasSaveData() {
    return _prefs.containsKey(_keyCoins);
  }
}
