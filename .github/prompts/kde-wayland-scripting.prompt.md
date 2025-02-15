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
