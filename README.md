# Hospital Management API

A comprehensive RESTful API for hospital management, built with Ruby on Rails 7. This system provides a complete backend solution for managing patients, medical records, doctor appointments, laboratory results, and prescriptions.

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Database Structure](#database-structure)
- [API Endpoints](#api-endpoints)
- [Authentication](#authentication)
- [Setup and Installation](#setup-and-installation)
- [Docker Support](#docker-support)
- [Testing](#testing)

## Features

- **Patient Management**: Comprehensive patient records with personal details, allergies, blood type, and contact information.
- **Medical Records**: Complete digital medical records with visit history and anamnesis data.
- **Doctor Management**: Doctor profiles with specialties and department assignment.
- **Department Organization**: Hospital departments with assigned floors and doctors.
- **Visit Tracking**: Patient visits with priority levels, doctor assignment, and room allocation.
- **Laboratory Results**: Track lab tests, results, and status.
- **Prescriptions**: Digital prescription management with medication, dosage, and duration.
- **Authentication & Authorization**: JWT-based authentication and role-based access control.
- **API Versioning**: Structured for long-term API development and maintenance.

## Tech Stack

- **Ruby**: 3.3.1
- **Rails**: 7.1.4
- **Database**: PostgreSQL
- **Authentication**: Devise with JWT tokens
- **Authorization**: CanCanCan
- **API Serialization**: Panko Serializer
- **Internationalization**: I18n for multi-language support
- **Testing**: RSpec, FactoryBot, Faker
- **Code Quality**: RuboCop
- **Deployment**: Docker support

## Database Structure

The system uses a relational database with the following main entities:

- **Users**: Authentication and staff management with roles
- **Patients**: Patient personal and contact information
- **Medical Records**: Complete patient medical history
- **Anamneses**: Detailed patient background and history
- **Doctors**: Medical staff with specialties
- **Departments**: Hospital organizational units
- **Visits**: Patient encounters/appointments
- **Laboratory Results**: Medical test results
- **Prescriptions**: Medication and treatment orders

## API Endpoints

The API follows a RESTful design with versioning (v1) and includes endpoints for:

### Authentication
- `POST /api/v1/auth/login` - User login
- `DELETE /api/v1/auth/logout` - User logout
- `POST /api/v1/auth/signup` - User registration

### Patients
- `GET /api/v1/patients` - List patients
- `POST /api/v1/patients` - Create patient
- `GET /api/v1/patients/:id` - Show patient
- `PUT /api/v1/patients/:id` - Update patient
- `DELETE /api/v1/patients/:id` - Delete patient
- `GET /api/v1/patients/:id/medical_record` - Get patient's medical record
- `GET /api/v1/patients/:id/visits` - Get patient's visits

### Visits
- `GET /api/v1/visits` - List visits
- `POST /api/v1/visits` - Create visit
- `GET /api/v1/visits/:id` - Show visit
- `PUT /api/v1/visits/:id` - Update visit
- `DELETE /api/v1/visits/:id` - Delete visit
- `GET /api/v1/visits/:id/prescriptions` - Get visit's prescriptions
- `GET /api/v1/visits/:id/laboratory_results` - Get visit's lab results

### Resources
Complete RESTful endpoints (GET, POST, PUT, DELETE) are available for:
- Departments
- Doctors
- Laboratory Results
- Prescriptions
- Anamneses

## Authentication

The API uses JWT (JSON Web Token) authentication via the Devise and Devise-JWT gems. 
Authentication flow:

1. Register a user: `POST /api/v1/auth/signup`
2. Login to get token: `POST /api/v1/auth/login`
3. Include the token in the Authorization header for protected endpoints:
   `Authorization: Bearer <token>`

## Setup and Installation

### Prerequisites
- Ruby 3.3.1
- PostgreSQL
- Bundler

### Local Setup
```bash
# Clone the repository
git clone https://github.com/scaminom/hospital-managment-api.git
cd hospital-managment-api

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed  # Optional: add sample data

# Start the server
rails server
```

## Docker Support

The application includes Docker configuration for easy deployment:

```bash
# Build the Docker image
docker build -t hospital-managment-api .

# Run the container
docker run -p 3000:3000 hospital-managment-api
```

## Testing

The application uses RSpec for testing:

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/models/patient_spec.rb
```
