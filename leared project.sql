-- 1. DATABASE CREATION
CREATE DATABASE PROJECTS_learn;

USE PROJECTS_learn;


-- 2. TABLE CREATION WITH CONSTRAINTS
CREATE TABLE CUSTOMER (
    CUSTOMER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50) NOT NULL,
    PHONE BIGINT UNIQUE NOT NULL,
    EMAIL VARCHAR(50) UNIQUE NOT NULL,
    CITY VARCHAR(50),
    AREA VARCHAR(100),
    ZIP_CODE VARCHAR(50)
);

--create table for the delivery staff

CREATE TABLE DELIVERY_STAFF (
    STAFF_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    PHONE BIGINT NOT NULL,
    EMAIL VARCHAR(50) UNIQUE NOT NULL
);
-- create table for the order that recieve from the customer

CREATE TABLE ORDERS (
    ORDER_ID INT IDENTITY(1,1) PRIMARY KEY,
    CUSTOMER_ID INT,
    ORDER_DATE DATE,
    DELIVERY_ADDRESS VARCHAR(100),
    TOTAL_AMOUNT DECIMAL(10,3),
    STATUS VARCHAR(50) CHECK (STATUS IN ('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);

-- create the table for the package that are ordered 

CREATE TABLE PACKAGE (
    PACKAGE_ID INT IDENTITY(1,1) PRIMARY KEY,
    ORDER_ID INT,
    WEIGHT INT,
    TRACKING_NUMBER BIGINT UNIQUE,
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);

-- create the table for the deliveries 

CREATE TABLE DELIVERIES (
    DELIVERY_ID INT IDENTITY(2,1) PRIMARY KEY,
    PACKAGE_ID INT,
    STAFF_ID INT,
    PICKUP_TIME DATE,
    DELIVERY_TIME DATE,
    STATUS VARCHAR(20) CHECK (STATUS IN ('TRANSIT', 'DELIVERED', 'FAILED')),
    FOREIGN KEY (PACKAGE_ID) REFERENCES PACKAGE(PACKAGE_ID),
    FOREIGN KEY (STAFF_ID) REFERENCES DELIVERY_STAFF(STAFF_ID)
);

-- creating the table for the payment that are receive 

CREATE TABLE PAYMENTS (
    PAYMENT_ID INT IDENTITY(3,1) PRIMARY KEY,
    ORDER_ID INT,
    PAYMENT_DATE DATE,
    AMOUNT DECIMAL(10,3),
    METHOD VARCHAR(15) CHECK (METHOD IN ('CASH', 'CARD', 'UPI')),
    STATUS VARCHAR(15) CHECK (STATUS IN ('PAID', 'FAILED', 'RETURNED')),
    FOREIGN KEY (ORDER_ID) REFERENCES ORDERS(ORDER_ID)
);


-- creating the table for the vehicle  

CREATE TABLE VEHICLE (
    VEHICLE_NUMBER VARCHAR(7) PRIMARY KEY,
    CAPACITY INT,
    STAFF_ID INT,
    FOREIGN KEY (STAFF_ID) REFERENCES DELIVERY_STAFF(STAFF_ID)
);

GO

-- 3. DATA INSERTION (DML)
INSERT INTO CUSTOMER (CUSTOMER_ID, FIRST_NAME, PHONE, EMAIL, CITY, AREA, ZIP_CODE) VALUES
(1, 'Ahmed', 1234567, 'ahmed@gmail.com', 'Karachi', 'DHA Phase 6', '75500'),
(2, 'Ayesha', 2345678, 'ayesha@hotmail.com', 'Lahore', 'Gulberg III', '54000'),
(3, 'Usman', 3456789, 'usman@yahoo.com', 'Islamabad', 'F-10', '44000'),
(4, 'Zainab', 1122334, 'zainab@hotmail.com', 'Faisalabad', 'Peoples Colony', '38000'),
(5, 'Hassan', 4455667, 'hassan@gmail.com', 'Peshawar', 'University Town', '25000'),
(6, 'Maria', 5566778, 'maria@yahoo.com', 'Quetta', 'Satellite Town', '87300');


-- inserting into the delivery staff

INSERT INTO DELIVERY_STAFF (STAFF_ID, FIRST_NAME, LAST_NAME, PHONE, EMAIL) VALUES
(1, 'Ali', 'Khan', 1112223, 'ali.khan@courier.pk'),
(2, 'Sara', 'Ahmed', 9998887, 'sara.ahmed@courier.pk'),
(3, 'Bilal', 'Yousaf', 3344556, 'bilal.yousaf@courier.pk'),
(4, 'Nadia', 'Khan', 7766554, 'nadia.khan@courier.pk');

-- inserting into the orders

INSERT INTO ORDERS (CUSTOMER_ID, ORDER_DATE, DELIVERY_ADDRESS, TOTAL_AMOUNT, STATUS) VALUES
(1, '2025-04-20', 'Street 12, DHA Phase 6, Karachi', 2500.500, 'DELIVERED'),
(2, '2025-04-21', 'House 7, Gulberg III, Lahore', 3200.000, 'SHIPPED'),
(3, '2025-04-22', 'House 25, G-11, Islamabad', 1800.750, 'DELIVERED'),
(4, '2025-04-23', 'Street 7, Peoples Colony, Faisalabad', 4600.000, 'PENDING'),
(5, '2025-04-23', 'Flat 8, University Town, Peshawar', 3100.250, 'SHIPPED'),
(6, '2025-04-24', 'Block C, Satellite Town, Quetta', 2200.900, 'CANCELLED');

-- inserting into the package

INSERT INTO PACKAGE (ORDER_ID, WEIGHT, TRACKING_NUMBER) VALUES
(1, 3, 987654321),
(2, 2, 876543210),
(3, 1, 112233445),
(4, 4, 223344556),
(5, 2, 334455667),
(6, 5, 445566778);

-- inserting into the delivery table

INSERT INTO DELIVERIES (PACKAGE_ID, STAFF_ID, PICKUP_TIME, DELIVERY_TIME, STATUS) VALUES
(1, 1, '2025-04-20', '2025-04-21', 'DELIVERED'),
(2, 2, '2025-04-21', NULL, 'TRANSIT'),
(3, 3, '2025-04-22', '2025-04-22', 'DELIVERED'),
(4, 4, '2025-04-23', NULL, 'TRANSIT'),
(5, 1, '2025-04-23', NULL, 'TRANSIT'),
(6, 2, '2025-04-24', NULL, 'FAILED');

--inserting into the payments table

INSERT INTO PAYMENTS (ORDER_ID, PAYMENT_DATE, AMOUNT, METHOD, STATUS) VALUES
(1, '2025-04-21', 2500.500, 'CASH', 'PAID'),
(2, '2025-04-21', 3200.000, 'CARD', 'PAID'),
(3, '2025-04-22', 1800.750, 'CARD', 'PAID'),
(4, '2025-04-23', 4600.000, 'CASH', 'FAILED'),
(5, '2025-04-23', 3100.250, 'UPI', 'PAID'),
(6, '2025-04-24', 2200.900, 'CARD', 'RETURNED');

-- Insert Vehicles
INSERT INTO VEHICLE (VEHICLE_NUMBER, CAPACITY, STAFF_ID) VALUES
('KHI1234', 500, 1),
('LHR5678', 600, 2),
('ISB4321', 450, 3),
('FSD8765', 550, 4);



--show all the customers data

SELECT * FROM CUSTOMER;
SELECT * FROM DELIVERY_STAFF;
SELECT * FROM PAYMENTS;
SELECT * FROM VEHICLE;
SELECT* FROM ORDERS;
SELECT * FROM PACKAGE;


--show all the customers city from where they ordered

SELECT DISTINCT CITY FROM CUSTOMER;
-- 4. UPDATE RECORD
UPDATE CUSTOMER
SET CITY = 'Islamabad'
WHERE CUSTOMER_ID = 2;

-- 5. DELETEING RECORDS
DELETE FROM PAYMENTS
WHERE STATUS = 'RETURNED';

--Show all data from payments

SELECT * FROM PAYMENTS

-- 6. SQL QUERIES: FILTERING AND AGGREGATION

-- Pattern Matching Using LIKE
SELECT * FROM CUSTOMER
WHERE FIRST_NAME LIKE '%'; -- Names starting with A

-- Filtering Using BETWEEN
SELECT * FROM ORDERS
WHERE TOTAL_AMOUNT BETWEEN 3000 AND 6000;

-- Filtering Using IN
SELECT * FROM CUSTOMER
WHERE CITY IN ('Karachi', 'Lahore');

-- Comparative Filtering Using ALL
SELECT * FROM ORDERS
WHERE TOTAL_AMOUNT > ALL (SELECT TOTAL_AMOUNT FROM ORDERS WHERE STATUS = 'PENDING');

-- Aggregate Functions
SELECT SUM(TOTAL_AMOUNT) AS TotalSales FROM ORDERS;
SELECT AVG(TOTAL_AMOUNT) AS AverageOrderAmount FROM ORDERS;
SELECT MAX(TOTAL_AMOUNT) AS MaxOrderAmount FROM ORDERS;

-- Group By and Having
SELECT CITY, COUNT(*) AS CustomerCount
FROM CUSTOMER
GROUP BY CITY
HAVING COUNT(*) > 0;

-- 7. SQL Sorting and Distinct
-- Sorting
SELECT * FROM CUSTOMER
ORDER BY FIRST_NAME DESC;

SELECT COUNT(*)
FROM ORDERS;

-- Distinct
SELECT DISTINCT CITY FROM CUSTOMER;

-- 8. SQL JOINS

-- Inner Join: Customers with Orders
SELECT C.FIRST_NAME, O.ORDER_ID, O.TOTAL_AMOUNT
FROM CUSTOMER C
INNER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Left Join: All Customers, even without Orders
SELECT C.FIRST_NAME, O.DELIVERY_ADDRESS
FROM CUSTOMER C
LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Right Join: All Orders, even without Customers (rare case here)
SELECT D.FIRST_NAME, C.PACKAGE_ID
FROM DELIVERY_STAFF D
RIGHT JOIN DELIVERIES C ON D.STAFF_ID = C.STAFF_ID;

-- Full Outer Join: Customers and Orders
SELECT COALESCE(C.FIRST_NAME, 'No Customer') AS CustomerName, O.ORDER_ID
FROM CUSTOMER C
FULL OUTER JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- Complex Join: Orders of at least certain weight
SELECT P.ORDER_ID, COUNT(*) AS TotalPackages
FROM PACKAGE P
GROUP BY P.ORDER_ID
HAVING COUNT(*) >= 1;

-- 9. SQL STORED PROCEDURES

-- Retrieve customers from a specific city
CREATE PROCEDURE GetCustomersByCity @CityName VARCHAR(50)
AS
BEGIN
    SELECT * FROM CUSTOMER WHERE CITY = @CityName;
END;

-- Execute: GetCustomersByCity
EXEC GetCustomersByCity @CityName = 'Karachi';


-- Update order status by OrderID
CREATE PROCEDURE UpdateOrderStatus @OrderId INT, @NewStatus VARCHAR(20)
AS
BEGIN
    UPDATE ORDERS
    SET STATUS = @NewStatus
    WHERE ORDER_ID = @OrderId;
END;

-- Execute: UpdateOrderStatus
EXEC UpdateOrderStatus @OrderId = 4, @NewStatus = 'DELIVERED';

-- Insert a new order
CREATE PROCEDURE InsertNewOrder
    @CustomerId INT,
    @OrderDate DATE,
    @DeliveryAddress VARCHAR(100),
    @TotalAmount DECIMAL(10,3),
    @Status VARCHAR(50)
AS
BEGIN
    INSERT INTO ORDERS (CUSTOMER_ID, ORDER_DATE, DELIVERY_ADDRESS, TOTAL_AMOUNT, STATUS)
    VALUES (@CustomerId, @OrderDate, @DeliveryAddress, @TotalAmount, @Status);
END;

-- Execute: InsertNewOrder
EXEC InsertNewOrder 
    @CustomerId = 1, 
    @OrderDate = '2025-04-27', 
    @DeliveryAddress = 'New Town, Karachi', 
    @TotalAmount = 3600.500, 
    @Status = 'PENDING';

-- Aggregate in Stored Procedure: Total sales
CREATE PROCEDURE GetTotalSales
AS
BEGIN
    SELECT SUM(AMOUNT) AS TotalSales FROM PAYMENTS WHERE STATUS = 'PAID';
END;

-- Execute: GetTotalSales
EXEC GetTotalSales;


-- Conditional Stored Procedure: Stock Check
CREATE PROCEDURE CheckDeliveryStatus @PackageId INT
AS LIKE ='%'
BEGIN
    DECLARE @status VARCHAR(20);
    SELECT @status = STATUS FROM DELIVERIES WHERE PACKAGE_ID = @PackageId;
    
    IF (@status = 'DELIVERED')
        PRINT 'Package Delivered Successfully!';
    ELSE
        PRINT 'Package Not Delivered Yet.';
END;

-- Execute: CheckDeliveryStatus
EXEC CheckDeliveryStatus @PackageId = 1;

GO

-- 10. SQL FUNCTIONS AND VIEWS

-- Table-Valued Function: Get orders by status
CREATE FUNCTION dbo.GetOrdersByStatus(@Status VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM ORDERS WHERE STATUS = @Status
);


-- Get orders by status using inline table-valued function
SELECT * FROM dbo.GetOrdersByStatus('SHIPPED');

-- Multi-Statement Function: Customer Order Summary
CREATE FUNCTION dbo.CustomerOrderSummary()
RETURNS @Summary TABLE
(
    CustomerName VARCHAR(50),
    TotalOrders INT
)
AS
BEGIN
    INSERT INTO @Summary
    SELECT C.FIRST_NAME, COUNT(O.ORDER_ID)
    FROM CUSTOMER C
    LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
    GROUP BY C.FIRST_NAME;
    RETURN;
END;

-- Get summary of total orders per customer using multi-statement function
SELECT * FROM dbo.CustomerOrderSummary();

-- View: Simplified Customer-Order view
CREATE VIEW CustomerOrdersView AS
SELECT C.FIRST_NAME, O.ORDER_ID, O.STATUS
FROM CUSTOMER C
JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

-- View of customer names and their order status
SELECT * FROM CustomerOrdersView;

-- trigger to update the delivery status in data after the succesful delivery

CREATE TRIGGER trg_AfterUpdateDeliveries
ON DELIVERIES
AFTER UPDATE
AS
BEGIN
    PRINT 'Delivery record updated!';
END;

--execution of the trigger
UPDATE DELIVERIES
SET DELIVERY_TIME = GETDATE()
WHERE DELIVERY_ID = 3;


SELECT * FROM DELIVERIES;