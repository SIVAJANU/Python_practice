
--Chapter 7: SQL Constraints
----https://medium.com/data-engineers-notes/bigquery-primary-key-foreign-key-constraints-593d53be380
--🧩 Explanation for Beginners
-- PRIMARY KEY → uniquely identifies each row. EmpID is a good example.

-- FOREIGN KEY → links one table to another (relationship).

-- UNIQUE → ensures no duplicate values in a column.

-- NOT NULL → column must always have a value.

-- CHECK → enforces a condition (e.g., Salary > 0).

-- DEFAULT → auto‑fills a value if none is provided.

-- Use Practice1 database
USE PracticeDB1;

---------------------------------------------------
-- Step 1: Create table with constraints
---------------------------------------------------
CREATE TABLE EmployeesWithConstraints (
    EmpID INT PRIMARY KEY,                  -- PRIMARY KEY: unique identifier
    EmpName VARCHAR(100) NOT NULL,          -- NOT NULL: cannot be empty
    Department VARCHAR(50),
    Salary DECIMAL(10,2) CHECK (Salary > 0),-- CHECK: must be positive
    HireDate DATE DEFAULT GETDATE(),        -- DEFAULT: auto-fill with current date
    Email VARCHAR(100) UNIQUE               -- UNIQUE: no duplicate values allowed
);

CREATE TABLE Order_Items (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    PRIMARY KEY (OrderID, ProductID) -- Grouped as a single composite primary key
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,              -- The designated single primary key
    Email VARCHAR(255) NOT NULL UNIQUE,  -- Acts like a secondary primary key
    Username VARCHAR(50) NOT NULL
);

---------------------------------------------------
-- Step 2: Insert sample data
---------------------------------------------------
-- Valid insert
INSERT INTO EmployeesWithConstraints (EmpID, EmpName, Department, Salary, Email)
VALUES (1, 'John', 'IT', 55000.00, 'john@example.com');

-- Another valid insert (HireDate auto-filled by DEFAULT)
INSERT INTO select * from EmployeesWithConstraints (EmpID, EmpName, Department, Salary, Email)
VALUES (2, 'Alice', 'HR', 45000.00, 'alice@example.com');

-- Attempting invalid insert (Salary <= 0 will fail CHECK constraint)
-- INSERT INTO EmployeesWithConstraints (EmpID, EmpName, Department, Salary, Email)
-- VALUES (3, 'Bob', 'Finance', -1000.00, 'bob@example.com');

-- Attempting invalid insert (duplicate Email will fail UNIQUE constraint)
-- INSERT INTO EmployeesWithConstraints (EmpID, EmpName, Department, Salary, Email)
-- VALUES (4, 'Charlie', 'IT', 60000.00, 'john@example.com');

---------------------------------------------------
-- Step 3: Create another table with FOREIGN KEY
---------------------------------------------------
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) UNIQUE
);

-- Insert sample departments
INSERT INTO Departments (DeptID, DeptName)
VALUES (10, 'IT'), (20, 'HR'), (30, 'Finance');

-- Create Employees table with FOREIGN KEY reference
CREATE TABLE EmployeesFK (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    DeptID INT,
    CONSTRAINT FK_Dept FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

-- Insert valid employee (DeptID exists in Departments)
INSERT INTO EmployeesFK (EmpID, EmpName, DeptID)
VALUES (101, 'David', 10);

-- Attempting invalid insert (DeptID not in Departments will fail FOREIGN KEY constraint)
-- INSERT INTO EmployeesFK (EmpID, EmpName, DeptID)
-- VALUES (102, 'Emma', 99);
