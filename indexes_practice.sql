-- =====================================================
-- SQL Practice: Indexes
-- Topics covered:
-- 1. Clustered vs Non-clustered indexes
-- 2. Creating and Dropping indexes
-- 3. Performance considerations
-- =====================================================

-- =========================================
-- 1) Clustered vs Non-clustered indexes
-- =========================================

/*
Clustered Index:
- Sorts and stores the actual table rows in the order of the index key.
- There can be only one clustered index per table.
- Best for columns frequently used in range queries, sorting, and joins.
- The table is effectively ordered by the clustered index key.

Non-clustered Index:
- Stores index data separately from the actual table rows.
- Contains index key values + pointers to row locations.
- Can have multiple non-clustered indexes on a table.
- Best for quick lookups on columns used in WHERE, JOIN, ORDER BY, and GROUP BY.
- The table itself is not physically reordered.

Example:
- Primary key often becomes a clustered index by default in many databases.
- If a table has a clustered index, the data rows are stored in that order.
- Non-clustered indexes create a separate lookup structure for faster search.
*/

-- Example table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- Clustered index example (usually created automatically on PRIMARY KEY)
-- In SQL Server, PRIMARY KEY creates a clustered index by default unless specified otherwise.
-- In MySQL/InnoDB, PRIMARY KEY is clustered by default.

-- Non-clustered index example
CREATE NONCLUSTERED INDEX IX_Employees_LastName
ON Employees (LastName);

CREATE NONCLUSTERED INDEX IX_Employees_Department_Salary
ON Employees (DepartmentID, Salary);

-- Query examples
SELECT *
FROM Employees
WHERE LastName = 'Singh';

SELECT *
FROM Employees
WHERE DepartmentID = 10
ORDER BY Salary DESC;

-- =========================================
-- 2) Creating and Dropping indexes
-- =========================================

/*
Syntax to create an index:
CREATE [UNIQUE] [CLUSTERED | NONCLUSTERED] INDEX index_name
ON table_name (column1, column2, ...);

Notes:
- UNIQUE prevents duplicate values in the indexed column(s).
- CLUSTERED creates a clustered index.
- NONCLUSTERED creates a standard index.
- Composite indexes use multiple columns together.
*/

-- Create a unique index on Email (example)
CREATE UNIQUE INDEX IX_Employees_Email
ON Employees (FirstName, LastName);

-- Create a composite index for filtering and sorting
CREATE INDEX IX_Employees_Department_HireDate
ON Employees (DepartmentID, HireDate);

-- Drop an index
DROP INDEX IX_Employees_LastName ON Employees;

-- Another drop syntax example (database-specific)
-- DROP INDEX Employees.IX_Employees_Department_HireDate;

-- =========================================
-- 3) Performance considerations
-- =========================================

/*
Indexing improves read performance, but adds cost to writes.
Important points:

1. Index only columns that are frequently used in WHERE, JOIN, ORDER BY, GROUP BY.
2. Composite indexes should follow the most selective order of columns.
3. Too many indexes slow down INSERT, UPDATE, and DELETE operations.
4. Indexes on columns with very low uniqueness (e.g., gender, status) may not help much.
5. Avoid indexing every column automatically.
6. Monitor execution plans and actual query performance.
7. Large tables benefit more from proper indexing.
8. Covering indexes can reduce table lookups by including extra columns.
9. Rebuild or reorganize indexes when fragmentation is high.
10. Keep index maintenance in mind for OLTP systems.
*/

-- Example: good candidate columns
SELECT *
FROM Employees
WHERE DepartmentID = 5
AND Salary > 50000;

-- Example: better index choice for this query
CREATE INDEX IX_Employees_Department_Salary_Filter
ON Employees (DepartmentID, Salary);

-- Example of an index that may not be useful
-- CREATE INDEX IX_Employees_FirstName ON Employees (FirstName);
-- This could be less useful if the column has low selectivity or is rarely queried.

-- Example of a covering index
CREATE INDEX IX_Employees_Covering
ON Employees (DepartmentID, Salary)
INCLUDE (FirstName, LastName);

-- Note:
-- INCLUDE is supported in SQL Server-style syntax.
-- In MySQL or PostgreSQL, similar functionality may use expression indexes or composite indexes.

-- Query plan idea:
-- EXPLAIN SELECT * FROM Employees WHERE DepartmentID = 10;
-- Check whether the database uses an index scan or table scan.

-- =========================================
-- Example: adding and removing indexes in a practical workflow
-- =========================================

CREATE INDEX IX_Employees_LastName_2
ON Employees (LastName);

-- Use this index for searches like:
SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE LastName = 'Patel';

DROP INDEX IX_Employees_LastName_2 ON Employees;

-- =========================================
-- Quick Summary
-- =========================================

/*
- Clustered index = data rows ordered by index key; only one per table.
- Non-clustered index = separate index structure; multiple allowed.
- Create indexes on columns used frequently in queries.
- Drop unused or duplicate indexes to reduce maintenance overhead.
- Balance read performance vs write performance.
- Use composite indexes wisely and analyze query execution plans.
*/
