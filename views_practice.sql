-- =====================================================
-- SQL Practice: Views
-- Topics covered:
-- 1. Creating views (CREATE VIEW)
-- 2. Updating views
-- 3. Dropping views
-- 4. Materialized views (in some RDBMS)
-- =====================================================

-- =========================================
-- 1) Creating views (CREATE VIEW)
-- =========================================

/*
A view is a virtual table based on the result of a query.
It does not store data itself, but presents data from one or more tables.

Uses of views:
- Simplify complex queries
- Restrict access to sensitive data
- Standardize common query logic
- Improve readability and maintainability
*/

-- Example tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    City VARCHAR(50)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- Insert sample data
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, City)
VALUES
(1, 'Amit', 'Sharma', 10, 55000, 'Delhi'),
(2, 'Neha', 'Verma', 20, 62000, 'Mumbai'),
(3, 'Rohit', 'Singh', 10, 48000, 'Delhi'),
(4, 'Priya', 'Patel', 30, 71000, 'Bengaluru');

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(10, 'Engineering'),
(20, 'HR'),
(30, 'Finance');

-- Create a simple view
CREATE VIEW vw_EmployeeDetails AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    e.Salary,
    e.City
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query the view
SELECT *
FROM vw_EmployeeDetails;

-- Create a view with filtered rows
CREATE VIEW vw_HighSalaryEmployees AS
SELECT *
FROM Employees
WHERE Salary > 50000;

SELECT *
FROM vw_HighSalaryEmployees;

-- =========================================
-- 2) Updating views
-- =========================================

/*
Some views are updatable, meaning you can run INSERT, UPDATE, or DELETE on them.
This depends on the database system and the view definition.

A view is usually updatable if:
- It is based on a single table
- It does not use aggregate functions
- It does not have DISTINCT, GROUP BY, HAVING, or UNION
- It does not include complex joins in some databases
*/

-- Simple updatable view
CREATE VIEW vw_EmployeeNames AS
SELECT
    EmployeeID,
    FirstName,
    LastName
FROM Employees;

-- Update data through the view
UPDATE vw_EmployeeNames
SET LastName = 'Kumar'
WHERE EmployeeID = 1;

-- Insert data through the view
INSERT INTO vw_EmployeeNames (EmployeeID, FirstName, LastName)
VALUES (5, 'Sonia', 'Mehta');

-- Delete data through the view
DELETE FROM vw_EmployeeNames
WHERE EmployeeID = 5;

-- Query final data
SELECT *
FROM vw_EmployeeNames;

-- Example of a non-updatable view
CREATE VIEW vw_EmployeeSalarySummary AS
SELECT
    DepartmentID,
    AVG(Salary) AS AvgSalary,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

-- This may not allow direct INSERT / UPDATE / DELETE
-- UPDATE vw_EmployeeSalarySummary SET AvgSalary = 60000 WHERE DepartmentID = 10;

-- =========================================
-- 3) Dropping views
-- =========================================

/*
DROP VIEW removes a view from the database.
*/

DROP VIEW vw_EmployeeNames;
DROP VIEW vw_EmployeeDetails;
DROP VIEW vw_HighSalaryEmployees;
DROP VIEW vw_EmployeeSalarySummary;

-- Some databases use:
-- DROP VIEW IF EXISTS vw_EmployeeDetails;

-- =========================================
-- 4) Materialized views (in some RDBMS)
-- =========================================

/*
A materialized view stores the query result physically, unlike a regular view.
It is useful when a query is expensive and the underlying data changes infrequently.

Differences from standard views:
- Regular view: computes result every time you query it
- Materialized view: stores a snapshot of data and refreshes periodically or manually

Common database support:
- PostgreSQL: supports materialized views
- Oracle: supports materialized views
- SQL Server: uses indexed views, not exactly materialized view as in Oracle/PostgreSQL
*/

-- PostgreSQL example:
-- CREATE MATERIALIZED VIEW mv_EmployeeSummary AS
-- SELECT
--     DepartmentID,
--     COUNT(*) AS TotalEmployees,
--     AVG(Salary) AS AvgSalary
-- FROM Employees
-- GROUP BY DepartmentID;

-- Query materialized view:
-- SELECT * FROM mv_EmployeeSummary;

-- Refresh materialized view:
-- REFRESH MATERIALIZED VIEW mv_EmployeeSummary;

-- Drop materialized view:
-- DROP MATERIALIZED VIEW mv_EmployeeSummary;

-- SQL Server indexed view example:
-- CREATE VIEW dbo.vw_EmployeeSummary
-- WITH SCHEMABINDING AS
-- SELECT DepartmentID, COUNT_BIG(*) AS TotalEmployees, AVG(Salary) AS AvgSalary
-- FROM dbo.Employees
-- GROUP BY DepartmentID;
-- GO

-- -- Create unique clustered index on the view
-- CREATE UNIQUE CLUSTERED INDEX IX_vw_EmployeeSummary
-- ON dbo.vw_EmployeeSummary(DepartmentID);

-- =========================================
-- Example practice workflow
-- =========================================

CREATE VIEW vw_DepartmentEmployeeCount AS
SELECT
    d.DepartmentID,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS TotalEmployees
FROM Departments d
LEFT JOIN Employees e
    ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;

SELECT *
FROM vw_DepartmentEmployeeCount;

-- Drop the practice view
DROP VIEW vw_DepartmentEmployeeCount;

-- =========================================
-- Quick Summary
-- =========================================

/*
- CREATE VIEW creates a virtual table from a query.
- Views can simplify logic and restrict access.
- Some views are updatable; others are not depending on the query.
- DROP VIEW removes a view.
- Materialized views store query results physically and require refresh.
- Use views for abstraction and security; use materialized views when performance matters.
*/
