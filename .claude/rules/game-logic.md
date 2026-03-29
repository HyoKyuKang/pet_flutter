---
paths:
  - "lib/models/**/*.dart"
  - "lib/providers/**/*.dart"
---

# 게임 로직 규칙

## 수치 밸런스
- 초기 탭당 코인: 1
- 업그레이드 가격: 이전 가격 × 1.5 (복리)
- 자동 수익은 `lib/utils/constants.dart`의 상수 사용

## 모델 규칙
- 모든 모델은 `freezed` 또는 immutable하게 작성
- copyWith 패턴 사용
- JSON 직렬화 필요 시 `json_serializable` 사용

## Provider 규칙
- 사이드이펙트(저장, 타이머)는 Provider 안에서만
- UI에서 직접 비즈니스 로직 작성 금지
