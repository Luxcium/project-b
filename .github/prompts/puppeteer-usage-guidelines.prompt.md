# Puppeteer Usage Guidelines

## Guidelines:
- **Reuse browser instances**—DO NOT launch multiple instances per request.
- Always **close pages after usage** to prevent memory leaks.
- Use **`page.waitForSelector()`** before interacting with elements.
- Prefer **headless mode** unless debugging.

## Example:
```ts
const puppeteer = require("puppeteer");

async function scrapeData() {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();

  await page.goto("https://example.com");
  const title = await page.title();

  await page.close();
  await browser.close();

  return title;
}
```
