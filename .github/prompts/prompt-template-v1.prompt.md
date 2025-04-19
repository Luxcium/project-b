<!--
id: {slug}                     # unique identifier (kebab-case)
version: 1.0                   # template schema version
last-updated: {YYYY-MM-DD}     # ISO date
authors: [your-name]           # attribution
tags: [<category>,<task>]      # for discovery
schema: prompt-template-v1     # required
-->

# Prompt: {Title}

## Description
Short summary of what this prompt does and when to use it.

## Instructions
- Step‑by‑step directives for the AI agent.
- No assumptions: specify all conditions explicitly.
- Edge‑case handling and constraints.

## Why *(optional)*
- Purpose and motivation: what problem this solves or goal it achieves.

## What *(optional)*
- Task summary and deliverable.
- Output type (e.g., refactored code, architecture plan, docs).

## When *(optional)*
- Timing or trigger conditions (e.g., “after scaffold,” “on test failure”).

## How *(optional)*
- High‑level approach or methodology.
- Patterns, tools, or frameworks to employ.

## Input Expectations
- **File types:** `.ts`, `.tsx`, `.md`, etc.  
- **Scope:** function / component / module / codebase  
- **Dependencies:** required context (#codebase, linked files)

## Output Requirements
- **Format:** Markdown / fenced code block / JSON  
- **Constraints:** type safety, UTF‑8, no enums  
- **Style:** tabs vs. spaces, naming conventions

## Examples
### Input
```ts
// your example input here