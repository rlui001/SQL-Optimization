SET @v1 = 1612521;
SET @v2 = 1145072;
SET @v3 = 1828467;
SET @v4 = 'MGT382';
SET @v5 = 'Amber Hill';
SET @v6 = 'MGT';
SET @v7 = 'EE';			  
SET @v8 = 'MAT';

-- 4. List the names of students who have taken a course taught by professor v5 (name).
-- Using EXPLAIN, can see there are 4 SIMPLE select types where two are only 1% filtered
-- Attempted to re-write query using inner joins, result is actually higher cost and more rows scanned
-- end result: no change to query
SELECT name FROM Student,
	(SELECT studId FROM Transcript,
		(SELECT crsCode, semester FROM Professor
			JOIN Teaching
			WHERE Professor.name = @v5 AND Professor.id = Teaching.profId) as alias1
	WHERE Transcript.crsCode = alias1.crsCode AND Transcript.semester = alias1.semester) as alias2
WHERE Student.id = alias2.studId;

-- SELECT name FROM Student s
-- INNER JOIN Transcript t
-- ON id = studId
-- INNER JOIN Teaching t1
-- ON t.crsCode = t1.crsCode
-- INNER JOIN Professor p
-- ON p.id = t1.profId
-- WHERE p.name = @v5;