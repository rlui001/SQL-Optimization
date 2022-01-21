SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 2. List the names of students with id in the range of v2 (id) to v3 (inclusive).
-- Used EXPLAIN and EXPLAIN ANALYZE to identify bottleneck.
-- At first I used id IN (@v2,@v3) but that only improved the filter from 11.11 to 20
-- Then I changed it to @v2 <= id <= @v3 and filter improved to 100
SELECT name FROM Student WHERE @v2 <= id <= @v3;