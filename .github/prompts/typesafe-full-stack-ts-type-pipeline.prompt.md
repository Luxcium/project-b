<!--
id: typesafe-full-stack-ts-type-pipeline
version: 1.3
last-updated: 2025-04-19
authors: [luxcium]
tags: [typescript,interface,zod,test,tsdoc,typedoc,type-safety,coverage]
schema: prompt-template-v1
-->

# Prompt: Type-Safe Full‑Stack Implementation Pipeline

## Summary
> End‑to‑end TypeScript module pipeline:  
> • **Types** → **Schemas** → **Implementation** → **Docs** → **Tests** → **Validation**

| Aspect           | Target                         |
|------------------|--------------------------------|
| Coverage         | 100% goal, 80% CI pass         |
| Validation       | Zod `.strict()`                |
| Documentation    | TSDoc only (typedoc compatible)|
| Testing          | Vitest (or Jest)               |
| Style            | PascalCase types, camelCase fn |

---

## Quick Start
1. Copy this file into `.github/prompts/full-stack-ts-type-pipeline.prompt.md`  
2. Invoke in VS Code Copilot Chat with `/new` or `@workspace #file=…`  
3. Provide `{moduleName}`, `{inputType}`, `{outputType}`  

---

## Pipeline Steps

1. **Define Base Types**  
   - `type` or `interface` only (no `enum`/`any`/`unknown`)  
   - File: `src/types/{moduleName}.ts`

2. **Generate Zod Schemas**  
   - One‑to‑one with interfaces  
   - Use `.strict()`, `.passthrough(false)`  
   - File: `src/schemas/{moduleName}.schema.ts`

3. **Implement Logic**  
   - Pure functions / small classes  
   - Inputs validated by Zod or typed  
   - Return `Result<T, E>` or discriminated unions  
   - File: `src/services/{moduleName}.ts`

4. **Add TSDoc Comments**  
   - `/** */` blocks for every export  
   - Tags: `@param`, `@returns`, `@throws`, `@example`

5. **Write Tests**  
   - Unit and integration in `__tests__/` or co‑located `*.test.ts`  
   - Cover success, failure, edge cases  
   - Use `describe` / `it` / `expect`  
   - Enforce coverage: goal 100%, pass ≥ 80%

6. **Validate & Enforce**  
   - `tsconfig.json`: `"strict": true`  
   - Run `vitest --coverage` or `jest --coverage`  
   - Build `typedoc` → no warnings  
   - Ensure Zod rejects invalid shapes

---

## Checklist  
- [ ] `src/types/{moduleName}.ts` exists  
- [ ] `src/schemas/{moduleName}.schema.ts` matches types  
- [ ] `src/services/{moduleName}.ts` pure, typed logic  
- [ ] All exports have TSDoc comments  
- [ ] Tests in place with coverage badge ≥ 80%  
- [ ] CI pipeline validates `tsc`, `vitest --coverage`, `typedoc`

---

## Metadata

### Why  
Guarantee end‑to‑end safety: static types, runtime checks, documented behavior, and automated tests.

### What  
- Fully typed `.ts` code  
- Runtime‑validated schemas  
- Pure logic modules  
- TSDoc‑driven docs  
- Coverage‑enforced tests

### When  
Any new public API, service, or shared utility in your codebase.

### How  
Invoke via Copilot Chat with slash commands (`/tests`, `/doc`, `/fix`), context anchors (`@workspace`, `#file`).

---

## Parameters *(optional)*
- `{moduleName}` — Domain/feature name  
- `{inputType}` — Expected request/input shape  
- `{outputType}` — Return/output shape  

---

## Input Expectations
- **File types:** `.ts`, `.schema.ts`, `.test.ts`  
- **Dependencies:** Zod, Vitest or Jest, TypeScript ≥ 5.4  

---

## Output Requirements
- **Format:** TypeScript + TSDoc + Zod + tests  
- **Constraints:** UTF‑8, strict mode, no enums/any  

---

## Examples

```ts
// src/types/user.ts
export type User = { id: string; email: string; isActive: boolean };