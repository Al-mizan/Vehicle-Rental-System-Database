-- users table
create table if not exists users (
    user_id serial primary key,
    name varchar(50) not null,
    email varchar(100) unique not null,
    password text not null,
    phone varchar(20) not null,
    role text check (role in ('Customer', 'Admin')) default 'Customer' not null,
    created_at timestamp default now(),
    updated_at timestamp default now()
);
insert into users (user_id, name, email, password, phone, role)
values (
        1,
        'Alice',
        'alice@example.com',
        '123456',
        '1234567890',
        'Customer'
    ),
    (
        2,
        'Bob',
        'bob@example.com',
        '123456',
        '0987654321',
        'Admin'
    ),
    (
        3,
        'Charlie',
        'charlie@example.com',
        '123456',
        '1122334455',
        'Customer'
    );
-- 
-- vehicles table
-- 
create table if not exists vehicles (
    vehicle_id serial primary key,
    name varchar(100) not null,
    type text check (
        type in ('car', 'bike', 'truck')
    ) default 'car' not null,
    model varchar(50) not null,
    registration_number varchar(50) unique not null,
    rental_price int not null,
    status text check (status in ('available', 'rented', 'maintenance')) default 'available' not null
);
insert into vehicles (
        vehicle_id,
        name,
        type,
        model,
        registration_number,
        rental_price,
        status
    )
values (
        1,
        'Toyota Corolla',
        'car',
        '2022',
        'ABC -123',
        50,
        'available'
    ),
    (
        2,
        'Honda Civic',
        'car',
        '2021',
        'DEF -456',
        60,
        'rented'
    ),
    (
        3,
        'Yamaha R15',
        'bike',
        '2023',
        'GHI -789',
        30,
        'available'
    ),
    (
        4,
        'Ford F-150',
        'truck',
        '2020',
        'JKL -012',
        100,
        'maintenance'
    );
-- 
-- Bookings table
--
create table if not exists
bookings (
    booking_id serial primary key,
    user_id int CONSTRAINT fk_bookings_user_id references users (user_id) on delete cascade,
    vehicle_id int CONSTRAINT fk_bookings_vehicle_id references vehicles (vehicle_id) on delete cascade,
    start_date timestamp not null,
    end_date timestamp not null,
    status text check (
        status in ('pending', 'confirmed', 'completed', 'cancelled')
    ) default 'pending' not null,
    total_cost int not null
);
insert into bookings (
        booking_id,
        user_id,
        vehicle_id,
        start_date,
        end_date,
        status,
        total_cost
    )
values (
        1,
        1,
        2,
        '2023-10-01',
        '2023-10-05',
        'completed',
        240
    ),
    (
        2,
        1,
        2,
        '2023-11-01',
        '2023-11-03',
        'completed',
        120
    ),
    (
        3,
        3,
        2,
        '2023-12-01',
        '2023-12-02',
        'confirmed',
        60
    ),
    (
        4,
        1,
        1,
        '2023-12-10',
        '2023-12-12',
        'pending',
        100
    );
-- 
-- Query
--

-- Query 1: JOIN
select booking_id,
    users.name as customer_name,
    vehicles.name as vehicle_name,
    start_date,
    end_date,
    bookings.status
from bookings
    join users using (user_id)
    join vehicles using (vehicle_id);


-- Query 2: EXISTS
select v.*
from vehicles as v
    left join bookings as b on (v.vehicle_id = b.vehicle_id)
where b.vehicle_id is null
order by v.vehicle_id asc;


-- Query 3: WHERE
select *
from vehicles
where type = 'car'
    and status = 'available';

    
-- Query 4: GROUP BY and HAVING
select vehicles.name as vehicle_name,
    count(*) as total_bookings
from vehicles
    join bookings using(vehicle_id)
group by vehicles.name
having count(*) > 2;