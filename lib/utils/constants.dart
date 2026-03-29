// 게임 수치 상수
const int kBaseCoinsPerTap = 1;
const double kBaseCoinsPerSecond = 0.0;

// 펫 상태 범위
const int kMaxHappiness = 100;
const int kMinHappiness = 0;
const int kMaxHunger = 100;
const int kMinHunger = 0;

// 펫 초기값
const int kInitialHappiness = 80;
const int kInitialHunger = 20;
const int kInitialLevel = 1;

// 업그레이드 비용
const double kFoodUpgradeCost = 10.0;
const double kToyUpgradeCost = 25.0;
const double kHouseUpgradeCost = 50.0;

// 업그레이드 수익 증가량 (초당 코인)
const double kFoodUpgradeIncome = 0.5;
const double kToyUpgradeIncome = 1.5;
const double kHouseUpgradeIncome = 4.0;

// 탭당 코인 증가량
const int kFoodUpgradeTapBonus = 1;
const int kToyUpgradeTapBonus = 2;
const int kHouseUpgradeTapBonus = 5;

// 자동 수익 타이머 간격 (밀리초)
const int kAutoIncomeIntervalMs = 100;
