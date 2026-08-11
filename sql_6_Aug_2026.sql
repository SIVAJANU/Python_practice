# chapter 6: SQL Joins and Subqueries
-- Use PracticeDB1 database
USE PracticeDB1;

---------------------------------------------------
-- Step 1: Create Employee table
---------------------------------------------------
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE,
    Address VARCHAR(200)
);

-- Insert sample employees
INSERT INTO Employee (EmpID, EmpName, Department, Salary, HireDate, Address)
VALUES
(1, 'John', 'IT', 55000.00, '2024-01-15', 'Hyderabad'),
(2, 'Alice', 'HR', 45000.00, '2023-11-20', 'Bangalore'),
(3, 'Bob', 'Finance', 60000.00, '2022-05-10', 'Chennai'),
(4, 'Charlie', 'IT', 70000.00, '2025-03-05', 'Delhi'),
(5, 'Diana', 'Marketing', 48000.00, '2024-07-01', 'Mumbai'),
(6, 'Ethan', 'Finance', 52000.00, '2023-09-12', 'Pune'),
(7, 'Fiona', 'HR', 47000.00, '2025-01-25', 'Hyderabad'),
(8, 'George', 'IT', 65000.00, '2022-12-30', 'Chennai');

---------------------------------------------------
-- Step 2: Create Orders table
---------------------------------------------------
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    EmpID INT,              -- Foreign key to Employee table
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

-- Insert sample orders
INSERT INTO Orders (OrderID, EmpID, OrderDate, Amount)
VALUES
(101, 1, '2025-01-15', 2000.00),
(102, 2, '2025-02-10', 1500.00),
(103, 3, '2025-03-05', 3000.00),
(104, 1, '2025-04-20', 2500.00),
(105, 5, '2025-05-18', 1800.00);

---------------------------------------------------
-- Step 3: Practice Joins
---------------------------------------------------

-- INNER JOIN: Only employees who have placed orders
SELECT e.EmpID, e.EmpName, o.OrderID, o.Amount
FROM Employee e
INNER JOIN Orders o ON e.EmpID = o.EmpID;

-- LEFT JOIN: All employees, even those with no orders
SELECT e.EmpID, e.EmpName, o.OrderID, o.Amount
FROM Employee e
LEFT JOIN Orders o ON e.EmpID = o.EmpID;

-- RIGHT JOIN: All orders, even if employee record is missing
SELECT e.EmpID, e.EmpName, o.OrderID, o.Amount
FROM Employee e
RIGHT JOIN Orders o ON e.EmpID = o.EmpID;

-- FULL OUTER JOIN: All employees and all orders, matched where possible
SELECT e.EmpID, e.EmpName, o.OrderID, o.Amount
FROM Employee e
FULL OUTER JOIN Orders o ON e.EmpID = o.EmpID;

-- SELF JOIN: Compare employees in same department
SELECT e1.EmpName AS Employee1, e2.EmpName AS Employee2, e1.Department
FROM Employee e1
INNER JOIN Employee e2 ON e1.Department = e2.Department
WHERE e1.EmpID <> e2.EmpID;

-- CROSS JOIN: Every employee paired with every order (Cartesian product)
SELECT e.EmpName, o.OrderID
FROM Employee e
CROSS JOIN Orders o;
