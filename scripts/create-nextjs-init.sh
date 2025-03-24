#!/bin/bash

# Exit on any error
set -e

# Function to handle errors
handle_error() {
  echo "Error occurred at line $1, exiting..."
  exit 1
}

# Set error handler
trap 'handle_error $LINENO' ERR

# Define the project name and subfolder
PROJECT_NAME="my-nextjs-app"
SUBFOLDER="subfolder"

echo "Starting Next.js project initialization..."

# Ensure the subfolder exists
mkdir -p "$SUBFOLDER"

# Create the project using npx create-next-app with all options to prevent prompts
echo "Creating Next.js project..."
npx --yes create-next-app@latest "$SUBFOLDER/$PROJECT_NAME" \
  --ts \
  --tailwind \
  --eslint \
  --src-dir \
  --app \
  --no-experimental-app \
  --import-alias "@/*" \
  --use-npm

# Navigate to the project directory
cd "$SUBFOLDER/$PROJECT_NAME" || handle_error $LINENO

# Update tsconfig.json to enforce strict type checking
echo "Updating TypeScript configuration for strict mode..."
if command -v jq >/dev/null 2>&1; then
  jq '.compilerOptions.strict = true | .compilerOptions.noUncheckedIndexedAccess = true' tsconfig.json > tsconfig.tmp.json && mv tsconfig.tmp.json tsconfig.json
else
  # Fallback if jq is not available
  sed -i 's/"strict": false/"strict": true/g' tsconfig.json
  sed -i 's/"noUncheckedIndexedAccess": false/"noUncheckedIndexedAccess": true/g' tsconfig.json
fi

# Install additional dependencies
echo "Installing additional dependencies..."
npm install zod jsonwebtoken @types/jsonwebtoken next-auth swr react-query

# Create proper directory structure for modular architecture
echo "Creating modular architecture directories..."
mkdir -p src/{actions,components,lib,types,hooks}

# Create a utility for JWT validation
echo "Creating security utilities..."
mkdir -p src/lib/auth
cat <<EOL > src/lib/auth/jwt.ts
import jwt from 'jsonwebtoken';
import { z } from 'zod';

export const JWT_SECRET = process.env.JWT_SECRET || 'development-secret-key';

export interface JWTPayload {
  userId: string;
  email: string;
  role: string;
}

const JWTSchema = z.object({
  userId: z.string(),
  email: z.string().email(),
  role: z.string(),
});

export function verifyToken(token: string): JWTPayload {
  try {
    const decoded = jwt.verify(token, JWT_SECRET) as unknown;
    return JWTSchema.parse(decoded);
  } catch (error) {
    throw new Error('Invalid or expired JWT token');
  }
}

export function generateToken(payload: JWTPayload): string {
  return jwt.sign(payload, JWT_SECRET, { expiresIn: '1d' });
}
EOL

# Create a sample server action with validation, authentication, and caching
echo "Creating server actions with validation and auth..."
cat <<EOL > src/actions/exampleAction.ts
'use server';

import { revalidateTag } from 'next/cache';
import { z } from 'zod';
import { verifyToken, JWTPayload } from '../lib/auth/jwt';
import { cookies } from 'next/headers';

// Input validation schema
const inputSchema = z.object({
  name: z.string().min(1).max(100),
});

// Output type
export interface ActionResponse {
  message: string;
  timestamp: number;
}

// Define the cache tag
const CACHE_TAG = 'example-data';

/**
 * Example server action with input validation, JWT auth, and cache revalidation
 */
