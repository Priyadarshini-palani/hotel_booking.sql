CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

-- Table Creation

CREATE TABLE Hotels (
    hotel_id      INT PRIMARY KEY,
    hotel_name    VARCHAR(100) NOT NULL,
    location      VARCHAR(100) NOT NULL,
    star_rating   INT CHECK (star_rating BETWEEN 1 AND 5),
    phone         VARCHAR(15),
    email         VARCHAR(100)
);

CREATE TABLE RoomTypes (
    room_type_id   INT PRIMARY KEY,
    type_name      VARCHAR(50) NOT NULL,   -- e.g. Single, Double, Suite
    description    VARCHAR(200),
    price_per_night DECIMAL(10,2) NOT NULL
);

CREATE TABLE Guests (
    guest_id      INT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    phone         VARCHAR(15),
    nationality   VARCHAR(50),
    id_proof      VARCHAR(50)   -- Passport / Aadhar / Driving License
);

CREATE TABLE Bookings (
    booking_id      INT PRIMARY KEY,
    guest_id        INT NOT NULL,
    room_id         INT NOT NULL,
    check_in_date   DATE NOT NULL,
    check_out_date  DATE NOT NULL,
    booking_date    DATE DEFAULT (CURRENT_DATE),
    status          VARCHAR(20) DEFAULT 'Confirmed',  -- Confirmed / Cancelled / Completed
    total_amount    DECIMAL(10,2),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
   FOREIGN KEY (room_id)  REFERENCES Rooms(room_id)
);

