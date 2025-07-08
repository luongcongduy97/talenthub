# Talenthub

Talenthub is a simple Ruby on Rails application for managing companies, employees and user accounts. It demonstrates authentication, role based authorization and background jobs.

<img width="1352" alt="Screenshot 2025-07-08 at 20 14 26" src="https://github.com/user-attachments/assets/b9594d65-23ad-4c55-86bd-0c039106d0ab" />
<img width="1352" alt="Screenshot 2025-07-08 at 20 14 41" src="https://github.com/user-attachments/assets/42f91ff8-0039-4a51-8253-4a07654feed5" />
<img width="477" alt="Screenshot 2025-07-08 at 20 15 05" src="https://github.com/user-attachments/assets/21539a33-9d5a-4c43-9d83-9b0d5ea13b5d" />


## Tech Stack

- **Ruby** 3.3
- **Rails** 8.0.2
- **PostgreSQL** database
- **Redis** for caching and job queues
- **Devise** for user authentication
- **Rolify** for role management
- **Pundit** for authorization policies
- **StimulusJS**

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
