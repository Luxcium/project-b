const fs = require('fs');
const path = require('path');

const promptsDir = path.join(__dirname, '../.github/prompts');

const promptFiles = [
  'typescript-best-practices.prompt.md',
  'nextjs-api-standards.prompt.md',
  'react-component-guidelines.prompt.md',
  'testing-strategies.prompt.md',
  'puppeteer-usage-guidelines.prompt.md',
  'kde-wayland-scripting.prompt.md'
];

function updatePromptFiles() {
  promptFiles.forEach(file => {
    const filePath = path.join(promptsDir, file);
    if (fs.existsSync(filePath)) {
      const content = fs.readFileSync(filePath, 'utf-8');
      const updatedContent = content.replace(/<!--.*?-->/gs, ''); // Remove HTML comments
      fs.writeFileSync(filePath, updatedContent, 'utf-8');
      console.log(`Updated: ${file}`);
    } else {
      console.log(`File not found: ${file}`);
    }
  });
}

updatePromptFiles();
