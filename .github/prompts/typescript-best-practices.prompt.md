# TypeScript Best Practices

## Guidelines:
- Always use **`strict: true`** in TypeScript configurations.
- Prefer **const** over **let** unless reassignment is necessary.
- Use **ESM (ECMAScript Modules)**—avoid CommonJS (`require()`).
- When defining objects, **prefer interfaces over types**.
- Enforce **proper error handling**—avoid empty `catch` blocks.
- Use **generics** for reusable functions & classes.

## Example:
```ts
interface User {
  id: number;
  name: string;
}

const fetchUser = async (id: number): Promise<User> => { ... }
```
