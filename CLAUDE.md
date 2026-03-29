# Pet Raising Game — Claude 지침

## 프로젝트 개요
Flutter로 만드는 방치형 펫 키우기 게임.
탭으로 포인트 획득 → 업그레이드 구매 → 자동 수집으로 방치 가능한 구조.

## 빌드 & 실행 명령어
- `flutter run -d windows` — Windows 실행
- `flutter run` — 연결된 기기/에뮬레이터 실행
- `flutter test` — 테스트 실행
- `flutter analyze` — 정적 분석
- `flutter pub get` — 패키지 설치

## 디렉토리 구조
```
lib/
├── main.dart              # 앱 진입점
├── models/                # 데이터 모델 (Pet, Upgrade 등)
├── providers/             # 상태 관리 (Riverpod)
├── screens/               # 화면 단위 위젯
├── widgets/               # 재사용 위젯
└── utils/                 # 상수, 헬퍼 함수
```

## 코딩 컨벤션
- 상태 관리: Riverpod 사용
- 파일명: snake_case (예: `pet_model.dart`)
- 클래스명: PascalCase (예: `PetModel`)
- 변수/함수명: camelCase
- const 위젯 적극 활용
- 위젯 분리 기준: 100줄 이상이면 별도 파일로

## 게임 구조
- **Pet**: 이름, 레벨, 행복도, 배고픔 상태를 가짐
- **탭 수익**: 기본 1 코인/탭, 업그레이드로 증가
- **자동 수익**: 업그레이드 구매 시 초당 코인 자동 획득
- **업그레이드**: 음식, 장난감, 집 등 카테고리

## 주의사항
- `flutter analyze` 경고 없이 유지
- 불필요한 StatefulWidget 지양, Riverpod으로 상태 관리
- 하드코딩 숫자는 `lib/utils/constants.dart`에 상수로 정의

## 서브에이전트 사용 기준
- 파일 3개 이상 탐색이 필요한 경우 → Explore 에이전트에 위임
- 코드베이스 전체 검색 → 반드시 에이전트에 위임 (컨텍스트 보호)
- 구현과 무관한 정보 조사(라이브러리, 문서 등) → general-purpose 에이전트
- 단순 파일 1~2개 읽기/수정 → 직접 처리

## 기능 개발 워크플로우
새 기능, 여러 파일 수정이 필요한 큰 작업은 아래 순서로 에이전트를 직접 호출한다.
오케스트레이터 에이전트에 위임하지 않고, 내(Claude)가 직접 각 단계를 순서대로 호출한다.

1. **flutter-architect** 호출 → 설계안을 `_workspace/architecture-plan.md`에 저장
2. **flutter-implementer** 호출 → `_workspace/architecture-plan.md` 읽고 코드 구현
3. **flutter-reviewer** 호출 → 구현 결과 검증 및 `flutter analyze` 통과 확인

각 단계가 완료되면 `_workspace/workflow-log.md`에 아래 형식으로 기록한다:
```
## {날짜} {작업명}
| 단계 | 에이전트 | 상태 | 산출물 |
|------|----------|------|--------|
| 설계 | flutter-architect | ✅/❌ | 파일명 |
| 구현 | flutter-implementer | ✅/❌ | 변경 파일 목록 |
| 검증 | flutter-reviewer | ✅/❌ | analyze 결과 |
```

## 작업 완료 보고
모든 작업이 끝나면 반드시 아래 형식으로 사용자에게 보고한다:

**직접 처리한 경우:**
> 처리 방식: 직접 처리 / 변경 파일: xxx.dart 외 N개 / flutter analyze: ✅

**에이전트 파이프라인을 사용한 경우:**
> 처리 방식: 에이전트 파이프라인 (architect → implementer → reviewer)
> 각 단계 결과: 설계 ✅ / 구현 ✅ / 검증 ✅
> 변경 파일: xxx.dart 외 N개 / flutter analyze: ✅
