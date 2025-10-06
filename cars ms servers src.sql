CREATE DATABASE Cars;
-- Car Table
CREATE TABLE Car (
    CarID INT PRIMARY KEY,
    CarModel VARCHAR(50),
    Manufacturer VARCHAR(50),
    Year INT,
    Color VARCHAR(30),
    RentalRate DECIMAL(10,2),
    Availability VARCHAR(20)
);

-- Customer Table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Address VARCHAR(100)
);

-- Booking Table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Car(CarID),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    RentalStartDate DATE,
    RentalEndDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT FOREIGN KEY REFERENCES Booking(BookingID),
    PaymentDate DATE,
    Amount DECIMAL(10,2),
    PaymentMethod VARCHAR(30)
);

-- Insurance Table
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Car(CarID),
    InsuranceProvider VARCHAR(50),
    PolicyNumber VARCHAR(50),
    StartDate DATE,
    EndDate DATE
);

-- Location Table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Car(CarID),
    LocationName VARCHAR(50),
    Address VARCHAR(100),
    ContactNumber VARCHAR(20)
);

-- Reservation Table
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Car(CarID),
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    ReservationDate DATE,
    PickupDate DATE,
    ReturnDate DATE
);

-- Maintenance Table
CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    CarID INT FOREIGN KEY REFERENCES Car(CarID),
    MaintenanceDate DATE,
    Description VARCHAR(100),
    Cost DECIMAL(10,2)
);
-- Insert into Car
INSERT INTO Car VALUES
(1, 'Corolla', 'Toyota', 2020, 'White', 50.00, 'Available'),
(2, 'Civic', 'Honda', 2021, 'Black', 55.00, 'Available'),
(3, 'Model 3', 'Tesla', 2022, 'Red', 80.00, 'Unavailable'),
(4, 'X5', 'BMW', 2019, 'Blue', 70.00, 'Available'),
(5, 'A4', 'Audi', 2020, 'Grey', 65.00, 'Available');

-- Insert into Customer
INSERT INTO Customer VALUES
(1, 'Alice', 'Kimani', 'alice@example.com', '0712345678', 'Nairobi'),
(2, 'Brian', 'Mwangi', 'brian@example.com', '0723456789', 'Nyeri'),
(3, 'Cynthia', 'Otieno', 'cynthia@example.com', '0734567890', 'Kisumu'),
(4, 'David', 'Mutua', 'david@example.com', '0745678901', 'Mombasa'),
(5, 'Eva', 'Kariuki', 'eva@example.com', '0756789012', 'Eldoret');

INSERT INTO Booking VALUES
(1, 1, 1, '2025-10-01', '2025-10-05', 250.00),
(2, 2, 2, '2025-10-02', '2025-10-06', 275.00),
(3, 3, 3, '2025-10-03', '2025-10-07', 320.00),
(4, 4, 4, '2025-10-04', '2025-10-08', 280.00),
(5, 5, 5, '2025-10-05', '2025-10-09', 260.00);

INSERT INTO Payment VALUES
(1, 1, '2025-10-01', 250.00, 'Credit Card'),
(2, 2, '2025-10-02', 275.00, 'Mobile Money'),
(3, 3, '2025-10-03', 320.00, 'Cash'),
(4, 4, '2025-10-04', 280.00, 'Credit Card'),
(5, 5, '2025-10-05', 260.00, 'Mobile Money');

INSERT INTO Insurance VALUES
(1, 1, 'Jubilee Insurance', 'POL12345', '2025-01-01', '2025-12-31'),
(2, 2, 'Britam', 'POL23456', '2025-02-01', '2025-12-31'),
(3, 3, 'APA Insurance', 'POL34567', '2025-03-01', '2025-12-31'),
(4, 4, 'CIC Group', 'POL45678', '2025-04-01', '2025-12-31'),
(5, 5, 'Madison', 'POL56789', '2025-05-01', '2025-12-31');

INSERT INTO Location VALUES
(1, 1, 'Nairobi CBD', 'Moi Avenue, Nairobi', '0700000001'),
(2, 2, 'Nyeri Town', 'Kenyatta Road, Nyeri', '0700000002'),
(3, 3, 'Kisumu Central', 'Oginga Odinga Street, Kisumu', '0700000003'),
(4, 4, 'Mombasa Island', 'Moi Avenue, Mombasa', '0700000004'),
(5, 5, 'Eldoret Town', 'Uganda Road, Eldoret', '0700000005');

INSERT INTO Reservation VALUES
(1, 1, 1, '2025-09-25', '2025-10-01', '2025-10-05'),
(2, 2, 2, '2025-09-26', '2025-10-02', '2025-10-06'),
(3, 3, 3, '2025-09-27', '2025-10-03', '2025-10-07'),
(4, 4, 4, '2025-09-28', '2025-10-04', '2025-10-08'),
(5, 5, 5, '2025-09-29', '2025-10-05', '2025-10-09');

INSERT INTO Maintenance VALUES
(1, 1, '2025-09-15', 'Oil Change', 30.00),
(2, 2, '2025-09-16', 'Brake Inspection', 45.00),
(3, 3, '2025-09-17', 'Tire Rotation', 25.00),
(4, 4, '2025-09-18', 'Engine Check', 60.00),
(5, 5, '2025-09-19', 'Battery Replacement', 80.00);



-- Get all available cars
SELECT * FROM Car WHERE Availability = 'Available';

-- Get bookings for a specific customer
SELECT * FROM Booking WHERE CustomerID = 2;

-- Get payments made in October 2025
SELECT * FROM Payment WHERE MONTH(PaymentDate) = 10 AND YEAR(PaymentDate) = 2025;
-- Update car availability
UPDATE Car SET Availability = 'Unavailable' WHERE CarID = 2;

-- Update customer email
UPDATE Customer SET Email = 'newemail@example.com' WHERE CustomerID = 3;

SELECT 
    B.BookingID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    Car.CarModel,
    B.RentalStartDate,
    B.RentalEndDate,
    B.TotalAmount
FROM Booking B
JOIN Customer C ON B.CustomerID = C.CustomerID
JOIN Car ON B.CarID = Car.CarID;

SELECT 
    P.PaymentID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.PaymentDate,
    P.Amount,
    P.PaymentMethod
FROM Payment P
JOIN Booking B ON P.BookingID = B.BookingID
JOIN Customer C ON B.CustomerID = C.CustomerID;

SELECT 
    R.ReservationID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    Car.CarModel,
    R.ReservationDate,
    R.PickupDate,
    R.ReturnDate
FROM Reservation R
JOIN Customer C ON R.CustomerID = C.CustomerID
JOIN Car ON R.CarID = Car.CarID;

SELECT 
    M.MaintenanceID,
    Car.CarModel,
    M.MaintenanceDate,
    M.Description,
    M.Cost
FROM Maintenance M
JOIN Car ON M.CarID = Car.CarID;



