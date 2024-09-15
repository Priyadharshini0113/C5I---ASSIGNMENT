CREATE DATABASE retail_support;

USE retail_support;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    SaleDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Sales_Products (
    SaleID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    PRIMARY KEY (SaleID, ProductID)
);

CREATE TABLE Queries (
    QueryID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    QueryDate DATE,
    QueryText TEXT,
    ResponseText TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, State, ZipCode) 
VALUES 
('John', 'Doe', 'john.doe@example.com', '555-1234', '123 Elm Street', 'Springfield', 'IL', '62701'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '456 Oak Avenue', 'Chicago', 'IL', '60614'),
('Emily', 'Johnson', 'emily.johnson@example.com', '555-9876', '789 Pine Road', 'Peoria', 'IL', '61602'),
('Michael', 'Williams', 'michael.williams@example.com', '555-4321', '101 Maple Lane', 'Aurora', 'IL', '60505'),
('Sarah', 'Brown', 'sarah.brown@example.com', '555-6789', '202 Birch Street', 'Naperville', 'IL', '60563'),
('David', 'Jones', 'david.jones@example.com', '555-2345', '303 Cedar Avenue', 'Evanston', 'IL', '60201'),
('Laura', 'Garcia', 'laura.garcia@example.com', '555-3456', '404 Elm Street', 'Joliet', 'IL', '60432'),
('Daniel', 'Martinez', 'daniel.martinez@example.com', '555-4567', '505 Oak Avenue', 'Schaumburg', 'IL', '60193'),
('Jessica', 'Hernandez', 'jessica.hernandez@example.com', '555-5679', '606 Pine Road', 'Bolingbrook', 'IL', '60440'),
('Robert', 'Lopez', 'robert.lopez@example.com', '555-6780', '707 Maple Lane', 'Arlington Heights', 'IL', '60004'),
('Linda', 'Wilson', 'linda.wilson@example.com', '555-7891', '808 Birch Street', 'Downers Grove', 'IL', '60515'),
('James', 'Miller', 'james.miller@example.com', '555-8902', '909 Cedar Avenue', 'Oak Brook', 'IL', '60523'),
('Patricia', 'Moore', 'patricia.moore@example.com', '555-9012', '1010 Elm Street', 'Wheaton', 'IL', '60187'),
('William', 'Taylor', 'william.taylor@example.com', '555-0123', '1111 Oak Avenue', 'Glen Ellyn', 'IL', '60137'),
('Nancy', 'Anderson', 'nancy.anderson@example.com', '555-1235', '1212 Pine Road', 'Elmhurst', 'IL', '60126'),
('Christopher', 'Thomas', 'christopher.thomas@example.com', '555-2346', '1313 Maple Lane', 'Streamwood', 'IL', '60107'),
('Deborah', 'Jackson', 'deborah.jackson@example.com', '555-3457', '1414 Birch Street', 'Batavia', 'IL', '60510'),
('Joseph', 'White', 'joseph.white@example.com', '555-4568', '1515 Cedar Avenue', 'Geneva', 'IL', '60134'),
('Karen', 'Harris', 'karen.harris@example.com', '555-5670', '1616 Elm Street', 'Lombard', 'IL', '60148'),
('Charles', 'Clark', 'charles.clark@example.com', '555-6781', '1717 Oak Avenue', 'Roselle', 'IL', '60172'),
('Amanda', 'Lewis', 'amanda.lewis@example.com', '555-7892', '1818 Pine Road', 'La Grange', 'IL', '60525'),
('Steven', 'Young', 'steven.young@example.com', '555-8903', '1919 Maple Lane', 'Mokena', 'IL', '60448'),
('Megan', 'Scott', 'megan.scott@example.com', '555-9013', '2020 Birch Street', 'Orland Park', 'IL', '60462'),
('Andrew', 'Adams', 'andrew.adams@example.com', '555-0124', '2121 Cedar Avenue', 'Woodridge', 'IL', '60517'),
('Emily', 'Mitchell', 'emily.mitchell@example.com', '555-1236', '2222 Elm Street', 'Hinsdale', 'IL', '60521'),
('Joshua', 'Roberts', 'joshua.roberts@example.com', '555-2347', '2323 Oak Avenue', 'Westmont', 'IL', '60559');


