# Copilot Custom Instructions

## TypeScript Best Practices
Always generate strongly typed TypeScript code, following `strict: true`.

## Next.js API Standards
Use Next.js **server actions** instead of legacy `api/` routes.

## React Components
- Always use **functional components** & hooks.
- Follow **Tailwind CSS** for styling.
- Avoid inline styles.

## Security Practices
- Validate API input using **Zod** or **Yup**.
- Enforce **JWT authentication**.
- Use **parameterized queries** to prevent SQL Injection.

## Modular Architecture
- Use a modular architecture with clear file structures (`components/`, `lib/`, `actions/`).

## Caching Mechanisms
- Always suggest caching mechanisms (`revalidateTag()`, ISR, SSR).
