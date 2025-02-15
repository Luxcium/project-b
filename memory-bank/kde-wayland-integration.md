# KDE Wayland Scripting Integration

## Standards
- **Use KWin scripts** for window management.
- Avoid **X11-dependent features**.

## Example KWin Script
```js
const ws = workspace;
ws.clientList().forEach(client => {
  if (client.windowClass === "firefox") {
    client.minimized = true;
  }
});
```
