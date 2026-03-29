# Pet Raising Game — 진행 상황

## 프로젝트 목적
Flutter 펫 키우기 게임을 만들면서 **Claude Code 설정(.claude/, CLAUDE.md, hooks, settings.json 등)을 직접 익히는 것**이 주 목적.
게임 자체는 토이 프로젝트, 핵심은 Claude Code 활용법 체득.

## 현재 상태
기본 게임 루프 구현 완료 (탭 → 코인, 자동 수익, 업그레이드 3종)

## 완료
- [x] Flutter 프로젝트 생성 (`flutter create pet_raising`)
- [x] `CLAUDE.md` 작성 (프로젝트 지침, 디렉토리 구조, 컨벤션)
- [x] `.claude/settings.json` 설정 (권한, hooks)
- [x] `.claude/hooks/analyze-on-save.sh` (dart 파일 수정 시 자동 analyze)
- [x] `.claude/rules/game-logic.md` (모델/프로바이더 파일 전용 규칙)
- [x] `.claude/commands/new-feature.md` (커스텀 `/new-feature` 명령어)

## 완료 (게임 코드)
- [x] Riverpod 패키지 추가 (`flutter_riverpod 3.3.1`)
- [x] `lib/` 디렉토리 구조 잡기 (models, providers, screens, widgets, utils)
- [x] `Pet` 모델 작성 (`lib/models/pet.dart`)
- [x] `Upgrade` 모델 작성 (`lib/models/upgrade.dart`)
- [x] 상수 파일 작성 (`lib/utils/constants.dart`)
- [x] 기본 게임 루프 구현 (`lib/providers/game_state.dart`) — 탭 수익, 자동 수익 타이머
- [x] 메인 화면 UI (`lib/screens/main_screen.dart`, `lib/widgets/upgrade_card.dart`)

## 다음 할 일
- [ ] 펫 행복도/배고픔 시간에 따른 변화 로직
- [ ] 펫 레벨업 조건 구현
- [ ] 저장/불러오기 (SharedPreferences)
- [ ] 효과음 또는 애니메이션 추가

## 게임 기획
- 장르: 방치형 펫 키우기
- 핵심 루프: 탭 → 코인 획득 → 업그레이드 구매 → 자동 수익 증가
- 상태 관리: Riverpod