export async function exampleAction(
  input: unknown,
  authToken?: string
): Promise<ActionResponse> {
  // 1. Validate input
  const validatedInput = inputSchema.parse(input);
  const { name } = validatedInput;
  
  // 2. Authenticate request
  let user: JWTPayload;
  try {
    // Get token from parameter or cookies
    const token = authToken || cookies().get('auth-token')?.value;
    if (!token) {
      throw new Error('Authentication required');
    }
    user = verifyToken(token);
  } catch (error) {
    throw new Error('Authentication failed: ' + (error instanceof Error ? error.message : 'Unknown error'));
  }
  
  // 3. Perform action logic
  // Using parameterized values to prevent injection
  const result = {
    message: \`Hello, \${name}! You are authenticated as \${user.email}\`,
    timestamp: Date.now(),
  };
  
  // 4. Revalidate cache
  revalidateTag(CACHE_TAG);
  
  return result;
}
EOL

# Create a sample component using Tailwind CSS
echo "Creating React components..."
cat <<EOL > src/components/ExampleComponent.tsx
import React from 'react';

interface ExampleComponentProps {
  message: string;
  isLoading?: boolean;
  error?: string;
}

/**
 * Example component with Tailwind styling and proper prop typing
 */
const ExampleComponent: React.FC<ExampleComponentProps> = ({ 
  message, 
  isLoading = false,
  error
}) => {
  return (
    <div className="p-6 bg-white shadow-md rounded-lg">
      {isLoading ? (
        <div className="animate-pulse h-4 bg-gray-200 rounded w-3/4"></div>
      ) : error ? (
        <div className="text-red-500 p-2 border border-red-200 rounded bg-red-50">
          {error}
        </div>
      ) : (
        <div className="text-gray-800 font-medium">
          {message}
        </div>
      )}
    </div>
  );
};

export default ExampleComponent;
EOL

# Create a custom hook for client-side data fetching
echo "Creating custom hooks for data fetching..."
cat <<EOL > src/hooks/useExampleData.ts
'use client';

import { useState, useEffect } from 'react';
import { exampleAction } from '../actions/exampleAction';
import type { ActionResponse } from '../actions/exampleAction';

export function useExampleData(name: string) {
  const [data, setData] = useState<ActionResponse | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setIsLoading(true);
        const result = await exampleAction({ name });
        setData(result);
        setError(null);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An unknown error occurred');
      } finally {
        setIsLoading(false);
      }
    };

    fetchData();
  }, [name]);

  return { data, isLoading, error };
}
EOL

# Create a sample page with server component
echo "Creating server component page..."
cat <<EOL > src/app/page.tsx
import { Suspense } from 'react';
import ExampleComponent from '../components/ExampleComponent';
import { exampleAction } from '../actions/exampleAction';

/**
 * Home page using server components and server actions
 */
export default async function HomePage() {
  // Example of fetching data in a server component
  let message = 'Loading...';
  let error = null;
  
  try {
    // Next.js will handle caching this fetch automatically
    const data = await exampleAction({ name: 'World' }, 'demo-token');
    message = data.message;
  } catch (err) {
    error = err instanceof Error ? err.message : 'Failed to fetch data';
    console.error('Error fetching data:', error);
  }
  
  return (
    <main className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">Next.js with TypeScript</h1>
      <Suspense fallback={<ExampleComponent message="" isLoading={true} />}>
        {error ? (
          <ExampleComponent message="" error={error} />
        ) : (
          <ExampleComponent message={message} />
        )}
      </Suspense>
    </main>
  );
}
EOL

# Create a client component example
echo "Creating client component example..."
cat <<EOL > src/components/ClientExample.tsx
'use client';

import React, { useState } from 'react';
import { useExampleData } from '../hooks/useExampleData';
import ExampleComponent from './ExampleComponent';

/**
 * Client component with state management
 */
export default function ClientExample() {
  const [name, setName] = useState('Client');
  const { data, isLoading, error } = useExampleData(name);
  
  return (
    <div className="my-6">
      <div className="mb-4">
        <label htmlFor="name" className="block text-sm font-medium text-gray-700">Your name:</label>
        <input
          type="text"
          id="name"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"
        />
      </div>
      
      <ExampleComponent 
        message={data?.message || ''} 
        isLoading={isLoading}
        error={error || undefined}
      />
    </div>
  );
}
EOL

# Create environment variables file with security considerations
echo "Setting up environment variables..."
cat <<EOL > .env.local
# Security keys (in production, these should be set in the deployment environment)
JWT_SECRET=local-development-secret-not-for-production
NODE_ENV=development

# API URLs
NEXT_PUBLIC_API_URL=http://localhost:3000

# Feature flags
NEXT_PUBLIC_ENABLE_ANALYTICS=false
EOL

# Add .env.local to .gitignore
echo ".env.local" >> .gitignore

# Create a README with best practices
echo "Creating project documentation..."
cat <<EOL > README.md
# Next.js TypeScript Project

This project follows modern Next.js and TypeScript best practices:

## Features

- ✅ Strongly typed TypeScript with strict mode
- ✅ Next.js App Router and Server Components
- ✅ Server Actions for data mutations
- ✅ Zod for input validation
- ✅ JWT authentication
- ✅ Tailwind CSS for styling
- ✅ Modular architecture
- ✅ Caching mechanisms

## Getting Started

\`\`\`bash
npm install
npm run dev
\`\`\`

## Security Best Practices

- All API inputs are validated with Zod
- JWT authentication is implemented for protected routes
- Environment variables are used for secrets
- Strict TypeScript mode prevents common bugs
EOL

echo "✅ Next.js project created successfully in $SUBFOLDER/$PROJECT_NAME"
echo "📚 Review the README.md file for best practices and documentation"
echo "🚀 To start the development server:"
echo "cd $SUBFOLDER/$PROJECT_NAME && npm run dev"