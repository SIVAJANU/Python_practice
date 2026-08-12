--Chapter 8: SQL Subqueries
-- Use Practice1 database

-- 🧩 Beginner Explanation
-- Single-row subquery → returns one value (e.g., average salary).

-- Multi-row subquery → returns multiple values, used with IN, ANY, ALL.

-- Correlated subquery → inner query depends on outer query row.

-- EXISTS → checks if a matching record exists, returns TRUE/FALSE.

-- 🧩 Beginner Explanation
-- IN → compares a value against a list returned by the subquery.

-- EXISTS → checks if at least one matching row exists (row‑by‑row evaluation).

-- Both can give the same result, but internally:

-- IN builds a list of values first, then compares.

-- EXISTS stops as soon as it finds a match, often more efficient.
--Run the IN and EXISTS queries separately, show the identical output, then explain how SQL Server processes them differently. This helps beginners understand why both exist and when one might be faster.


-- Use Practice1 database
USE Practice1;

---------------------------------------------------
-- Step 1: Setup sample tables
---------------------------------------------------
-- Employee table (already exists, but recreate for clarity)
CREATE TABLE EmployeeSub (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO EmployeeSub (EmpID, EmpName, Department, Salary, HireDate)
VALUES
(1, 'John', 'IT', 55000.00, '2024-01-15'),
(2, 'Alice', 'HR', 45000.00, '2023-11-20'),
(3, 'Bob', 'Finance', 60000.00, '2022-05-10'),
(4, 'Charlie', 'IT', 70000.00, '2025-03-05'),
(5, 'Diana', 'Marketing', 48000.00, '2024-07-01');

-- Orders table
CREATE TABLE OrdersSub (
    OrderID INT PRIMARY KEY,
    EmpID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO OrdersSub (OrderID, EmpID, OrderDate, Amount)
VALUES
(101, 1, '2025-01-15', 2000.00),
(102, 2, '2025-02-10', 1500.00),
(103, 3, '2025-03-05', 3000.00),
(104, 1, '2025-04-20', 2500.00),
(105, 5, '2025-05-18', 1800.00);

---------------------------------------------------
-- Step 2: Subquery Examples
---------------------------------------------------

-- 1. Single-row subquery
-- Find employees whose salary is greater than the average salary
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > (SELECT AVG(Salary) FROM EmployeeSub);

-- 2. Multi-row subquery (IN)
-- Find employees who have placed orders
SELECT EmpName
FROM EmployeeSub
WHERE EmpID IN (SELECT EmpID FROM OrdersSub);

-- 3. Multi-row subquery (ANY / ALL)
-- Find employees whose salary is greater than ANY order amount
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > ANY (SELECT Amount FROM OrdersSub);

-- Find employees whose salary is greater than ALL order amounts
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > ALL (SELECT Amount FROM OrdersSub);

-- 4. Correlated subquery
-- Find employees who have at least one order greater than 2000
SELECT EmpName
FROM EmployeeSub e
WHERE EXISTS (
    SELECT 1
    FROM OrdersSub o
    WHERE o.EmpID = e.EmpID AND o.Amount > 2000
);

-- 5. EXISTS operator
-- List employees who have placed orders (similar to IN but more efficient)
SELECT EmpName
FROM EmployeeSub e
WHERE EXISTS (
    SELECT 1
    FROM OrdersSub o
    WHERE o.EmpID = e.EmpID
);




--------------More practice on IN and EXISTS
-- Use Practice1 database
USE Practice1;

---------------------------------------------------
-- Step 1: Setup sample tables
---------------------------------------------------
CREATE TABLE EmployeeSub (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO EmployeeSub (EmpID, EmpName, Department, Salary)
VALUES
(1, 'John', 'IT', 55000.00),
(2, 'Alice', 'HR', 45000.00),
(3, 'Bob', 'Finance', 60000.00),
(4, 'Charlie', 'IT', 70000.00),
(5, 'Diana', 'Marketing', 48000.00);

CREATE TABLE OrdersSub (
    OrderID INT PRIMARY KEY,
    EmpID INT,
    Amount DECIMAL(10,2)
);

INSERT INTO OrdersSub (OrderID, EmpID, Amount)
VALUES
(101, 1, 2000.00),
(102, 2, 1500.00),
(103, 3, 3000.00),
(104, 1, 2500.00),
(105, 5, 1800.00);

---------------------------------------------------
-- Step 2: Subquery Examples
---------------------------------------------------

-- 1. Single-row subquery
-- Find employees earning more than the average salary
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > (SELECT AVG(Salary) FROM EmployeeSub);

-- 2. Multi-row subquery (IN)
-- Find employees who have placed orders
SELECT EmpName
FROM EmployeeSub
WHERE EmpID IN (SELECT EmpID FROM OrdersSub);

-- 3. Multi-row subquery (EXISTS)
-- Same logic as above, but EXISTS checks row-by-row
SELECT EmpName
FROM EmployeeSub e
WHERE EXISTS (
    SELECT 1
    FROM OrdersSub o
    WHERE o.EmpID = e.EmpID
);

-- 4. Correlated subquery
-- Find employees who have at least one order greater than 2000
SELECT EmpName
FROM EmployeeSub e
WHERE EXISTS (
    SELECT 1
    FROM OrdersSub o
    WHERE o.EmpID = e.EmpID AND o.Amount > 2000
);

-- 5. ANY / ALL examples
-- Salary greater than ANY order amount
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > ANY (SELECT Amount FROM OrdersSub);

-- Salary greater than ALL order amounts
SELECT EmpName, Salary
FROM EmployeeSub
WHERE Salary > ALL (SELECT Amount FROM OrdersSub);
