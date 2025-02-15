# Technologies & Configuration

## Core Stack
- **Frontend**: React (Next.js v15+)
- **Backend**: Node.js (Server Actions)
- **Automation**: Puppeteer
- **Scripting**: KDE Wayland (KWin scripts)

## Code Quality
- **TypeScript: `strict: true` enabled**
- **ESLint + Prettier for formatting**
- **Vitest for unit tests**

## Caching Strategies
- **Incremental Static Regeneration (ISR)**: Use ISR to update static content without rebuilding the entire site.
- **Server-Side Rendering (SSR)**: Implement SSR for dynamic content that requires frequent updates.
- **Client-Side Caching**: Utilize browser caching and service workers to cache static assets and improve performance.