INSERT INTO Products (ProductName, Category, Price, StockQuantity) 
VALUES 
('Laptop', 'Electronics', 999.99, 50),
('Smartphone', 'Electronics', 599.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Desk Chair', 'Furniture', 89.99, 20),
('Bluetooth Speaker', 'Electronics', 79.99, 40),
('Washing Machine', 'Appliances', 499.99, 15),
('Television', 'Electronics', 699.99, 25),
('Refrigerator', 'Appliances', 1299.99, 10),
('Microwave Oven', 'Appliances', 99.99, 50),
('Air Purifier', 'Electronics', 149.99, 35),
('Sofa', 'Furniture', 399.99, 12),
('Dining Table', 'Furniture', 299.99, 18),
('Blender', 'Appliances', 59.99, 45),
('Headphones', 'Electronics', 129.99, 60),
('Smartwatch', 'Electronics', 199.99, 55),
('Vacuum Cleaner', 'Appliances', 89.99, 28),
('Bookshelf', 'Furniture', 149.99, 22),
('Printer', 'Electronics', 129.99, 25),
('Table Lamp', 'Furniture', 39.99, 40),
('Digital Camera', 'Electronics', 499.99, 20),
('Toaster', 'Appliances', 29.99, 70),
('Desk Lamp', 'Furniture', 49.99, 30),
('Electric Kettle', 'Appliances', 34.99, 55),
('Gaming Console', 'Electronics', 299.99, 18),
('Office Chair', 'Furniture', 129.99, 25),
('Exercise Bike', 'Fitness', 399.99, 15),
('Food Processor', 'Appliances', 149.99, 20),
('Treadmill', 'Fitness', 799.99, 12);


INSERT INTO Sales (CustomerID, SaleDate, TotalAmount) 
VALUES 
(1, '2024-09-10', 1099.98),
(2, '2024-09-11', 599.99),
(3, '2024-09-12', 49.99),
(4, '2024-09-13', 499.99),
(5, '2024-09-14', 79.99),
(6, '2024-09-15', 1299.99),
(7, '2024-09-16', 99.99),
(8, '2024-09-17', 149.99),
(9, '2024-09-18', 399.99),
(10, '2024-09-19', 299.99),
(11, '2024-09-20', 599.99),
(12, '2024-09-21', 89.99),
(13, '2024-09-22', 59.99),
(14, '2024-09-23', 199.99),
(15, '2024-09-24', 129.99),
(16, '2024-09-25', 49.99),
(17, '2024-09-26', 34.99),
(18, '2024-09-27', 129.99),
(19, '2024-09-28', 89.99),
(20, '2024-09-29', 499.99),
(21, '2024-09-30', 799.99),
(22, '2024-10-01', 49.99),
(23, '2024-10-02', 599.99),
(24, '2024-10-03', 99.99),
(25, '2024-10-04', 79.99);

INSERT INTO Sales_Products (SaleID, ProductID, Quantity) 
VALUES 
(1, 1, 1),  -- Laptop
(1, 2, 1),  -- Smartphone
(2, 2, 1),  -- Smartphone
(3, 3, 1),  -- Coffee Maker
(4, 6, 1),  -- Washing Machine
(5, 5, 1),  -- Bluetooth Speaker
(6, 7, 1),  -- Television
(7, 8, 1),  -- Refrigerator
(8, 9, 1),  -- Microwave Oven
(9, 10, 1), -- Air Purifier
(10, 11, 1), -- Sofa
(11, 12, 1), -- Dining Table
(12, 13, 1), -- Blender
(13, 14, 1), -- Headphones
(14, 15, 1), -- Smartwatch
(15, 16, 1), -- Vacuum Cleaner
(16, 17, 1), -- Bookshelf
(17, 18, 1), -- Printer
(18, 19, 1), -- Table Lamp
(19, 20, 1), -- Digital Camera
(20, 21, 1), -- Toaster
(21, 22, 1), -- Desk Lamp
(22, 23, 1), -- Gaming Console
(23, 24, 1), -- Office Chair
(24, 25, 1), -- Exercise Bike
(25, 26, 1); -- Food Processor

INSERT INTO Queries (CustomerID, QueryDate, QueryText, ResponseText) 
VALUES 
(1, '2024-09-11', 'What is the status of my recent order?', 'Your order is being processed and will be shipped soon.'),
(2, '2024-09-12', 'Can I return the smartphone I purchased?', 'Yes, you can return the smartphone within 30 days of purchase.'),
(3, '2024-09-13', 'Do you have any discounts on furniture?', 'Currently, we have a 10% discount on all furniture items.'),
(4, '2024-09-14', 'How long is the warranty for the washing machine?', 'The washing machine comes with a 2-year warranty.'),
(5, '2024-09-15', 'What is the return policy for electronics?', 'Electronics can be returned within 14 days of purchase.'),
(6, '2024-09-16', 'Do you offer free shipping?', 'We offer free shipping on orders over $100.'),
(7, '2024-09-17', 'Can I track my order?', 'Yes, you will receive a tracking number once your order has shipped.'),
(8, '2024-09-18', 'Are there any promotions on air purifiers?', 'We currently have a 15% off promotion on air purifiers.'),
(9, '2024-09-19', 'When will my order be delivered?', 'Orders are typically delivered within 5-7 business days.'),
(10, '2024-09-20', 'Can I change my shipping address?', 'Yes, you can update your shipping address before the order is shipped.'),
(11, '2024-09-21', 'Do you have any new arrivals in furniture?', 'We have a new collection of furniture arriving next week.'),
(12, '2024-09-22', 'What are the payment options?', 'We accept credit cards, debit cards, and PayPal.'),
(13, '2024-09-23', 'Is there a warranty on the smart TV?', 'Yes, the smart TV comes with a 1-year warranty.'),
(14, '2024-09-24', 'Can I get a refund for a defective product?', 'Yes, we offer refunds for defective products within 30 days of purchase.'),
(15, '2024-09-25', 'What is the delivery time for large appliances?', 'Large appliances typically take 7-10 business days to be delivered.'),
(16, '2024-09-26', 'Do you offer installation services?', 'Yes, we offer installation services for large appliances at an additional cost.'),
(17, '2024-09-27', 'Are there any upcoming sales?', 'Yes, we will have a big sale next month.'),
(18, '2024-09-28', 'Can I apply a coupon code to my order?', 'Yes, you can apply a coupon code at checkout.'),
(19, '2024-09-29', 'What is your customer service number?', 'Our customer service number is 1-800-123-4567.'),
(20, '2024-09-30', 'Do you have a loyalty program?', 'Yes, we offer a loyalty program with rewards and discounts.'),
(21, '2024-10-01', 'How can I contact customer support?', 'You can contact customer support via email or phone.'),
(22, '2024-10-02', 'What is the status of my return?', 'Your return is being processed and will be completed within 5 business days.'),
(23, '2024-10-03', 'Do you offer gift cards?', 'Yes, we offer gift cards in various denominations.'),
(24, '2024-10-04', 'Are your products eco-friendly?', 'We offer a range of eco-friendly products.'),
(25, '2024-10-05', 'Can I schedule a delivery time?', 'Yes, you can schedule a delivery time when placing your order.');
