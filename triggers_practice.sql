-- =====================================================
-- SQL Practice: Triggers
-- Topics covered:
-- 1. BEFORE & AFTER triggers
-- 2. Row-level vs Statement-level triggers
-- 3. Use cases (audit logs, validation)
-- =====================================================

-- =========================================
-- 1) BEFORE & AFTER triggers
-- =========================================

/*
Trigger:
- A special type of stored procedure that automatically runs when a table event occurs.
- Events can include INSERT, UPDATE, DELETE.

Trigger timing:
- BEFORE trigger: runs before the change is made
- AFTER trigger: runs after the change is made

Important note:
- Syntax differs by database.
- MySQL uses BEFORE/AFTER.
- SQL Server uses AFTER/INSTEAD OF, not BEFORE.
*/

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10,2),
    DepartmentID INT
);

CREATE TABLE EmployeeAuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    ActionType VARCHAR(20),
    ActionTime DATETIME DEFAULT GETDATE(),
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2)
);

-- BEFORE INSERT trigger example (MySQL/PostgreSQL style)
-- CREATE TRIGGER trg_before_insert_employee
-- BEFORE INSERT ON Employees
-- FOR EACH ROW
-- BEGIN
--     IF NEW.Salary <= 0 THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary must be greater than zero';
--     END IF;
-- END;

-- AFTER INSERT trigger example (common concept)
CREATE TRIGGER trg_AfterInsertEmployee
ON Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO EmployeeAuditLog (EmployeeID, ActionType, OldSalary, NewSalary)
    SELECT i.EmployeeID, 'INSERT', NULL, i.Salary
    FROM inserted i;
END;

-- Example insert that triggers the audit log
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES (1, 'Amit', 'Sharma', 50000, 10);

SELECT * FROM EmployeeAuditLog;

-- AFTER UPDATE trigger example
CREATE TRIGGER trg_AfterUpdateEmployee
ON Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO EmployeeAuditLog (EmployeeID, ActionType, OldSalary, NewSalary)
    SELECT d.EmployeeID, 'UPDATE', d.Salary, i.Salary
    FROM deleted d
    JOIN inserted i ON d.EmployeeID = i.EmployeeID;
END;

UPDATE Employees
SET Salary = 55000
WHERE EmployeeID = 1;

SELECT * FROM EmployeeAuditLog;

-- AFTER DELETE trigger example
CREATE TRIGGER trg_AfterDeleteEmployee
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAuditLog (EmployeeID, ActionType, OldSalary, NewSalary)
    SELECT d.EmployeeID, 'DELETE', d.Salary, NULL
    FROM deleted d;
END;

DELETE FROM Employees WHERE EmployeeID = 1;
SELECT * FROM EmployeeAuditLog;

-- =========================================
-- 2) Row-level vs Statement-level triggers
-- =========================================

/*
Row-level trigger:
- Fires once for each row affected by the statement.
- Good for validating per-row logic.

Statement-level trigger:
- Fires once for the entire statement, regardless of row count.
- Good for overall table-level checks and summary actions.

Examples:
- Row-level trigger: validate each employee salary before it is inserted
- Statement-level trigger: log the total number of rows deleted in a batch
*/

-- Row-level trigger example (MySQL-style syntax)
-- CREATE TRIGGER trg_row_validate_salary
-- BEFORE INSERT ON Employees
-- FOR EACH ROW
-- BEGIN
--     IF NEW.Salary < 0 THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Negative salary not allowed';
--     END IF;
-- END;

-- Statement-level trigger example (conceptual)
-- CREATE TRIGGER trg_statement_log_delete
-- AFTER DELETE ON Employees
-- BEGIN
--     INSERT INTO EmployeeAuditLog (ActionType, ActionTime)
--     VALUES ('BULK_DELETE', NOW());
-- END;

-- =========================================
-- 3) Use cases (audit logs, validation)
-- =========================================

/*
Common trigger use cases:
- Audit trail: log who changed what, when, and old/new values
- Validation: block invalid data updates or inserts
- Referential integrity support: enforce rules automatically
- Derived values: update totals or summary data when child rows change
- Notification: send alerts after a critical change
*/

-- Audit log example using trigger pattern
-- Trigger fires after insert/update/delete to capture changes.

-- Validation example (conceptual)
-- CREATE TRIGGER trg_validate_department
-- BEFORE INSERT ON Employees
-- FOR EACH ROW
-- BEGIN
--     IF NEW.DepartmentID IS NULL THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department ID is required';
--     END IF;
-- END;

-- =========================================
-- Quick Summary
-- =========================================

/*
- Triggers automatically execute when data changes.
- BEFORE triggers validate or change data before update/insert.
- AFTER triggers are used for logging and downstream actions.
- Row-level triggers run per row; statement-level triggers run per statement.
- Use triggers carefully because they can affect performance and complexity.
*/
