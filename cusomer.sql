create database cus_ag;
use cus_ag;

create table customers (
	CustomerID varchar(10) primary key,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	Email varchar(200) not null unique,
	Phone varchar(50),
	Addressline varchar(150),
	City varchar(50),
	State varchar(50),
	CreatedAt date not null
);

INSERT INTO Customers
(CustomerID, FirstName, LastName, Email, Phone, AddressLine, City, State, CreatedAt)
VALUES
('C00001','Adebayo','Adeyemi','adebayo.adeyemi@example.com','08030000001','12 Allen Avenue','Ikeja','Lagos','2026-01-05'),
('C00002','Chioma','Okafor','chioma.okafor@example.com','08030000002','18 Admiralty Way','Lekki','Lagos','2026-01-08'),
('C00003','Daniel','Johnson','daniel.johnson@example.com','08030000003','24 Festac Road','Festac','Lagos','2026-01-10'),
('C00004','Fatima','Bello','fatima.bello@example.com','08030000004','7 Gwarinpa Road','Gwarinpa','FCT','2026-01-12'),
('C00005','Ibrahim','Musa','ibrahim.musa@example.com','08030000005','15 Ahmadu Bello Way','Kaduna','Kaduna','2026-01-15'),
('C00006','Esther','Williams','esther.williams@example.com','08030000006','21 Ring Road','Benin City','Edo','2026-01-18'),
('C00007','Oluwaseun','Ojo','oluwaseun.ojo@example.com','08030000007','5 Bodija Estate','Ibadan','Oyo','2026-01-20'),
('C00008','Mary','Eze','mary.eze@example.com','08030000008','11 Independence Layout','Enugu','Enugu','2026-01-22'),
('C00009','Yusuf','Abdullahi','yusuf.abdullahi@example.com','08030000009','30 Airport Road','Kano','Kano','2026-01-25'),
('C00010','Grace','Akinyemi','grace.akinyemi@example.com','08030000010','9 Yaba Road','Yaba','Lagos','2026-01-27'),
('C00011','Emeka','Nwosu','emeka.nwosu@example.com','08030000011','14 Wuse 2','Wuse','FCT','2026-01-29'),
('C00012','Zainab','Sani','zainab.sani@example.com','08030000012','8 Ibrahim Taiwo Road','Ilorin','Kwara','2026-02-01'),
('C00013','Tunde','Balogun','tunde.balogun@example.com','08030000013','22 Ikorodu Road','Surulere','Lagos','2026-02-03'),
('C00014','Amaka','Ibe','amaka.ibe@example.com','08030000014','16 New Market Road','Onitsha','Anambra','2026-02-05'),
('C00015','Samuel','Obi','samuel.obi@example.com','08030000015','4 Aba Road','Port Harcourt','Rivers','2026-02-07'),
('C00016','Kemi','Afolabi','kemi.afolabi@example.com','08030000016','19 Opebi Road','Ikeja','Lagos','2026-02-10'),
('C00017','Michael','Okoro','michael.okoro@example.com','08030000017','6 Airport Residential Road','Calabar','Cross River','2026-02-12'),
('C00018','Hauwa','Garba','hauwa.garba@example.com','08030000018','10 Zaria Road','Kano','Kano','2026-02-15'),
('C00019','David','Eze','david.eze@example.com','08030000019','3 Awolowo Road','Ikoyi','Lagos','2026-02-17'),
('C00020','Blessing','Umeh','blessing.umeh@example.com','08030000020','25 GRA Road','Enugu','Enugu','2026-02-20'),
('C00021','Kunle','Ajayi','kunle.ajayi@example.com','08030000021','13 Lekki-Epe Road','Lekki','Lagos','2026-02-22'),
('C00022','Aisha','Ibrahim','aisha.ibrahim@example.com','08030000022','17 Jabi Lake Road','Jabi','FCT','2026-02-24'),
('C00023','Victor','Ekanem','victor.ekanem@example.com','08030000023','9 Marian Road','Calabar','Cross River','2026-02-26'),
('C00024','Ruth','Adeola','ruth.adeola@example.com','08030000024','20 Challenge Road','Ibadan','Oyo','2026-03-01'),
('C00025','Ahmed','Yusuf','ahmed.yusuf@example.com','08030000025','31 Bompai Road','Kano','Kano','2026-03-03'),
('C00026','Tosin','Ogunleye','tosin.ogunleye@example.com','08030000026','12 Ogba Road','Ogba','Lagos','2026-03-05'),
('C00027','Janet','Ibrahim','janet.ibrahim@example.com','08030000027','8 Maitama Avenue','Maitama','FCT','2026-03-07'),
('C00028','Chinedu','Eze','chinedu.eze@example.com','08030000028','10 GRA Phase 2','Port Harcourt','Rivers','2026-03-10'),
('C00029','Sarah','Bassey','sarah.bassey@example.com','08030000029','7 Ewet Housing Estate','Uyo','Akwa Ibom','2026-03-12'),
('C00030','Femi','Lawal','femi.lawal@example.com','08030000030','18 Agege Motor Road','Agege','Lagos','2026-03-15'),
('C00031','Nneka','Okeke','nneka.okeke@example.com','08030000031','14 Awka Road','Awka','Anambra','2026-03-17'),
('C00032','Abdul','Mamman','abdul.mamman@example.com','08030000032','22 Independence Way','Kaduna','Kaduna','2026-03-20'),
('C00033','Damilola','Fashola','damilola.fashola@example.com','08030000033','5 Maryland Road','Maryland','Lagos','2026-03-22'),
('C00034','Ngozi','Eze','ngozi.eze@example.com','08030000034','11 Ogui Road','Enugu','Enugu','2026-03-24'),
('C00035','Peter','George','peter.george@example.com','08030000035','3 Old GRA Road','Port Harcourt','Rivers','2026-03-26'),
('C00036','Mariam','Bello','mariam.bello@example.com','08030000036','16 Area 11','Garki','FCT','2026-03-29'),
('C00037','Yinka','Adebisi','yinka.adebisi@example.com','08030000037','27 Herbert Macaulay Way','Yaba','Lagos','2026-04-01'),
('C00038','Hadiza','Umar','hadiza.umar@example.com','08030000038','19 Ahmadu Bello Way','Kaduna','Kaduna','2026-04-03'),
('C00039','John','Nwachukwu','john.nwachukwu@example.com','08030000039','8 Okigwe Road','Owerri','Imo','2026-04-05'),
('C00040','Mercy','Etim','mercy.etim@example.com','08030000040','6 Ikot Ekpene Road','Uyo','Akwa Ibom','2026-04-08'),
('C00041','Seun','Oladipo','seun.oladipo@example.com','08030000041','15 Allen Avenue','Ikeja','Lagos','2026-04-10'),
('C00042','Musa','Abubakar','musa.abubakar@example.com','08030000042','12 Zoo Road','Kano','Kano','2026-04-12'),
('C00043','Ada','Onyeka','ada.onyeka@example.com','08030000043','23 Zik Avenue','Enugu','Enugu','2026-04-15'),
('C00044','Ifeanyi','Nnamani','ifeanyi.nnamani@example.com','08030000044','9 Trans-Amadi Road','Port Harcourt','Rivers','2026-04-17'),
('C00045','Temitope','Ojo','temitope.ojo@example.com','08030000045','17 Lagos-Abeokuta Road','Ikeja','Lagos','2026-04-20'),
('C00046','Sadiq','Lawal','sadiq.lawal@example.com','08030000046','4 Garki Road','Garki','FCT','2026-04-22'),
('C00047','Victoria','James','victoria.james@example.com','08030000047','13 Udo Umana Road','Uyo','Akwa Ibom','2026-04-25'),
('C00048','Oghenekaro','Efe','oghenekaro.efe@example.com','08030000048','20 Warri-Sapele Road','Warri','Delta','2026-04-27'),
('C00049','Amina','Bukar','amina.bukar@example.com','08030000049','7 Maiduguri Road','Maiduguri','Borno','2026-05-01'),
('C00050','Kelechi','Okafor','kelechi.okafor@example.com','08030000050','29 Aba Road','Umuahia','Abia','2026-05-03');

