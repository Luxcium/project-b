<!--
   id: full-stack-ts-typed-pipeline
   version: 1.1
   last-updated: 2025-04-19
   authors: [luxcium]
   tags: [typescript, interface, zod, test, typedoc, tsdoc, coverage]
   schema: prompt-template-v1
-->

# Prompt: Type-Safe Full Stack Implementation Pipeline

## Description
Guide Copilot through a full pipeline: types → Zod → implementation → docs → tests. Enforces strong typing, clean architecture, runtime validation, and test coverage.

## Instructions
1. **Define Types**
   - Use `type` or `interface`
   - No `enum`, `any`, or `unknown`
   - Group under `types/*.ts`

2. **Zod Schema**
   - Mirror types strictly
   - Export schemas and `.parse()` validators

3. **Implementation**
   - Use typed inputs/outputs
   - Ensure functions are pure and side-effect free
   - Use `Promise<Result<T, E>>` for async

4. **Documentation**
   - Use TSDoc-compliant `/** */`
   - Document parameters, return type, errors, usage

5. **Testing**
   - Use Vitest or Jest
   - Structure: `describe`, `it`, `expect`
   - Include:
     - Unit tests per module
     - Integration tests
     - Mocks for external dependencies
     - Negative and edge cases
   - Target: 100% coverage; CI threshold: 80%
   - All tests under `__tests__/`

6. **Run Coverage**
   - `vitest --coverage` or `jest --coverage`

## Input Expectations
- File types: `.ts`, `.test.ts`, `.md`
- Scope: Full module
- Dependencies: `zod`, `vitest` or `jest`, strict `tsconfig`

## Output Requirements
- Format: TypeScript with TSDoc and tests
- Constraints: No enums, no `any`/`unknown`, UTF-8
- Style: PascalCase types, camelCase functions, kebab-case filenames

## Parameters
- `{moduleName}`: name of the module
- `{inputShape}`: input type (interface or DTO)
- `{outputShape}`: return type (validated, structured)

## Use Cases
- Apply to services, handlers, libraries, or API routes
- Especially for logic with external I/O (user input, DB, network)

## Notes
- Works with Copilot Chat using `@workspace`, `#file`, `#selection`, `/tests`, `/doc`, `/explain`
- Compatible with `.github/copilot-instructions.md` and `.clinerules/`