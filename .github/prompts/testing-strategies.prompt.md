# Testing Strategies

## Guidelines:
- All new functions **must have Jest or Vitest tests**.
- **Use `describe` & `it` blocks** for structuring tests.
- Prefer **mocking API calls** instead of real network requests.
- Ensure **at least 80% test coverage** for critical modules.

## Example:
```ts
import { sum } from "./math";

describe("sum function", () => {
  it("adds two numbers correctly", () => {
    expect(sum(2, 3)).toBe(5);
  });
});
```
