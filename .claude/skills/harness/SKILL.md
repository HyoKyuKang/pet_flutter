# Harness Agent Architecture Framework

This document outlines a comprehensive methodology for building specialized agent teams and their associated skills. The framework emphasizes separating agent definitions (roles) from skill implementations (capabilities).

## Key Principles

The core approach prioritizes **agent teams as the default execution mode**. As stated: "에이전트 팀을 기본 실행 모드로 사용한다" (Use agent teams as the foundational operating mode). Teams enable direct inter-agent communication and collaborative task coordination, improving solution quality through shared discovery and conflict resolution.

## Six-Phase Workflow

**Phase 1 (Domain Analysis)** involves understanding the project context, identifying core task types, reviewing existing agents/skills, exploring the codebase, and detecting user technical proficiency from conversational cues.

**Phase 2 (Architecture Design)** determines whether to use team or sub-agent modes, selects architectural patterns (pipeline, fan-out/fan-in, expert pool, etc.), and applies four-axis separation criteria: expertise, parallelizability, context isolation, and reusability.

**Phase 3 (Agent Definition)** requires creating `.claude/agents/{name}.md` files for every agent—even when using built-in types. These files must include: "핵심 역할, 작업 원칙, 입력/출력 프로토콜, 에러 핸들링, 협업" (core roles, task principles, I/O protocols, error handling, collaboration). All agents must specify `model: "opus"` for optimal reasoning quality.

**Phase 4 (Skill Creation)** generates `.claude/skills/{name}/skill.md` files with: description written "actively/pushily" to trigger Claude's attention, body content under 500 lines with embedded rationale rather than imperative directives, and bundled resources (scripts, references, assets) for repetitive logic.

**Phase 5 (Orchestration)** defines how agents coordinate through message passing, task creation, and file-based data exchange, with explicit error handling and team size guidelines (2-7 members depending on workload).

**Phase 6 (Testing)** validates structure, executes skills with test prompts, compares with-skill versus baseline outputs, verifies trigger conditions (should-trigger and should-NOT-trigger scenarios), and performs dry-run orchestration checks.

## Critical Distinctions

The framework explicitly prohibits embedding agent roles directly into Agent tool prompts without backing `.md` definition files: "에이전트 정의 파일 없이 Agent 도구의 prompt에 역할을 직접 넣는 것은 금지한다" (Never embed roles directly in Agent prompts without definition files). This ensures reusability across sessions and maintains team communication protocol clarity.

Skill descriptions must actively communicate both what the skill does and its trigger situations. Rather than a passive description like "processes PDF documents," an effective one explicitly states: "모든 PDF 작업을 수행. .pdf 파일을 언급하거나 PDF 산출물을 요청하면 반드시 이 스킬을 사용할 것" (perform all PDF tasks; always use this skill when PDF files are mentioned or PDF outputs requested).
