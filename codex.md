# Project AI Collaboration Instructions

## Purpose
This file contains instructions to ensure smooth collaboration among the user, Codex CLI AI, GitHub Copilot, and cline AI agent in VSCode.

## Collaboration Goals
- Maintain state and memory synchronization across sessions and tools.
- Use the cline tool's memory-bank to share state and context where possible.
- Log interactions and updates clearly to preserve context and preferences.
- Align coding styles, tooling configurations, and user preferences across AI agents.

## Logging and State Management
- All AI interactions should be logged where possible.
- Use the memory-bank as a shared repository of session context.
- Update instructions dynamically as user preferences evolve.
- Keep session continuity by referencing previous logs and memory when possible.

## General Guidelines
- Respect existing project coding guidelines and styles.
- Collaborate transparently, ask for clarifications if unsure.
- Keep changes minimal and focused, with clear Git history.
- Prioritize safety and security in code suggestions and edits.

## Specific Considerations for GitHub Copilot
- Follow best practice prompt files if provided in .
- Respect project-specific rules set in  and .

## Specific Considerations for cline AI Agent (VSCode)
- Synchronize memory-bank usage with Codex CLI.
- Share updates to instructions and state through project-scoped files.

---

*End of instructions*
