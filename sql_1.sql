/* create new database*/
DROP DATABASE TEST_SQL_KNOWLEDGE

/* print list of databases in the server or system*/
SELECT name AS DatabaseName
FROM sys.databases;

SELECT 1+2 as Sum, 3*4 as Mul, 4+6 as Sum;

SELECT 1 + 2 AS Sum
UNION ALL
SELECT 3 + 4 AS Sum
UNION ALL
SELECT 4 + 6 AS Sum;



/* Use a specific database*/
USE PracticeDB1;

------ List all tables in the current database
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

--Get the records from any one table from the above list of tables in the given database
SELECT * FROM Employees

-- Show schema (columns) of a table
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employees';