go

create table products (
	ProductID varchar(10) primary key,
	ProductName varchar(150) not null,
	Category varchar(200) not null,
	Brand varchar(50) not null,
	Price decimal(12,2) not null check(Price > 0),
	StockQuantity int not null check(StockQuantity >= 0),
	WarrantyMonths int not null default 12,
	IsActive int not null default 1
);
go

;WITH
N AS (
    SELECT TOP (200) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
),
Categories AS (
    SELECT 1 AS CatID,'Smartphone' AS Category
    UNION ALL SELECT 2,'Laptop'
    UNION ALL SELECT 3,'Tablet'
    UNION ALL SELECT 4,'Audio'
    UNION ALL SELECT 5,'Accessories'
    UNION ALL SELECT 6,'Smart Home'
    UNION ALL SELECT 7,'Wearables'
),
Brands AS (
    SELECT 1 AS BrandID,'Samsung' AS Brand
    UNION ALL SELECT 2,'Apple'
    UNION ALL SELECT 3,'HP'
    UNION ALL SELECT 4,'Dell'
    UNION ALL SELECT 5,'Lenovo'
    UNION ALL SELECT 6,'ASUS'
    UNION ALL SELECT 7,'Sony'
    UNION ALL SELECT 8,'JBL'
    UNION ALL SELECT 9,'Anker'
    UNION ALL SELECT 10,'Xiaomi'
),
Base AS (
    SELECT
        N.n,
        ((N.n - 1) % 7) + 1 AS CatID,
        ((N.n - 1) % 10) + 1 AS BrandID
    FROM N
)
INSERT INTO Products
(ProductID, ProductName, Category, Brand, Price, StockQuantity, WarrantyMonths, IsActive)
SELECT
    CONCAT('P', RIGHT('000' + CAST(B.n AS VARCHAR(3)),3)),
    CONCAT(C.Category, ' ', Bn.Brand, ' Series ', B.n),
    C.Category,
    Bn.Brand,
    CAST(
        CASE C.Category
            WHEN 'Smartphone' THEN 180000 + ((B.n * 17391) % 900000)
            WHEN 'Laptop' THEN 300000 + ((B.n * 29731) % 1700000)
            WHEN 'Tablet' THEN 150000 + ((B.n * 19371) % 700000)
            WHEN 'Audio' THEN 25000 + ((B.n * 1371) % 350000)
            WHEN 'Accessories' THEN 5000 + ((B.n * 731) % 150000)
            WHEN 'Smart Home' THEN 18000 + ((B.n * 1431) % 250000)
            WHEN 'Wearables' THEN 30000 + ((B.n * 3371) % 350000)
        END AS DECIMAL(12,2)
    ),
    3 + ((B.n * 17) % 48),
    CASE
        WHEN C.Category = 'Accessories' THEN 6
        ELSE 12
    END,
    1
