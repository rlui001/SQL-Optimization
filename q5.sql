SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 5. List the names of students who have taken a course from department v6 (deptId), but not v7.
-- From looking at the table data, we can see that deptId @v6 and @v7 would not have any overlapping crsCode
-- So we can remove the check where studId does not have @v7
-- using Explain, we can see this reduces the query from using 5 select types (3 primary, 2 dependent) to 3 SIMPLE select types

-- EXPLAIN SELECT name FROM Student, 
-- 	(SELECT studId FROM Transcript, Course WHERE deptId = @v6 AND Course.crsCode = Transcript.crsCode) as alias
-- WHERE Student.id = alias.studId;

-- to further optimize this query, we can now just use joins for readability and remove the use of subqueries

SELECT name FROM Student s
INNER JOIN Transcript t
ON s.id = t.studId
INNER JOIN Course c
ON c.crsCode = t.crsCode
WHERE c.deptId = @v6;