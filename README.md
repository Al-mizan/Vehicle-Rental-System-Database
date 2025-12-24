# Vehicle Rental System Database

## Project Overview

This project implements a comprehensive database solution for a vehicle rental management system. The database is designed to handle user management, vehicle inventory, and booking operations for a rental service that supports multiple vehicle types including cars, bikes, and trucks.

## Database Schema

The database consists of three main tables:

### 1. Users Table

Stores user information including customers and administrators.

**Columns:**

- `user_id`: Primary key (auto-increment)
- `name`: User's full name
- `email`: Unique email address
- `password`: User password (hashed)
- `phone`: Contact phone number
- `role`: User role ('Customer' or 'Admin')
- `created_at`: Account creation timestamp
- `updated_at`: Last update timestamp

### 2. Vehicles Table

Manages the vehicle inventory with details about each vehicle.

**Columns:**

- `vehicle_id`: Primary key (auto-increment)
- `name`: Vehicle name/brand
- `type`: Vehicle type ('car', 'bike', or 'truck')
- `model`: Model year
- `registration_number`: Unique vehicle registration number
- `rental_price`: Daily rental price
- `status`: Current availability status ('available', 'rented', or 'maintenance')

### 3. Bookings Table

Tracks all rental bookings and transactions.

**Columns:**

- `booking_id`: Primary key (auto-increment)
- `user_id`: Foreign key referencing users table
- `vehicle_id`: Foreign key referencing vehicles table
- `start_date`: Rental start date and time
- `end_date`: Rental end date and time
- `status`: Booking status ('pending', 'confirmed', 'completed', or 'cancelled')
- `total_cost`: Total rental cost

## Features

- **User Management**: Support for both customers and administrators with role-based access
- **Vehicle Management**: Track multiple vehicle types (cars, bikes, trucks) with availability status
- **Booking System**: Complete booking lifecycle from pending to completion
- **Data Integrity**: Foreign key constraints ensure referential integrity
- **Flexible Queries**: Various SQL queries for reporting and data analysis

## SQL Queries Included

The `queries.sql` file contains:

1. **JOIN Query**: Retrieves booking details with customer and vehicle information
2. **EXISTS/LEFT JOIN Query**: Finds vehicles that have never been booked
3. **WHERE Query**: Filters available cars from the vehicle inventory
4. **GROUP BY and HAVING Query**: Identifies vehicles with more than 2 bookings


## Query Solutions (SQL)

- **Query 1: JOIN** — booking info with customer and vehicle names

```sql
select booking_id,
    users.name as customer_name,
    vehicles.name as vehicle_name,
    start_date,
    end_date,
    bookings.status
from bookings
    join users using (user_id)
    join vehicles using (vehicle_id);
```

- **Query 2: NOT EXISTS** — vehicles that have never been booked

```sql
select v.*
from vehicles as v
    left join bookings as b on (v.vehicle_id = b.vehicle_id)
where b.vehicle_id is null
order by v.vehicle_id asc;
```

- **Query 3: WHERE** — available vehicles of a specific type (e.g., cars)

```sql
select *
from vehicles
where type = 'car' and status = 'available';
```

- **Query 4: GROUP BY / HAVING** — vehicles with more than 2 bookings

```sql
select vehicles.name as vehicle_name,
    count(*) as total_bookings
from vehicles
    join bookings using (vehicle_id)
group by vehicles.name
having count(*) > 2;
```

## Database Setup

To set up the database:

1. Execute the `queries.sql` file in your PostgreSQL database
2. The script will create all necessary tables, constraints, and insert sample data
3. All queries can be run individually to test different functionalities

## Sample Data

The database includes sample data for testing:

- 3 users (2 customers, 1 admin)
- 4 vehicles (2 cars, 1 bike, 1 truck)
- 4 booking records with various statuses

## Technical Stack

- **Database**: PostgreSQL
- **Language**: SQL
