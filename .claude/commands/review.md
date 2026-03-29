# /review

현재 변경된 코드를 리뷰한다.

## 절차
1. `git diff` 또는 최근 수정 파일을 확인한다
2. Explore 에이전트를 사용해 연관 파일을 함께 분석한다
3. 아래 기준으로 리뷰한다:
   - CLAUDE.md 컨벤션 준수 여부 (snake_case, PascalCase, camelCase)
   - `lib/utils/constants.dart` 상수 사용 여부 (하드코딩 숫자 금지)
   - Riverpod 규칙 준수 (UI에 비즈니스 로직 없는지)
   - const 위젯 활용 여부
   - `flutter analyze` 통과 가능 여부
4. 문제 발견 시 파일명:라인번호 형식으로 명시한다
5. 심각도를 구분한다: 🔴 오류 / 🟡 경고 / 🟢 제안

## 사용법
/review
/review [특정 파일 또는 기능명]
