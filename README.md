# Talenthub

Talenthub is a simple Ruby on Rails application for managing companies, employees and user accounts. It demonstrates authentication, role based authorization and background jobs.

## Tech Stack

- **Ruby** 3.3
- **Rails** 8.0.2
- **PostgreSQL** database
- **Redis** for caching and job queues
- **Devise** for user authentication
- **Rolify** for role management
- **Pundit** for authorization policies
- **Solid Queue/Cache/Cable** for background jobs, caching and Action Cable
- **Propshaft** asset pipeline
- **Puma** and **Thruster** for the web server

## Features

- Sign up and login using Devise
- Admin and regular user roles
- Authorization rules with Pundit
- Manage `Company` and `Employee` records
- Background jobs powered by Solid Queue

## Getting Started

1. Install dependencies:
   ```bash
   bundle install
   yarn install # if using Node dependencies
   ```
2. Set up the database and seed an admin account:
   ```bash
   bin/rails db:setup
   bin/rails db:seed
   ```
3. Start the development server:
   ```bash
   bin/dev
   ```
   Or use Docker:
   ```bash
   docker-compose up
   ```

## Running Tests

RSpec is used for the test suite. Run all specs with:

```bash
bin/rspec
```

## Code Style

Rubocop is configured via `rubocop-rails-omakase`. To check the code style run:

```bash
bin/rubocop
```

## Project Usage

After starting the server, visit `http://localhost:3000` to sign up or log in. An admin user created from the seed file can view all users, while regular users can only view their own profile.

Employees belong to companies and users. The admin can manage these records using standard Rails CRUD actions (controllers can be extended as needed).

```

```
