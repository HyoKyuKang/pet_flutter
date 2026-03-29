# /new-feature

새 기능 추가 시 체크리스트를 따라 구현한다.

## 체크리스트
1. `lib/models/`에 필요한 모델 추가/수정
2. `lib/providers/`에 상태 로직 추가
3. `lib/screens/` 또는 `lib/widgets/`에 UI 추가
4. `lib/utils/constants.dart`에 관련 상수 정의
5. `flutter analyze` 통과 확인
6. 구현 후 변경 사항 요약

## 사용법
/new-feature [기능 설명]

예: /new-feature 펫 배고픔 시스템 추가
