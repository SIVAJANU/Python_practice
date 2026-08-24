-- =====================================================
-- SQL Practice: Performance Tuning
-- Topics covered:
-- 1. Query execution plans
-- 2. Index optimization
-- 3. Joins vs Subqueries optimization
-- 4. Normalization & Denormalization
-- 5. Database partitioning & sharding (concepts)
-- =====================================================

-- =========================================
-- 1) Query execution plans
-- =========================================

/*
An execution plan shows how the database engine will execute a query.
It helps identify:
- table scans vs index scans
- join order
- costly operations
- missing indexes

Typical signs of bad performance:
- Full table scans on large tables
- Large sort or hash operations
- Nested loops on big datasets without indexes
*/

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(1, 101, '2026-01-01', 1000),
(2, 102, '2026-01-02', 1200),
(3, 101, '2026-01-05', 900),
(4, 103, '2026-01-10', 1500);

INSERT INTO Customers (CustomerID, CustomerName, City)
VALUES
(101, 'Alice', 'Delhi'),
(102, 'Bob', 'Mumbai'),
(103, 'Charlie', 'Bengaluru');

-- Example query to inspect plan quality
SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2026-01-01';

-- Database-specific command examples:
-- EXPLAIN ANALYZE SELECT ...
-- SHOW QUERY PLAN
-- SET STATISTICS PROFILE ON

-- =========================================
-- 2) Index optimization
-- =========================================

/*
Indexes speed up data retrieval but may slow down writes.
Use indexes wisely on columns frequently used in:
- WHERE filters
- JOIN conditions
- ORDER BY
- GROUP BY
*/

CREATE INDEX IX_Orders_CustomerID
ON Orders (CustomerID);

CREATE INDEX IX_Orders_OrderDate
ON Orders (OrderDate);

-- Composite index example
CREATE INDEX IX_Orders_CustomerDate
ON Orders (CustomerID, OrderDate);

-- Query using composite index
SELECT *
FROM Orders
WHERE CustomerID = 101
ORDER BY OrderDate;

-- Avoid excessive indexes on low-cardinality columns
-- Example: a status column with only a few unique values may not benefit much.

-- =========================================
-- 3) Joins vs Subqueries optimization
-- =========================================

/*
Join optimization:
- Often better for retrieving related data from multiple tables
- DB optimizer can use indexes efficiently

Subquery optimization:
- Can be useful for filtering or calculations
- May be less efficient than joins for large datasets

Best practice:
- Use joins when combining row sets
- Use subqueries when there is a logical dependency or scoped filtering
- Check execution plan for performance bottlenecks
*/

-- Join example
SELECT c.CustomerName, o.OrderID, o.TotalAmount
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE c.City = 'Delhi';

-- Subquery example
SELECT CustomerName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE TotalAmount > 1000
);

-- Compare execution plan and choose the more efficient version.

-- =========================================
-- 4) Normalization & Denormalization
-- =========================================

/*
Normalization:
- Organizes data to reduce redundancy and improve integrity.
- Common normal forms: 1NF, 2NF, 3NF, BCNF

Denormalization:
- Adds redundancy intentionally to improve read performance.
- Common in reporting, analytics, and warehouse systems.

Tradeoff:
- Normalization = cleaner and consistent data
- Denormalization = faster reads, more complex writes
*/

-- Example of normalized structure:
-- Customers table
-- Orders table
-- Products table

-- Example of denormalized structure:
-- A reporting table may include customer_name, product_name, total_sales in one row.

-- =========================================
-- 5) Database partitioning & sharding (concepts)
-- =========================================

/*
Partitioning:
- Splits a large table into smaller logical pieces.
- Improves manageability and query performance.
- Common types: range, hash, list, composite

Sharding:
- Distributes data across multiple database instances or servers.
- Useful for very large-scale systems with high write throughput.

Conceptual difference:
- Partitioning = split one database into multiple partitions
- Sharding = distribute data across multiple database servers
*/

-- Example conceptual range partitioning
-- CREATE TABLE Orders_Partitioned (
--     OrderID INT,
--     OrderDate DATE,
--     TotalAmount DECIMAL(10,2)
-- ) PARTITION BY RANGE (YEAR(OrderDate));

-- Sharding example conceptually:
-- user_id % 4 -> server A/B/C/D

-- =========================================
-- Quick Summary
-- =========================================

/*
- Execution plans help diagnose performance issues.
- Indexes improve read speed but add write overhead.
- Joins and subqueries should be chosen based on the execution plan and data size.
- Normalization improves consistency; denormalization improves read performance.
- Partitioning and sharding are used for very large-scale systems.
*/
