# Project B

## Purpose of the `.github/prompts/` Directory

The `.github/prompts/` directory contains prompt files that define best practices and guidelines for various aspects of the project. These prompt files are used to ensure consistent and high-quality code generation by GitHub Copilot.

### Core Prompt Files

The following core prompt files are included in the `.github/prompts/` directory:

- `typescript-best-practices.prompt.md`
- `nextjs-api-standards.prompt.md`
- `react-component-guidelines.prompt.md`
- `testing-strategies.prompt.md`
- `puppeteer-usage-guidelines.prompt.md`
- `kde-wayland-scripting.prompt.md`

### How to Use Prompt Files

#### Attaching a Prompt in Copilot Chat

1. Open **Copilot Chat** (**`⌃⌘I`** or **`Ctrl+Alt+I`**).
2. Click **Attach Context** (📎).
3. Select **Prompt...** → Choose one of the **`.prompt.md`** files.
4. Enter your request.

**Example**:

```md
@workspace /fix testing
📎 Attached: testing-strategies.prompt.md
```

Copilot will now fix your tests according to **your testing rules**.

#### Using Prompt Files in Copilot Edits

For **multi-file editing**:

1. Open **Copilot Edits** (**`⇧⌘I`** or **`Ctrl+Shift+I`**).
2. Click **Add Files...** → Select the files Copilot should edit.
3. Attach the relevant **`.prompt.md`** files.
4. Describe the edit → Copilot follows the **rules inside the prompt file**.

**Example**:

```md
📎 Attached: nextjs-api-standards.prompt.md
📎 Attached: error-handling-and-logging.prompt.md
```

Copilot will now **refactor API endpoints & apply structured error handling**.

### Automating Prompt File Usage

Instead of manually attaching prompts every time, you can **auto-apply them** in **`.github/copilot-instructions.md`**.

#### `.github/copilot-instructions.md`

```md
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
```

Copilot will now follow these rules automatically.
