----Set Operations
SELECT * FROM Employee_new1

SELECT * INTO Employee_new1 FROM Employee 
--WHERE 1 = 0; --this is just copy the schema of the table
WHERE 1 = 1; ---this copies schema along with total records

SELECT * FROM Employee_new1
--UNION ALL ---will not remove the duplicates and is faster
UNION ---remove the duplicates and is slower in query performance
SELECT * FROM Employee;

SELECT 'SIVA' name, 23 age
UNION ALL
SELECT 'SUDEEP', 53;


SELECT * FROM Employee  
EXCEPT ---BRINGS THE COMMON RECORDS FROM BOTH THE TABLES BASED ON THE pk
SELECT * FROM Employee_new1;
SELECT * FROM Employee
INSERT INTO Employee (EmpID, EmpName, Department, Salary, HireDate, Address)
VALUES
(1110, 'John New', 'IT', 55000.00, '2024-01-15', 'Hyderabad'),

1,2,3,4-1,2,3=4




CREATE VIEW table_view1
AS
(SELECT * FROM Employee_new1 
where EmpID>=10)

SELECT * from table_view1