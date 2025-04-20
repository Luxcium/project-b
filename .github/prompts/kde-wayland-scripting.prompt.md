<!-- 
  id: kde-wayland-scripting-guidelines
  version: 1.0
  last-updated: 2025-04-19
  authors: [luxcium]
  tags: [kde,wayland,scripting,plasma]
  schema: prompt-template-v1
-->


# KDE Wayland Scripting Guidelines

## Guidelines:
- **DO NOT use X11 dependencies**—only **Wayland-compatible** scripts.
- Prefer **KWin scripting API** for managing windows.
- Use **Plasma Shell widgets** for automation.
- Avoid modifying core KDE components—use **extensions instead**.

## Example:
```js
const ws = workspace;
ws.clientList().forEach(client => {
  if (client.windowClass === "firefox") {
    client.minimized = true;
  }
});
```
