-- SQL script to initialize the database

-- Create a table named 'users'
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial data into 'users' table
INSERT INTO users (username, email, password) VALUES
('admin', 'admin@example.com', 'adminpassword'),
('user1', 'user1@example.com', 'user1password'),
('user2', 'user2@example.com', 'user2password');