CREATE TABLE Payments (
    payment_id     INT PRIMARY KEY,
    booking_id     INT NOT NULL,
    payment_date   DATE NOT NULL,
    amount         DECIMAL(10,2) NOT NULL,
    payment_mode   VARCHAR(30),   -- Cash / Card / UPI / Net Banking
    status         VARCHAR(20) DEFAULT 'Paid',  -- Paid / Pending / Refunded
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

CREATE TABLE Services (
    service_id    INT PRIMARY KEY,
    service_name  VARCHAR(100) NOT NULL,
    charge        DECIMAL(10,2) NOT NULL
);

CREATE TABLE BookingServices (
    id            INT PRIMARY KEY,
    booking_id    INT NOT NULL,
    service_id    INT NOT NULL,
    quantity      INT DEFAULT 1,
    FOREIGN KEY (booking_id)  REFERENCES Bookings(booking_id),
    FOREIGN KEY (service_id)  REFERENCES Services(service_id)
);
-- Sample data
INSERT INTO Hotels VALUES (1, 'The Grand Palace',  'Mumbai',    5, '9000000001', 'grand@palace.com');
INSERT INTO Hotels VALUES (2, 'Sea Breeze Resort', 'Goa',       4, '9000000002', 'sea@breeze.com');
INSERT INTO Hotels VALUES (3, 'Mountain View Inn', 'Shimla',    3, '9000000003', 'mountain@view.com');

INSERT INTO RoomTypes VALUES (1, 'Single',  'Cozy room for one person',          1500.00);
INSERT INTO RoomTypes VALUES (2, 'Double',  'Spacious room for two',             2500.00);
INSERT INTO RoomTypes VALUES (3, 'Suite',   'Luxury suite with sea view',        6000.00);
INSERT INTO RoomTypes VALUES (4, 'Deluxe',  'Deluxe room with extra amenities',  4000.00);

-- Rooms
INSERT INTO Rooms VALUES (1,  1, '101', 1, 1, TRUE);
INSERT INTO Rooms VALUES (2,  1, '102', 2, 1, TRUE);
INSERT INTO Rooms VALUES (3,  1, '201', 3, 2, TRUE);
INSERT INTO Rooms VALUES (4,  1, '202', 4, 2, FALSE);
INSERT INTO Rooms VALUES (5,  2, '101', 1, 1, TRUE);
INSERT INTO Rooms VALUES (6,  2, '102', 2, 1, TRUE);
INSERT INTO Rooms VALUES (7,  2, '201', 3, 2, FALSE);
INSERT INTO Rooms VALUES (8,  3, '101', 1, 1, TRUE);
INSERT INTO Rooms VALUES (9,  3, '102', 2, 1, TRUE);
INSERT INTO Rooms VALUES (10, 3, '201', 4, 2, TRUE);

-- Guests
INSERT INTO Guests VALUES (1, 'Arjun',   'Sharma',    'arjun@gmail.com',   '9111111111', 'Indian',     'Aadhar');
INSERT INTO Guests VALUES (2, 'Priya',   'Nair',      'priya@gmail.com',   '9222222222', 'Indian',     'Passport');
INSERT INTO Guests VALUES (3, 'Rahul',   'Verma',     'rahul@gmail.com',   '9333333333', 'Indian',     'Driving License');
INSERT INTO Guests VALUES (4, 'Sneha',   'Patel',     'sneha@gmail.com',   '9444444444', 'Indian',     'Aadhar');
INSERT INTO Guests VALUES (5, 'John',    'Williams',  'john@gmail.com',    '9555555555', 'British',    'Passport');
INSERT INTO Guests VALUES (6, 'Meera',   'Iyer',      'meera@gmail.com',   '9666666666', 'Indian',     'Aadhar');

-- Bookings
INSERT INTO Bookings VALUES (1, 1, 2,  '2025-01-10', '2025-01-13', '2025-01-08',  'Completed', 7500.00);
INSERT INTO Bookings VALUES (2, 2, 7,  '2025-02-14', '2025-02-17', '2025-02-10',  'Completed', 18000.00);
INSERT INTO Bookings VALUES (3, 3, 3,  '2025-03-01', '2025-03-05', '2025-02-25',  'Completed', 24000.00);
INSERT INTO Bookings VALUES (4, 4, 5,  '2025-04-20', '2025-04-22', '2025-04-18',  'Confirmed', 3000.00);
INSERT INTO Bookings VALUES (5, 5, 6,  '2025-04-25', '2025-04-28', '2025-04-20',  'Confirmed', 7500.00);
INSERT INTO Bookings VALUES (6, 6, 10, '2025-05-01', '2025-05-04', '2025-04-28',  'Confirmed', 12000.00);
INSERT INTO Bookings VALUES (7, 1, 9,  '2025-05-10', '2025-05-12', '2025-05-01',  'Cancelled', 5000.00);
INSERT INTO Bookings VALUES (8, 3, 4,  '2025-06-01', '2025-06-03', '2025-05-20',  'Confirmed', 8000.00);

-- Payments
INSERT INTO Payments VALUES (1, 1, '2025-01-13', 7500.00,  'Card',         'Paid');
INSERT INTO Payments VALUES (2, 2, '2025-02-17', 18000.00, 'Net Banking',  'Paid');
INSERT INTO Payments VALUES (3, 3, '2025-03-05', 24000.00, 'UPI',          'Paid');
INSERT INTO Payments VALUES (4, 4, '2025-04-20', 3000.00,  'Card',         'Paid');
INSERT INTO Payments VALUES (5, 5, '2025-04-25', 7500.00,  'Cash',         'Pending');
INSERT INTO Payments VALUES (6, 7, '2025-05-10', 5000.00,  'Card',         'Refunded');

-- Services
INSERT INTO Services VALUES (1, 'Airport Pickup',   800.00);
INSERT INTO Services VALUES (2, 'Breakfast Buffet',  350.00);
INSERT INTO Services VALUES (3, 'Spa Session',      1200.00);
INSERT INTO Services VALUES (4, 'Laundry',           200.00);
INSERT INTO Services VALUES (5, 'Room Service',      500.00);

-- Booking Services
INSERT INTO BookingServices VALUES (1, 1, 2, 3);
INSERT INTO BookingServices VALUES (2, 2, 1, 1);
INSERT INTO BookingServices VALUES (3, 2, 3, 2);
INSERT INTO BookingServices VALUES (4, 3, 2, 4);
INSERT INTO BookingServices VALUES (5, 4, 5, 1);
INSERT INTO BookingServices VALUES (6, 5, 4, 2);

-- QUERIES (SELECT, JOIN, Aggregates)

-- Q1: List all available rooms with hotel name, room type and price
SELECT h.hotel_name,
       r.room_number,
       rt.type_name,
       rt.price_per_night,
       h.location
FROM   Rooms r
JOIN   Hotels   h  ON r.hotel_id    = h.hotel_id
JOIN   RoomTypes rt ON r.room_type_id = rt.room_type_id
WHERE  r.is_available = TRUE;


-- Q2: All bookings with guest name and room details
SELECT b.booking_id,
       CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
       h.hotel_name,
       r.room_number,
       rt.type_name,
       b.check_in_date,
       b.check_out_date,
       b.status,
       b.total_amount
FROM   Bookings b
JOIN   Guests   g  ON b.guest_id   = g.guest_id
JOIN   Rooms    r  ON b.room_id    = r.room_id
JOIN   Hotels   h  ON r.hotel_id   = h.hotel_id
JOIN   RoomTypes rt ON r.room_type_id = rt.room_type_id;


-- Q3: Total revenue per hotel
SELECT h.hotel_name,
       SUM(p.amount) AS total_revenue
FROM   Payments p
JOIN   Bookings b ON p.booking_id = b.booking_id
JOIN   Rooms    r ON b.room_id    = r.room_id
JOIN   Hotels   h ON r.hotel_id   = h.hotel_id
WHERE  p.status = 'Paid'
GROUP  BY h.hotel_name
ORDER  BY total_revenue DESC;


-- Q4: Most booked room type
SELECT rt.type_name,
       COUNT(b.booking_id) AS total_bookings
FROM   Bookings   b
JOIN   Rooms      r  ON b.room_id      = r.room_id
JOIN   RoomTypes  rt ON r.room_type_id = rt.room_type_id
GROUP  BY rt.type_name
ORDER  BY total_bookings DESC;


-- Q5: Guests with pending or no payment
SELECT CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
       b.booking_id,
       b.total_amount,
       COALESCE(p.status, 'No Payment') AS payment_status
FROM   Bookings b
JOIN   Guests   g ON b.guest_id   = g.guest_id
LEFT JOIN Payments p ON b.booking_id = p.booking_id
WHERE  p.status = 'Pending' OR p.payment_id IS NULL;


-- Q6: Number of nights and total stay cost per booking
SELECT b.booking_id,
       CONCAT(g.first_name, ' ', g.last_name)       AS guest_name,
       DATEDIFF(b.check_out_date, b.check_in_date)  AS nights_stayed,
       rt.price_per_night,
       b.total_amount
FROM   Bookings  b
JOIN   Guests    g  ON b.guest_id      = g.guest_id
JOIN   Rooms     r  ON b.room_id       = r.room_id
JOIN   RoomTypes rt ON r.room_type_id  = rt.room_type_id;


-- Q7: Services availed per booking with total service cost
SELECT b.booking_id,
       CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
       s.service_name,
       bs.quantity,
       (s.charge * bs.quantity) AS service_total
FROM   BookingServices bs
JOIN   Bookings b ON bs.booking_id = b.booking_id
JOIN   Guests   g ON b.guest_id    = g.guest_id
JOIN   Services s ON bs.service_id = s.service_id
ORDER  BY b.booking_id;


-- Q8: Cancelled bookings with refund info
SELECT b.booking_id,
       CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
       b.total_amount,
       p.status AS payment_status
FROM   Bookings b
JOIN   Guests   g ON b.guest_id   = g.guest_id
LEFT JOIN Payments p ON b.booking_id = p.booking_id
WHERE  b.status = 'Cancelled';



-- VIEWS

-- View 1: Full booking summary
CREATE VIEW vw_BookingSummary AS
SELECT b.booking_id,
       CONCAT(g.first_name, ' ', g.last_name) AS guest_name,
       g.email,
       h.hotel_name,
       h.location,
       r.room_number,
       rt.type_name                                       AS room_type,
       b.check_in_date,
       b.check_out_date,
       DATEDIFF(b.check_out_date, b.check_in_date)       AS nights,
       b.total_amount,
       b.status                                           AS booking_status,
       COALESCE(p.status, 'Not Paid')                    AS payment_status
FROM   Bookings b
JOIN   Guests    g  ON b.guest_id      = g.guest_id
JOIN   Rooms     r  ON b.room_id       = r.room_id
JOIN   Hotels    h  ON r.hotel_id      = h.hotel_id
JOIN   RoomTypes rt ON r.room_type_id  = rt.room_type_id
LEFT JOIN Payments p ON b.booking_id   = p.booking_id;

-- Use the view
SELECT * FROM vw_BookingSummary;


-- View 2: Hotel occupancy overview
CREATE VIEW vw_HotelOccupancy AS
SELECT h.hotel_name,
       COUNT(r.room_id)                                                  AS total_rooms,
       SUM(CASE WHEN r.is_available = FALSE THEN 1 ELSE 0 END)          AS occupied_rooms,
       SUM(CASE WHEN r.is_available = TRUE  THEN 1 ELSE 0 END)          AS available_rooms
FROM   Hotels h
JOIN   Rooms  r ON h.hotel_id = r.hotel_id
GROUP  BY h.hotel_name;

-- Use the view
SELECT * FROM vw_HotelOccupancy;

-- STORED PROCEDURES

DELIMITER $$

-- Procedure 1: Make a new booking
CREATE PROCEDURE sp_MakeBooking(
    IN p_guest_id       INT,
    IN p_room_id        INT,
    IN p_check_in       DATE,
    IN p_check_out      DATE,
    IN p_booking_id     INT
)
BEGIN
    DECLARE v_price     DECIMAL(10,2);
    DECLARE v_nights    INT;
    DECLARE v_total     DECIMAL(10,2);

    -- Get price per night from room type
    SELECT rt.price_per_night INTO v_price
    FROM   Rooms r
    JOIN   RoomTypes rt ON r.room_type_id = rt.room_type_id
    WHERE  r.room_id = p_room_id;

    SET v_nights = DATEDIFF(p_check_out, p_check_in);
    SET v_total  = v_price * v_nights;

    -- Insert booking
    INSERT INTO Bookings (booking_id, guest_id, room_id, check_in_date,
                          check_out_date, booking_date, status, total_amount)
    VALUES (p_booking_id, p_guest_id, p_room_id, p_check_in,
            p_check_out, CURRENT_DATE, 'Confirmed', v_total);

    -- Mark room as unavailable
    UPDATE Rooms SET is_available = FALSE WHERE room_id = p_room_id;

    SELECT CONCAT('Booking confirmed! Total amount: ₹', v_total) AS message;
END$$


-- Procedure 2: Cancel a booking
CREATE PROCEDURE sp_CancelBooking(
    IN p_booking_id INT
)
BEGIN
    UPDATE Bookings SET status = 'Cancelled' WHERE booking_id = p_booking_id;
    
    -- Free up the room
    UPDATE Rooms
    SET    is_available = TRUE
    WHERE  room_id = (SELECT room_id FROM Bookings WHERE booking_id = p_booking_id);

    -- Mark payment as refunded if paid
    UPDATE Payments
    SET    status = 'Refunded'
    WHERE  booking_id = p_booking_id AND status = 'Paid';

    SELECT 'Booking cancelled and room is now available.' AS message;
END$$


-- Procedure 3: Get guest booking history
CREATE PROCEDURE sp_GuestHistory(
    IN p_guest_id INT
)
BEGIN
    SELECT b.booking_id,
           h.hotel_name,
           r.room_number,
           rt.type_name,
           b.check_in_date,
           b.check_out_date,
           b.total_amount,
           b.status
    FROM   Bookings  b
    JOIN   Rooms     r  ON b.room_id      = r.room_id
    JOIN   Hotels    h  ON r.hotel_id     = h.hotel_id
    JOIN   RoomTypes rt ON r.room_type_id = rt.room_type_id
    WHERE  b.guest_id = p_guest_id
    ORDER  BY b.check_in_date DESC;
END$$

DELIMITER ;

-- SAMPLE PROCEDURE CALLS


-- Make a new booking (guest 4, room 8, 3 nights)
CALL sp_MakeBooking(4, 8, '2025-07-01', '2025-07-04', 9);

-- Get booking history for guest 1 (Arjun Sharma)
CALL sp_GuestHistory(1);

-- Cancel booking 7
CALL sp_CancelBooking(7);



