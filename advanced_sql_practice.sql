-- =====================================================
-- SQL Practice: Advanced SQL
-- Topics covered:
-- 1. Window Functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE)
-- 2. OVER() and Partitioning
-- 3. CTE (Common Table Expressions) with WITH clause
-- 4. Recursive CTEs
-- 5. Pivoting & Unpivoting
-- 6. Dynamic SQL
-- =====================================================

-- =========================================
-- 1) Window Functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE)
-- =========================================

/*
Window functions are used to calculate values over a set of rows related to the current row.
Unlike aggregate functions, they do not collapse rows.

Common window functions:
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- NTILE(n)
*/

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES
(1, 'Amit', 'Sharma', 10, 50000),
(2, 'Neha', 'Verma', 20, 65000),
(3, 'Rohit', 'Singh', 10, 48000),
(4, 'Priya', 'Patel', 30, 72000),
(5, 'Karan', 'Kumar', 20, 62000),
(6, 'Sonia', 'Mehta', 30, 68000);

-- ROW_NUMBER: assign unique sequence number to rows
SELECT
    EmployeeID,
    FirstName,
    Salary,
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM Employees;

-- RANK: same salary gets same rank, next rank skips numbers
SELECT
    EmployeeID,
    FirstName,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS RankVal
FROM Employees;

-- DENSE_RANK: no gaps between ranks
SELECT
    EmployeeID,
    FirstName,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRankVal
FROM Employees;

-- NTILE: split rows into equal-sized groups
SELECT
    EmployeeID,
    FirstName,
    Salary,
    NTILE(3) OVER (ORDER BY Salary DESC) AS QuartileGroup
FROM Employees;

-- =========================================
-- 2) OVER() and Partitioning
-- =========================================

/*
OVER() defines the window over which the calculation is performed.
PARTITION BY divides the result set into groups.
*/

-- Example: rank employees within each department
SELECT
    EmployeeID,
    FirstName,
    DepartmentID,
    Salary,
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DeptRowNo,
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DeptRank
FROM Employees;

-- Example: department-wise average salary
SELECT
    EmployeeID,
    FirstName,
    DepartmentID,
    Salary,
    AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalaryByDept
FROM Employees;

-- =========================================
-- 3) CTE (Common Table Expressions) with WITH clause
-- =========================================

/*
CTE is a temporary named result set that exists only for the duration of the query.
Useful for readability and breaking a query into steps.
*/

WITH HighSalaryEmployees AS (
    SELECT EmployeeID, FirstName, LastName, Salary
    FROM Employees
    WHERE Salary > 60000
)
SELECT *
FROM HighSalaryEmployees;

-- CTE with multiple steps
WITH DeptSummary AS (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT d.DepartmentID, d.AvgSalary
FROM DeptSummary d
WHERE d.AvgSalary > 60000;

-- =========================================
-- 4) Recursive CTEs
-- =========================================

/*
A recursive CTE repeatedly references itself until a termination condition is reached.
Commonly used for hierarchical data (employee-manager, tree structures, dates).
*/

CREATE TABLE EmployeeHierarchy (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT NULL
);

INSERT INTO EmployeeHierarchy (EmployeeID, EmployeeName, ManagerID)
VALUES
(1, 'CEO', NULL),
(2, 'Manager A', 1),
(3, 'Manager B', 1),
(4, 'Developer 1', 2),
(5, 'Developer 2', 2),
(6, 'Developer 3', 3);

WITH RecursiveOrg AS (
    SELECT EmployeeID, EmployeeName, ManagerID, 0 AS Level
    FROM EmployeeHierarchy
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT e.EmployeeID, e.EmployeeName, e.ManagerID, r.Level + 1
    FROM EmployeeHierarchy e
    INNER JOIN RecursiveOrg r ON e.ManagerID = r.EmployeeID
)
SELECT *
FROM RecursiveOrg;

-- =========================================
-- 5) Pivoting & Unpivoting
-- =========================================

/*
Pivoting converts rows into columns.
Unpivoting converts columns into rows.
*/

CREATE TABLE Sales (
    SalesPerson VARCHAR(50),
    SalesMonth VARCHAR(20),
    SalesAmount INT
);

INSERT INTO Sales (SalesPerson, SalesMonth, SalesAmount)
VALUES
('Alice', 'Jan', 200),
('Alice', 'Feb', 250),
('Bob', 'Jan', 180),
('Bob', 'Feb', 300);

-- Pivot example (conceptual SQL Server style)
-- SELECT *
-- FROM (
--     SELECT SalesPerson, SalesMonth, SalesAmount
--     FROM Sales
-- ) AS src
-- PIVOT (
--     SUM(SalesAmount)
--     FOR SalesMonth IN ([Jan], [Feb])
-- ) AS pvt;

-- Unpivot example (conceptual SQL Server style)
-- SELECT SalesPerson, SalesMonth, SalesAmount
-- FROM (
--     SELECT SalesPerson, [Jan], [Feb]
--     FROM (
--         SELECT SalesPerson, SalesMonth, SalesAmount
--         FROM Sales
--     ) src
--     PIVOT (SUM(SalesAmount) FOR SalesMonth IN ([Jan], [Feb])) pvt
-- ) t
-- UNPIVOT (
--     SalesAmount FOR SalesMonth IN ([Jan], [Feb])
-- ) u;

-- =========================================
-- 6) Dynamic SQL
-- =========================================

/*
Dynamic SQL builds SQL statements at runtime.
Common when table names, filters, or columns vary based on user input.

Risk:
- SQL injection if user input is not properly sanitized.
*/

DECLARE @SQL NVARCHAR(MAX);
DECLARE @DepartmentID INT;

SET @DepartmentID = 10;
SET @SQL = N'SELECT * FROM Employees WHERE DepartmentID = ' + CAST(@DepartmentID AS NVARCHAR(10));

EXEC sp_executesql @SQL;

-- Safer parameterized dynamic SQL example
DECLARE @SQL2 NVARCHAR(MAX);
DECLARE @Dept INT = 20;

SET @SQL2 = N'SELECT * FROM Employees WHERE DepartmentID = @DeptID';
EXEC sp_executesql @SQL2, N'@DeptID INT', @DeptID = @Dept;

-- =========================================
-- Quick Summary
-- =========================================

/*
- Window functions add ranking and aggregate calculations without collapsing rows.
- OVER() and PARTITION BY divide rows into logical groups for calculations.
- CTEs improve query readability and allow step-by-step logic.
- Recursive CTEs are useful for hierarchical data.
- Pivot and unpivot transform row/column structure.
- Dynamic SQL is flexible but must be used carefully to avoid SQL injection.
*/
