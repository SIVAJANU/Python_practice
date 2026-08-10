---Prompt link: https://copilot.microsoft.com/shares/1iWchXVETNQWnxb6vPbys
---Chapter 5: SQL Aggregate and Scalar Functions

SELECT * FROM Employee
INSERT INTO Employee (EmpID, EmpName, Department, Salary, HireDate, Address)
VALUES
(11, 'John New', 'IT', 55000.00, '2024-01-15', 'Hyderabad'),
(12, 'Alice New', 'HR', 45000.00, '2023-11-20', 'Bangalore'),
(13, 'Bob New', 'Finance', 60000.00, '2022-05-10', 'Chennai'),
(14, 'Charlie New', 'IT', 70000.00, '2025-03-05', 'Delhi'),
(15, 'Diana New', 'Marketing', 48000.00, '2024-07-01', 'Mumbai'),
(16, 'Ethan New', 'Finance', 52000.00, '2023-09-12', 'Pune'),
(17, 'Fiona New', 'HR', 47000.00, '2025-01-25', 'Hyderabad'),
(18, 'George New', 'IT', 65000.00, '2022-12-30', 'Chennai'),
--random inserted data for Employee table
(111, 'John', 'IT', 55001.00, '2024-01-15', 'Hyderabad'),
(121, 'Alice', 'HR', 45001.00, '2023-11-20', 'Bangalore'),
(131, 'Bob', 'Finance', 60001.00, '2022-05-10', 'Chennai'),
(141, 'Charlie', 'IT', 70001.00, '2025-03-05', 'Delhi'),
(151, 'Diana', 'Marketing', 48001.00, '2024-07-01', 'Mumbai'),
(161, 'Ethan', 'Finance', 52001.00, '2023-09-12', 'Pune'),
(171, 'Fiona', 'HR', 47001.00, '2025-01-25', 'Hyderabad'),
(181, 'George', 'IT', 65001.00, '2022-12-30', 'Chennai');

----
---Aggregate Functions
-- Database is to store the data, manage the data, retrive the data and modify the data
--DB also proviode the security and any time access to data to the authorised users alone
--Databases have multiple objects (Tables, Views, Procedures, Functions etc)
-- Count employees
SELECT count(*)  FROM Employee; 1L profit   10 50000 =50k

-- Sum of salaries
SELECT SUM(Salary) AS TotalSalary FROM Employee;

-- Average salary
SELECT AVG(Salary) AS AverageSalary, SUM(Salary) AS TotalSalary FROM Employee;
SELECT 1041008.00/19;--54789.894736 --->54789.894736
SELECT 'Siva' + ' ' + 'Kumar' AS FullName;

-- Maximum salary
SELECT MAX(Salary) AS HighestSalary FROM Employee;

-- Minimum salary
SELECT MIN(Salary) AS LowestSalary FROM Employee;


--- Scalar Functions
-- Convert names to uppercase
SELECT EmpName, UPPER(EmpName) AS UpperName, LOWER(EmpName) AS LowerName FROM Employee;

-- Convert names to lowercase
SELECT EmpName, LOWER(EmpName) AS LowerName FROM Employee;

-- Length of employee names
SELECT EmpName, LEN(EmpName) AS NameLength FROM Employee;

-- Round salary to nearest thousand
SELECT EmpName, SALARY, ROUND(Salary, -3) AS RoundedSalary FROM Employee;

--- Get the current date and time
SELECT GETDATE() AS CurrentDateTime;

-- Current date & time
SELECT YEAR(GETDATE()) AS YEAR_, MONTH(GETDATE()) MONTH_;

SELECT 
    GETDATE() AS [GetDate], 
    SYSDATETIME() AS [SysDateTime],
    CURRENT_TIMESTAMP AS [CurrentTimestamp],
    GETUTCDATE() AS [UTC_Time];



-- Subtract 10 days from today
SELECT DATEADD(day, -10, GETDATE());

-- Calculate days between two dates (Result: 9)
SELECT DATEDIFF(day, '2026-08-01', '2026-08-10');

-- Get the last day of the current month
SELECT EOMONTH(GETDATE());

-- Add 1 year to hire date
SELECT EmpName, HireDate,DATEADD(YEAR, 1, HireDate) AS NextYearAnniversary FROM Employee;
-- Add 3 months to today
SELECT DATEADD(month, 3, GETDATE()) as quater_later_date;
-- Difference in years between hire date and today
SELECT EmpName, DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked FROM Employee;

--- Get the first 3 characters of employee names
SELECT EmpName, LEFT(EmpName, 3) AS FirstThreeChars, RIGHT(EmpName, 3) AS LastThreeChars FROM Employee;

-- Cast salary to integer
SELECT EmpName, CAST(Salary AS INT) AS SalaryInt FROM Employee;

-- Convert hire date to varchar
SELECT EmpName, CONVERT(VARCHAR, HireDate, 103) AS HireDateString FROM Employee;
