#!/bin/bash
# .dart 파일 수정 시 flutter analyze 실행

FILE=$(echo "$CLAUDE_TOOL_INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('file_path',''))" 2>/dev/null)

if [[ "$FILE" == *.dart ]]; then
  echo "=== flutter analyze ==="
  cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

  OUTPUT=$(flutter analyze --no-fatal-infos 2>&1)
  EXIT_CODE=$?

  echo "$OUTPUT" | tail -10

  if [ $EXIT_CODE -ne 0 ]; then
    echo "❌ flutter analyze 실패 (exit $EXIT_CODE) — 위 오류를 수정하세요."
    exit $EXIT_CODE
  else
    echo "✅ flutter analyze 통과"
  fi
fi
