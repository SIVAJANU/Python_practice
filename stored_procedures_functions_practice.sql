-- =====================================================
-- SQL Practice: Stored Procedures & Functions
-- Topics covered:
-- 1. Creating stored procedures (CREATE PROCEDURE)
-- 2. Parameters (IN, OUT)
-- 3. User-defined functions (UDFs)
-- 4. Advantages & use cases
-- =====================================================

-- =========================================
-- 1) Creating stored procedures (CREATE PROCEDURE)
-- =========================================

/*
Stored Procedure:
- A reusable SQL block stored in the database.
- Can accept input parameters and return output.
- Often used for business logic, data processing, and repetitive operations.

Advantages:
- Reusable
- Centralizes logic
- Improves performance through precompilation in some DBMS
- Better security control
*/

-- Example table
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
(4, 'Priya', 'Patel', 30, 72000);

-- Simple stored procedure example
CREATE PROCEDURE GetAllEmployees AS
BEGIN
SELECT *
FROM Employees;
END;

-- Execute stored procedure
EXEC GetAllEmployees;

-- Stored procedure with input parameter
CREATE PROCEDURE GetEmployeesByDepartment @DepartmentID INT AS
BEGIN
SELECT *
FROM Employees
WHERE DepartmentID = @DepartmentID;
END;

EXEC GetEmployeesByDepartment @DepartmentID = 10;

-- =========================================
-- 2) Parameters (IN, OUT)
-- =========================================

/*
Parameter types vary by database system.
Common examples:
- IN: input parameter
- OUT: output parameter
- INOUT: both input and output

Example syntax differs across DBMS.
This file uses SQL Server-style syntax as a common example.
*/

-- Procedure with OUT parameter
CREATE PROCEDURE GetEmployeeCountByDepartment
@DepartmentID INT,
@EmployeeCount INT OUTPUT
AS
BEGIN
SELECT @EmployeeCount = COUNT(*)
FROM Employees
WHERE DepartmentID = @DepartmentID;
END;

DECLARE @Count INT;
EXEC GetEmployeeCountByDepartment @DepartmentID = 10, @EmployeeCount = @Count OUTPUT;
SELECT @Count AS EmployeeCount;

-- MySQL / PostgreSQL style example:
-- CREATE PROCEDURE GetEmployeeCountByDepartment(IN p_department_id INT, OUT p_employee_count INT)
-- BEGIN
--     SELECT COUNT(*) INTO p_employee_count
--     FROM Employees
--     WHERE DepartmentID = p_department_id;
-- END;

-- =========================================
-- 3) User-defined functions (UDFs)
-- =========================================

/*
User-defined functions (UDFs) return a value and can be used in SQL expressions.
Types:
- Scalar function: returns one value
- Table-valued function: returns a table

Use cases:
- Formatting logic
- Reusable calculation logic
- Derived columns
*/

-- Scalar function example
CREATE FUNCTION GetAnnualSalary (@MonthlySalary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
RETURN @MonthlySalary * 12;
END;

SELECT EmployeeID, FirstName, LastName, Salary, dbo.GetAnnualSalary(Salary) AS AnnualSalary
FROM Employees;

-- Table-valued function example
CREATE FUNCTION GetEmployeesByDept (@DepartmentID INT)
RETURNS TABLE
AS
RETURN
(
SELECT EmployeeID, FirstName, LastName, Salary
FROM Employees
WHERE DepartmentID = @DepartmentID
);

SELECT *
FROM dbo.GetEmployeesByDept(10);

-- =========================================
-- 4) Advantages & use cases
-- =========================================

/*
Advantages of stored procedures:
- Encapsulate business rules
- Improve code reuse
- Reduce network traffic
- Centralize logic
- Improve maintainability

Advantages of UDFs:
- Reusable calculations
- Can be called in SELECT statements
- Simplify complex expressions

Use cases:
- Payroll calculations
- Order validation
- Report generation
- Authorization checks
- Data cleanup and transformation
*/

-- Example use case: validation procedure
CREATE PROCEDURE AddEmployee
@EmployeeID INT,
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@DepartmentID INT,
@Salary DECIMAL(10,2)
AS
BEGIN
IF @Salary <= 0
BEGIN
    PRINT 'Salary must be greater than zero.';
    RETURN;
END;

INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary)
VALUES (@EmployeeID, @FirstName, @LastName, @DepartmentID, @Salary);
END;

-- Execute
EXEC AddEmployee @EmployeeID = 5, @FirstName = 'Karan', @LastName = 'Joshi', @DepartmentID = 20, @Salary = 60000;

SELECT * FROM Employees;

-- =========================================
-- Quick Summary
-- =========================================

/*
- Stored procedures are reusable SQL blocks.
- Parameters can be IN, OUT, or INOUT depending on the DBMS.
- UDFs return a value or table and are used in SQL expressions.
- Use procedures for logic and workflows; use functions for calculations and reusable logic.
*/
