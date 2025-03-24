#!/bin/bash

# Define the project name and subfolder
PROJECT_NAME="my-nextjs-app"
SUBFOLDER="subfolder"

# Create the project using npx create-next-app with the -y flag to auto-confirm
npm i -g create-next-app@latest
npx create-next-app@latest $SUBFOLDER/$PROJECT_NAME --ts --eslint --src-dir --tailwind --use-npm -y

# Navigate to the project directory
cd $SUBFOLDER/$PROJECT_NAME

# Update tsconfig.json to enforce strict type checking
jq '.compilerOptions.strict = true' tsconfig.json > tsconfig.tmp.json && mv tsconfig.tmp.json tsconfig.json

# Install additional dependencies
npm install zod jsonwebtoken

# Create a sample server action with input validation and JWT authentication
mkdir -p src/actions
cat <<EOL > src/actions/exampleAction.ts
import { z } from 'zod';
import jwt from 'jsonwebtoken';

const inputSchema = z.object({
  name: z.string(),
});

export async function exampleAction(input: unknown): Promise<{ message: string }> {
  const { name } = inputSchema.parse(input);

  // Validate JWT (example, replace with your secret and logic)
  const token = ''; // Replace with actual token
  jwt.verify(token, 'your-secret-key');

  // Your action logic here
  return { message: \`Hello, \${name}!\` };
}
EOL

# Create a sample component using Tailwind CSS
mkdir -p src/components
cat <<EOL > src/components/ExampleComponent.tsx
import React from 'react';

interface ExampleComponentProps {
  message: string;
}

const ExampleComponent: React.FC<ExampleComponentProps> = ({ message }) => {
  return (
    <div className="p-4 bg-blue-500 text-white">
      {message}
    </div>
  );
};

export default ExampleComponent;
EOL

# Create a sample page that uses the server action and component
mkdir -p src/app
cat <<EOL > src/app/page.tsx
import React from 'react';
import { exampleAction } from '../actions/exampleAction';
import ExampleComponent from '../components/ExampleComponent';

const HomePage: React.FC = async () => {
  const data = await exampleAction({ name: 'World' });

  return (
    <div className="container mx-auto">
      <ExampleComponent message={data.message} />
    </div>
  );
};

export default HomePage;
EOL

echo "Next.js project created successfully in $SUBFOLDER/$PROJECT_NAME"