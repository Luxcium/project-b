# React Component Guidelines

## Guidelines:
- **Use functional components & hooks** (NO class components).
- Use **Tailwind CSS** for styling.
- Props should be **typed explicitly**.
- Avoid inline styles—use Tailwind classes or `styled-components`.
- Always destructure props.

## Example:
```tsx
interface ButtonProps {
  text: string;
  onClick: () => void;
}

export function Button({ text, onClick }: ButtonProps) {
  return <button onClick={onClick} className="bg-blue-500 text-white">{text}</button>;
}
```
