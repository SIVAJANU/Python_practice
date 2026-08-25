-- =====================================================
-- SQL Practice: Industry Use Cases
-- Topics covered:
-- 1. Writing queries for reports (Sales, Finance, HR)
-- 2. Data cleaning with SQL
-- 3. ETL support with SQL
-- 4. Analytics queries
-- =====================================================

-- =========================================
-- 1) Writing queries for reports (Sales, Finance, HR)
-- =========================================

/*
SQL is heavily used in business reporting and analytics.
Typical departments:
- Sales: monthly revenue, top customers, product performance
- Finance: revenue, expenses, invoices, reconciliations
- HR: headcount, attrition, department-wise salaries, hiring trends
*/

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    SalesDate DATE,
    Region VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    JoiningDate DATE
);

INSERT INTO Sales (SaleID, ProductName, SalesDate, Region, Quantity, UnitPrice)
VALUES
(1, 'Laptop', '2026-01-05', 'North', 2, 50000),
(2, 'Phone', '2026-01-10', 'South', 10, 20000),
(3, 'Laptop', '2026-02-15', 'North', 1, 50000),
(4, 'Tablet', '2026-02-20', 'East', 4, 15000),
(5, 'Phone', '2026-03-01', 'West', 8, 20000);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, JoiningDate)
VALUES
(1, 'Amit', 'Sharma', 'HR', 60000, '2021-05-01'),
(2, 'Neha', 'Verma', 'IT', 75000, '2022-03-12'),
(3, 'Rohit', 'Singh', 'Finance', 68000, '2020-08-20'),
(4, 'Priya', 'Patel', 'HR', 62000, '2023-01-10');

-- Sales report: monthly revenue
SELECT
    MONTH(SalesDate) AS SalesMonth,
    YEAR(SalesDate) AS SalesYear,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY YEAR(SalesDate), MONTH(SalesDate)
ORDER BY SalesYear, SalesMonth;

-- Finance-style summary: total sales by region
SELECT Region, SUM(Quantity * UnitPrice) AS TotalSales
FROM Sales
GROUP BY Region
ORDER BY TotalSales DESC;

-- HR report: department-wise average salary
SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- =========================================
-- 2) Data cleaning with SQL
-- =========================================

/*
Data cleaning is the process of identifying and fixing bad, missing, or inconsistent data.
Common tasks:
- Remove duplicates
- Standardize text casing
- Handle NULL values
- Fix invalid values
- Split/merge fields when necessary
*/

CREATE TABLE CustomerData (
    CustomerID INT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    Age INT
);

INSERT INTO CustomerData (CustomerID, CustomerName, Email, City, Age)
VALUES
(1, '  Alice  ', 'alice@gmail.com', 'Delhi', 28),
(2, 'bob', 'BOB@GMAIL.COM', 'Mumbai', NULL),
(2, 'bob', 'BOB@GMAIL.COM', 'Mumbai', NULL),
(3, 'Charlie', NULL, 'Bengaluru', 35),
(4, 'David ', 'david@yahoo.com', ' ', 40);

-- Remove extra spaces
SELECT TRIM(CustomerName) AS CleanName,
       LOWER(TRIM(Email)) AS CleanEmail,
       TRIM(City) AS CleanCity,
       Age
FROM CustomerData;

-- Find duplicates
SELECT CustomerName, Email, COUNT(*) AS DuplicateCount
FROM CustomerData
GROUP BY CustomerName, Email
HAVING COUNT(*) > 1;

-- Replace missing values
SELECT COALESCE(Email, 'unknown@email.com') AS Email,
       COALESCE(City, 'Unknown City') AS City,
       COALESCE(Age, 0) AS Age
FROM CustomerData;

-- Example of standardizing data using CASE
SELECT CustomerName,
       CASE
           WHEN Age IS NULL THEN 0
           ELSE Age
       END AS CleanAge
FROM CustomerData;

-- =========================================
-- 3) ETL support with SQL
-- =========================================

/*
ETL = Extract, Transform, Load.
SQL is commonly used in staging and transformation logic.
Typical tasks:
- Extract raw data from source tables
- Clean and transform values
- Load into warehouse or reporting table
- Combine records from multiple sources
*/

CREATE TABLE RawOrders (
    RawOrderID INT,
    RawCustomerName VARCHAR(100),
    RawOrderValue VARCHAR(50),
    RawOrderDate VARCHAR(50)
);

INSERT INTO RawOrders (RawOrderID, RawCustomerName, RawOrderValue, RawOrderDate)
VALUES
(1, 'Alice', '1500', '2026-01-01'),
(2, 'bob', '2200', '2026-01-02'),
(3, 'Charlie', 'N/A', '2026-01-03');

-- ETL-style transformation example
SELECT
    RawOrderID,
    UPPER(TRIM(RawCustomerName)) AS CustomerName,
    CASE
        WHEN RawOrderValue = 'N/A' THEN 0
        ELSE CAST(RawOrderValue AS DECIMAL(10,2))
    END AS OrderValue,
    CAST(RawOrderDate AS DATE) AS OrderDate
FROM RawOrders;

-- Load cleaned data into a target table (conceptual)
-- INSERT INTO FinalOrders (OrderID, CustomerName, OrderValue, OrderDate)
-- SELECT ...

-- =========================================
-- 4) Analytics queries
-- =========================================

/*
Analytics queries are used for business intelligence and trend analysis.
They often combine grouping, filters, joins, and aggregations.
*/

-- Top products by revenue
SELECT
    ProductName,
    SUM(Quantity * UnitPrice) AS Revenue
FROM Sales
GROUP BY ProductName
ORDER BY Revenue DESC;

-- Monthly trend analysis
SELECT
    YEAR(SalesDate) AS SalesYear,
    MONTH(SalesDate) AS SalesMonth,
    SUM(Quantity * UnitPrice) AS MonthlyRevenue
FROM Sales
GROUP BY YEAR(SalesDate), MONTH(SalesDate)
ORDER BY SalesYear, SalesMonth;

-- Department salary distribution
SELECT Department, COUNT(*) AS EmployeeCount, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Department;

-- Example of rolling analytics using window functions
SELECT
    EmployeeID,
    FirstName,
    Salary,
    AVG(Salary) OVER () AS OverallAverageSalary
FROM Employees;

-- =========================================
-- Quick Summary
-- =========================================

/*
- SQL powers sales, finance, and HR reporting.
- Data cleaning removes duplicates, nulls, and inconsistent values.
- ETL workloads use SQL for extraction, transformation, and loading.
- Analytics queries summarize business performance and support decision-making.
*/
