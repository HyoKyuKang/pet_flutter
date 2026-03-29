// 게임 수치 상수
const int kBaseCoinsPerTap = 1;
const double kBaseCoinsPerSecond = 0.0;

// 자동 수익 타이머 간격 (밀리초)
const int kAutoIncomeIntervalMs = 100;

// === AI 성장 단계 전환 필요 포인트 ===
const double kStageThreshold0to1 = 100.0;
const double kStageThreshold1to2 = 500.0;
const double kStageThreshold2to3 = 2000.0;
const double kStageThreshold3to4 = 10000.0;

// 성장 포인트 획득량
const double kGrowthPerTap = 1.0;
const double kGrowthPerCoin = 0.1;

// === 업그레이드 비용 (5개 카테고리) ===
const double kMemoryUpgradeCost = 10.0;
const double kEmotionUpgradeCost = 25.0;
const double kLanguageUpgradeCost = 50.0;
const double kReasoningUpgradeCost = 100.0;
const double kCreativityUpgradeCost = 200.0;

// === 업그레이드 수익 (초당 코인) ===
const double kMemoryUpgradeIncome = 0.5;
const double kEmotionUpgradeIncome = 1.5;
const double kLanguageUpgradeIncome = 4.0;
const double kReasoningUpgradeIncome = 8.0;
const double kCreativityUpgradeIncome = 15.0;

// === 탭당 코인 보너스 ===
const int kMemoryUpgradeTapBonus = 1;
const int kEmotionUpgradeTapBonus = 2;
const int kLanguageUpgradeTapBonus = 5;
const int kReasoningUpgradeTapBonus = 10;
const int kCreativityUpgradeTapBonus = 20;

// === 업그레이드 가격 증가 배율 ===
const double kUpgradeCostMultiplier = 1.5;

// === 대화 관련 ===
const int kDialogueDisplayDurationMs = 3000;
const int kIdleDialogueIntervalMs = 15000;
