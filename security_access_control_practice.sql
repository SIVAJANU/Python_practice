-- =====================================================
-- SQL Practice: Security & Access Control
-- Topics covered:
-- 1. User roles & permissions (GRANT, REVOKE)
-- 2. SQL Injection & prevention methods
-- 3. Encryption concepts
-- =====================================================

-- =========================================
-- 1) User roles & permissions (GRANT, REVOKE)
-- =========================================

/*
Database security ensures users only access the data they are allowed to access.
Common commands:
- GRANT: gives privileges to a user or role
- REVOKE: removes privileges
- CREATE ROLE: creates a role for grouping permissions
*/

-- Example: grant read permission on a table
-- GRANT SELECT ON Employees TO AnalystUser;

-- Grant insert, update, delete permissions
-- GRANT INSERT, UPDATE, DELETE ON Employees TO DataEntryUser;

-- Grant all privileges (use carefully)
-- GRANT ALL PRIVILEGES ON Employees TO AdminUser;

-- Revoke privileges
-- REVOKE SELECT ON Employees FROM AnalystUser;

-- Create a role
-- CREATE ROLE ReportingRole;

-- Grant role permissions
-- GRANT SELECT ON Employees TO ReportingRole;
-- GRANT SELECT ON Orders TO ReportingRole;

-- Assign user to role
-- GRANT ReportingRole TO UserA;

-- Revoke role membership
-- REVOKE ReportingRole FROM UserA;

-- Example table for demonstration
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary)
VALUES
(1, 'Amit', 'Sharma', 'HR', 60000),
(2, 'Neha', 'Verma', 'IT', 75000),
(3, 'Rohit', 'Singh', 'Finance', 68000);

-- SQL security best practices:
-- - Follow least privilege principle
-- - Use roles instead of granting rights individually
-- - Restrict sensitive tables
-- - Audit user permissions regularly

-- =========================================
-- 2) SQL Injection & prevention methods
-- =========================================

/*
SQL Injection happens when user input is concatenated into SQL without validation.
Attack example:
SELECT * FROM Users WHERE username = 'admin' OR '1'='1';

Prevention methods:
- Use parameterized queries / prepared statements
- Validate input types and length
- Avoid string concatenation for dynamic SQL
- Use stored procedures where appropriate
- Escape special characters when unavoidable
- Enforce least privilege in DB accounts
*/

-- Vulnerable query example (avoid):
-- DECLARE @UserInput NVARCHAR(100) = 'admin'' OR 1=1 --';
-- DECLARE @SQL NVARCHAR(MAX) = 'SELECT * FROM Employees WHERE FirstName = ''' + @UserInput + '''';
-- EXEC sp_executesql @SQL;

-- Safe parameterized query example (SQL Server style)
DECLARE @Name NVARCHAR(50) = 'Amit';
SELECT *
FROM Employees
WHERE FirstName = @Name;

-- Safe stored procedure approach example
-- CREATE PROCEDURE GetEmployeeByName @Name NVARCHAR(50)
-- AS
-- BEGIN
--     SELECT * FROM Employees WHERE FirstName = @Name;
-- END;

-- Additional prevention best practices:
-- - Use ORM parameter binding
-- - Disable unnecessary DB features for public users
-- - Validate and sanitize inputs before storing or querying

-- =========================================
-- 3) Encryption concepts
-- =========================================

/*
Encryption protects data from unauthorized access.
There are two major types:

1. Encryption at rest
   Data is encrypted while stored on disk.

2. Encryption in transit
   Data is encrypted while travelling across networks.

Other concepts:
- Symmetric encryption: same key is used for encryption and decryption
- Asymmetric encryption: public/private key pair
- Hashing: one-way transformation, used for passwords

Common DB concepts:
- TDE (Transparent Data Encryption)
- SSL/TLS for database connections
- Column-level encryption in some DBMS
*/

-- Example conceptual use:
-- CREATE TABLE CustomerSensitiveData (
--     CustomerID INT,
--     SSNEncrypted VARBINARY(MAX)
-- );

-- Use database-native encryption features or application-layer encryption for sensitive columns.

-- Hashing example conceptually:
-- PasswordHash = SHA256(password + salt)

-- Security summary:
-- - Encrypt sensitive data
-- - Use strong keys and rotation policies
-- - Protect backups and keys
-- - Use SSL/TLS for database connections

-- =========================================
-- Quick Summary
-- =========================================

/*
- GRANT and REVOKE control access to database objects.
- Roles simplify permission management.
- SQL injection is prevented by parameterization, validation, and safe coding patterns.
- Encryption protects data in transit and at rest.
- Least privilege and strong database security controls are essential.
*/
