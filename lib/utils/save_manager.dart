import 'package:shared_preferences/shared_preferences.dart';
import '../models/upgrade.dart';

/// SharedPreferences 기반 저장/불러오기 관리자.
/// 저장 항목: 코인, 업그레이드별 구매 횟수.
class SaveManager {
  static const _keyCoins = 'coins';
  static const _keyUpgradePrefix = 'upgrade_count_';

  final SharedPreferences _prefs;

  SaveManager(this._prefs);

  /// SharedPreferences 인스턴스를 초기화하고 SaveManager를 생성한다.
  static Future<SaveManager> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SaveManager(prefs);
  }

  /// 코인과 업그레이드 구매 횟수를 저장한다.
  Future<void> save({
    required double coins,
    required List<Upgrade> upgrades,
  }) async {
    await _prefs.setDouble(_keyCoins, coins);
    for (final upgrade in upgrades) {
      await _prefs.setInt('$_keyUpgradePrefix${upgrade.id}', upgrade.count);
    }
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
