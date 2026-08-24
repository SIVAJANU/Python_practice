-- =====================================================
-- SQL Practice: Transactions & TCL
-- Topics covered:
-- 1. START TRANSACTION / BEGIN
-- 2. COMMIT
-- 3. ROLLBACK
-- 4. SAVEPOINT
-- 5. ACID properties
-- =====================================================

-- =========================================
-- 1) START TRANSACTION / BEGIN
-- =========================================

/*
Transaction:
- A unit of work that must either completely succeed or completely fail.
- Ensures data consistency.

Common commands:
- START TRANSACTION
- BEGIN
- COMMIT
- ROLLBACK
- SAVEPOINT
*/

CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10,2)
);

INSERT INTO BankAccounts (AccountID, AccountHolder, Balance)
VALUES
(1, 'Amit', 1000.00),
(2, 'Neha', 1500.00);

-- Start transaction
BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance - 200
WHERE AccountID = 1;

UPDATE BankAccounts
SET Balance = Balance + 200
WHERE AccountID = 2;

-- If both updates are successful,
-- then commit the transaction.
COMMIT;

SELECT * FROM BankAccounts;

-- =========================================
-- 2) COMMIT
-- =========================================

/*
COMMIT permanently saves all changes made in the current transaction.
After COMMIT, the changes become durable and visible to others.
*/

BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance + 500
WHERE AccountID = 1;

COMMIT;

SELECT * FROM BankAccounts;

-- =========================================
-- 3) ROLLBACK
-- =========================================

/*
ROLLBACK undoes all changes made in the current transaction.
Useful when an error occurs or business rules fail.
*/

BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance - 300
WHERE AccountID = 1;

UPDATE BankAccounts
SET Balance = Balance + 300
WHERE AccountID = 2;

-- If something goes wrong:
-- ROLLBACK;

-- Example of rollback after a failed condition
-- IF some_error_condition THEN
--     ROLLBACK;
-- END IF;

-- =========================================
-- 4) SAVEPOINT
-- =========================================

/*
SAVEPOINT allows partial rollback inside a transaction.
It lets you undo only part of the transaction instead of the whole thing.
*/

BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance - 100
WHERE AccountID = 1;

SAVEPOINT BeforeSecondTransfer;

UPDATE BankAccounts
SET Balance = Balance + 100
WHERE AccountID = 2;

-- Undo only the second update
-- ROLLBACK TO SAVEPOINT BeforeSecondTransfer;

-- If everything is okay:
COMMIT;

-- =========================================
-- 5) ACID properties
-- =========================================

/*
ACID stands for:

A - Atomicity
  All operations in a transaction succeed or none do.

C - Consistency
  Database remains in a valid state before and after a transaction.

I - Isolation
  Transactions are isolated from one another to avoid conflicts.

D - Durability
  Once committed, changes remain even after a crash.

These properties guarantee reliable transaction processing.
*/

-- Example of a transfer operation
BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance - 250
WHERE AccountID = 1;

UPDATE BankAccounts
SET Balance = Balance + 250
WHERE AccountID = 2;

COMMIT;

SELECT * FROM BankAccounts;

-- =========================================
-- Practical usage example
-- =========================================

BEGIN TRANSACTION;

UPDATE BankAccounts
SET Balance = Balance - 100
WHERE AccountID = 1;

SAVEPOINT AfterDebit;

UPDATE BankAccounts
SET Balance = Balance + 100
WHERE AccountID = 2;

-- Simulate an issue
-- ROLLBACK TO SAVEPOINT AfterDebit;

COMMIT;

-- =========================================
-- Quick Summary
-- =========================================

/*
- Transactions group multiple SQL statements into one logical unit.
- COMMIT saves changes permanently.
- ROLLBACK cancels the transaction.
- SAVEPOINT allows partial rollback.
- ACID guarantees reliability and consistency in database systems.
*/
