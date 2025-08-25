# Task Management System API

A Ruby on Rails API application for managing tasks with JWT authentication using Devise.

## Features

- User authentication with JWT tokens (no denylist)
- CRUD operations for tasks
- Task status management (pending, in_progress, completed)
- User-specific task isolation
- CORS support for frontend applications

## Getting Started

### Prerequisites
- Ruby 3.x
- PostgreSQL
- Bundler

### Installation

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   rails db:create db:migrate db:seed
   ```

3. Start the server:
   ```bash
   rails server
   ```

The API will be available at `http://localhost:3000`

## API Endpoints

### Authentication

#### Sign Up
```
POST /users
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```

#### Sign In
```
POST /users/sign_in
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123"
  }
}
```

Response includes JWT token in Authorization header.

#### Sign Out
```
DELETE /users/sign_out
Authorization: Bearer YOUR_JWT_TOKEN
```

### Tasks

All task endpoints require authentication. Include the JWT token in the Authorization header:
```
Authorization: Bearer YOUR_JWT_TOKEN
```

#### Get All Tasks
```
GET /api/v1/tasks
```

#### Get Single Task
```
GET /api/v1/tasks/:id
```

#### Create Task
```
POST /api/v1/tasks
Content-Type: application/json

{
  "task": {
    "title": "Complete project",
    "description": "Finish the task management system",
    "status": "pending",
    "due_date": "2024-12-31"
  }
}
```

#### Update Task
```
PATCH/PUT /api/v1/tasks/:id
Content-Type: application/json

{
  "task": {
    "title": "Updated title",
    "description": "Updated description",
    "status": "in_progress",
    "due_date": "2024-12-31"
  }
}
```

#### Delete Task
```
DELETE /api/v1/tasks/:id
```

## Task Status Options

- `pending` - Task not started
- `in_progress` - Task currently being worked on
- `completed` - Task finished

## Task Properties

- `id` - Unique identifier
- `title` - Task title (required, max 100 characters)
- `description` - Task description (optional, max 500 characters)  
- `status` - Task status (required, one of: pending, in_progress, completed)
- `due_date` - Due date (required)
- `overdue` - Boolean indicating if task is past due
- `created_at` - Creation timestamp
- `updated_at` - Last update timestamp

## Example Usage with curl

### 1. Sign up a new user
```bash
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "newuser@example.com",
      "password": "password123",
      "password_confirmation": "password123"
    }
  }'
```

### 2. Sign in and get JWT token
```bash
curl -X POST http://localhost:3000/users/sign_in \
  -H "Content-Type: application/json" \
  -d '{
    "user": {
      "email": "test@example.com",
      "password": "password123"
    }
  }' -v
```

Look for the `Authorization` header in the response, copy the JWT token.

### 3. Use the token to access protected endpoints
```bash
# Get all tasks
curl -X GET http://localhost:3000/api/v1/tasks \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"

# Create a new task
curl -X POST http://localhost:3000/api/v1/tasks \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "task": {
      "title": "New Task",
      "description": "Description of the new task",
      "status": "pending",
      "due_date": "2024-12-31"
    }
  }'
```

## Test Data

The application includes seed data with:
- Test user: `test@example.com` (password: `password123`)
- 4 sample tasks with different statuses

Run `rails db:seed` to create this test data.

## Development

- Models are located in `app/models/`
- Controllers are in `app/controllers/api/v1/`
- Routes are defined in `config/routes.rb`
- Database schema is in `db/schema.rb`

## Configuration

- JWT secret is managed via Rails credentials or uses the app's secret_key_base
- CORS is configured to allow all origins in development (update for production)
- Database configuration is in `config/database.yml`
