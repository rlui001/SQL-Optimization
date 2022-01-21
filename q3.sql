SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 3. List the names of students who have taken course v4 (crsCode).
-- Using EXPLAIN and EXPLAIN ANALYZE:
-- Original query had two SIMPLE select types and one MATERIALIZED select type. Total cost was 414.91
-- We reduce the need of a subquery by using an inner join:
-- result = two SIMPLE select types and total cost reduced to 411.29
EXPLAIN ANALYZE SELECT name 
FROM Student 
INNER JOIN Transcript 
ON id = studId
WHERE crsCode = @v4;