FROM Base B
JOIN Categories C ON C.CatID = B.CatID
JOIN Brands Bn ON Bn.BrandID = B.BrandID;
GO

select * from products

CREATE TABLE Orders (
    OrderID          VARCHAR(12) PRIMARY KEY,
    CustomerID       VARCHAR(10) NOT NULL,
    OrderDate        DATE NOT NULL,
    OrderStatus      VARCHAR(30) NOT NULL,
    PaymentStatus    VARCHAR(30) NOT NULL,
    ShippingAddress  VARCHAR(150) NOT NULL,
    City             VARCHAR(50) NOT NULL,
    State            VARCHAR(50) NOT NULL,
    TotalAmount      DECIMAL(14,2) NOT NULL CHECK (TotalAmount >= 0),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

;WITH N AS (
    SELECT TOP (500) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO Orders
(OrderID, CustomerID, OrderDate, OrderStatus, PaymentStatus,
 ShippingAddress, City, State, TotalAmount)
SELECT
    CONCAT('ORD', RIGHT('00000' + CAST(N.n AS VARCHAR(5)),5)),
    CONCAT('C', RIGHT('00000' + CAST(((N.n - 1) % 50) + 1 AS VARCHAR(5)),5)),
    DATEADD(DAY, -((N.n * 3) % 250), CAST('2026-10-01' AS DATE)),
    CASE
        WHEN N.n % 17 = 0 THEN 'Cancelled'
        WHEN N.n % 5 = 0 THEN 'Pending'
        WHEN N.n % 3 = 0 THEN 'Processing'
        WHEN N.n % 2 = 0 THEN 'Shipped'
        ELSE 'Delivered'
    END,
    CASE
        WHEN N.n % 17 = 0 THEN 'Refunded'
        WHEN N.n % 5 = 0 THEN 'Pending'
        ELSE 'Paid'
    END,
    C.AddressLine,
    C.City,
    C.State,
    CAST(5000 + ((N.n * 23891) % 495000) AS DECIMAL(14,2))
FROM N
JOIN Customers C
    ON C.CustomerID =
       CONCAT('C', RIGHT('00000' + CAST(((N.n - 1) % 50) + 1 AS VARCHAR(5)),5));
GO

select * from Orders

CREATE TABLE OrderItems (
    OrderItemID      INT IDENTITY(1,1) PRIMARY KEY,
    OrderID          VARCHAR(12) NOT NULL,
    ProductID        VARCHAR(10) NOT NULL,
    Quantity         INT NOT NULL CHECK (Quantity > 0),
    UnitPrice        DECIMAL(12,2) NOT NULL CHECK (UnitPrice > 0),

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

;WITH OrderNumbers AS (
    SELECT TOP (500)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
),
ItemNumbers AS (
    SELECT 1 AS item_no
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
)
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice)
SELECT
    CONCAT('ORD', RIGHT('00000' + CAST(O.n AS VARCHAR(5)),5)),
    CONCAT(
        'P',
        RIGHT(
            '000' +
            CAST((((O.n * 7) + (I.item_no * 13)) % 200) + 1 AS VARCHAR(3)),
            3
        )
    ),
    1 + ((O.n + I.item_no) % 3),
    P.Price
FROM OrderNumbers O
CROSS JOIN ItemNumbers I
JOIN Products P
    ON P.ProductID =
       CONCAT(
           'P',
           RIGHT(
               '000' +
               CAST((((O.n * 7) + (I.item_no * 13)) % 200) + 1 AS VARCHAR(3)),
               3
           )
       )
WHERE I.item_no <= 1 + (O.n % 4);
GO

select * from OrderItems

CREATE TABLE ApprovalRequests (
    ApprovalRequestID INT IDENTITY(1,1) PRIMARY KEY,
    RequestType       VARCHAR(30) NOT NULL,
    CustomerID        VARCHAR(10) NOT NULL,
    OrderID           VARCHAR(12) NULL,
    RequestedAmount   DECIMAL(14,2) NULL,
    RequestedPercent  DECIMAL(5,2) NULL,
    Reason            VARCHAR(500) NOT NULL,
    Status            VARCHAR(30) NOT NULL DEFAULT 'Pending',
    RequestedAt       DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    ReviewedAt        DATETIME2 NULL,
    ReviewedBy        VARCHAR(100) NULL,
    ReviewComment     VARCHAR(500) NULL,

    CONSTRAINT FK_Approval_Customers
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Approval_Orders
        FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
GO

/* =========================================================
   6. INDEXES
   ========================================================= */

CREATE INDEX IX_Orders_CustomerID
ON Orders(CustomerID);

CREATE INDEX IX_Orders_OrderStatus
ON Orders(OrderStatus);

CREATE INDEX IX_OrderItems_OrderID
ON OrderItems(OrderID);

CREATE INDEX IX_Products_Category
ON Products(Category);

CREATE INDEX IX_ApprovalRequests_Status
ON ApprovalRequests(Status);
GO


SELECT
    i.name AS IndexName,
    t.name AS TableName,
    i.type_desc AS IndexType
FROM sys.indexes i
JOIN sys.tables t
    ON i.object_id = t.object_id
WHERE t.name IN ('Orders', 'OrderItems', 'Products', 'ApprovalRequests')
ORDER BY t.name, i.name;

/* =========================================================
   7. VALIDATION
   ========================================================= */

SELECT 'Customers' AS TableName, COUNT(*) AS Row_Count FROM Customers
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderItems', COUNT(*) FROM OrderItems
UNION ALL
SELECT 'ApprovalRequests', COUNT(*) FROM ApprovalRequests;
GO

/* =========================================================
   8. USEFUL TEST QUERIES
   ========================================================= */

-- A. Show one customer's orders
SELECT *
FROM Orders
WHERE CustomerID = 'C00012'
ORDER BY OrderDate DESC;
GO

-- B. Get the details of one order
SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.OrderStatus,
    o.PaymentStatus,
    p.ProductName,
    p.Category,
    oi.Quantity,
    oi.UnitPrice,
    oi.Quantity * oi.UnitPrice AS LineTotal
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.OrderID = 'ORD00025';
GO

-- C. SECURE CUSTOMER ORDER LOOKUP
-- The logged-in customer ID must be supplied.
DECLARE @LoggedInCustomerID VARCHAR(10) = 'C00012';
DECLARE @OrderID VARCHAR(12) = 'ORD00025';

SELECT
    OrderID,
    OrderDate,
    OrderStatus,
    PaymentStatus,
    TotalAmount
FROM Orders
WHERE OrderID = @OrderID
  AND CustomerID = @LoggedInCustomerID;
GO

-- D. Products that are running low on stock
SELECT
    ProductID,
    ProductName,
    Category,
    StockQuantity
FROM Products
WHERE StockQuantity <= 10
ORDER BY StockQuantity;
GO

-- E. Orders above ₦150,000
SELECT
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount
FROM Orders
WHERE TotalAmount >= 150000
ORDER BY TotalAmount DESC;
GO

CREATE TABLE RefundRequests (
    RequestID   INT IDENTITY(1,1) PRIMARY KEY,
    OrderID     VARCHAR(20) NOT NULL,
    CustomerID  VARCHAR(20) NOT NULL,
    Reason      VARCHAR(500),
    OrderStatus      VARCHAR(20) NOT NULL DEFAULT 'pending',
    RequestedAt DATETIME NOT NULL
);

exec sp_rename 'RefundRequests.OrderStatus', 'Status', 'COLUMN';
sELECT * FROM Orders;

select * from RefundRequests

SELECT DISTINCT OrderStatus FROM Orders