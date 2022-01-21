SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 6. List the names of students who have taken all courses offered by department v8 (deptId).
-- At first glance using EXPLAIN, can see many select types that are not efficient:
-- derived, materialized, uncacheable.... cost = 1041

-- SELECT name FROM Student,
-- 	(SELECT studId
-- 	FROM Transcript
-- 		WHERE crsCode IN
-- 		(SELECT crsCode FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))
-- 		GROUP BY studId
-- 		HAVING COUNT(*) = 
-- 			(SELECT COUNT(*) FROM Course WHERE deptId = @v8 AND crsCode IN (SELECT crsCode FROM Teaching))) as alias
-- WHERE id = alias.studId;

-- in EXPLAIN ANALYZE, cost is still the same but actual time reduced from 4.6 to 1.6
-- in EXPLAIN, number of selects has been reduced and now we only have primary,derived,dependent subq
-- dependent subquery is better than uncacheable
-- Final query removed the Teaching table as it is not necessary and joins Trancript with Course for v8
-- rather than using another subquery

EXPLAIN SELECT name FROM Student,
	(SELECT studId
	FROM Transcript 
    INNER JOIN Course 
    WHERE Transcript.crsCode = Course.crsCode AND deptId = @v8
    GROUP BY studID 
    HAVING COUNT(*) IN (SELECT COUNT(*) FROM Course WHERE deptId = @v8)) as alias
WHERE id = alias.studId;