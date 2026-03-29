# Pet Raising Game — 진행 상황

## 프로젝트 목적
Flutter 펫 키우기 게임을 만들면서 **Claude Code 설정(.claude/, CLAUDE.md, hooks, settings.json 등)을 직접 익히는 것**이 주 목적.
게임 자체는 토이 프로젝트, 핵심은 Claude Code 활용법 체득.

## 현재 상태
기본 게임 루프 + 저장/불러오기 구현 완료. Claude Code 하네스 설정 완성.

## 완료 — Claude Code 설정
- [x] `CLAUDE.md` 작성 (프로젝트 지침, 디렉토리 구조, 컨벤션)
- [x] `.claude/settings.json` 설정 (권한, hooks, Write/Edit 허용)
- [x] `.claude/hooks/analyze-on-save.sh` (dart 파일 수정 시 자동 analyze + exit code 반환)
- [x] `.claude/rules/game-logic.md` (모델/프로바이더 파일 전용 규칙)
- [x] `.claude/commands/new-feature.md` (커스텀 `/new-feature` 명령어)
- [x] `.claude/commands/review.md` (커스텀 `/review` 명령어)
- [x] `.claude/commands/fix-analyze.md` (커스텀 `/fix-analyze` 명령어)
- [x] `.claude/agents/flutter-architect.md` (설계 전문 에이전트)
- [x] `.claude/agents/flutter-implementer.md` (구현 전문 에이전트)
- [x] `.claude/agents/flutter-reviewer.md` (리뷰/검증 전문 에이전트)
- [x] `.claude/skills/harness/` (Harness 멀티에이전트 프레임워크 설치)
- [x] `CLAUDE.md` 기능 개발 워크플로우 지침 추가 (Claude가 직접 파이프라인 실행)
- [x] `CLAUDE.md` 작업 완료 보고 형식 추가

## 완료 — 게임 코드
- [x] Flutter 프로젝트 생성 + Riverpod 패키지 추가
- [x] `lib/` 디렉토리 구조 (models, providers, screens, widgets, utils)
- [x] `Pet` 모델, `Upgrade` 모델
- [x] `lib/utils/constants.dart` 상수 파일
- [x] 기본 게임 루프 (`game_state.dart`) — 탭 수익, 자동 수익 타이머
- [x] 메인 화면 UI (`main_screen.dart`, `upgrade_card.dart`)
- [x] 저장/불러오기 (`save_manager.dart`) — SharedPreferences, 자동 저장/불러오기

## 다음 할 일
- [ ] 펫 행복도/배고픔 시간에 따른 변화 로직
- [ ] 펫 레벨업 조건 구현
- [ ] 효과음 또는 애니메이션 추가
