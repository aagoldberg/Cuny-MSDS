--SQL Week4 HW
--Andrew Goldberg

DROP TABLE IF EXISTS appleStructure;
CREATE TABLE appleStructure (
employeeId int PRIMARY KEY,
employeeName varchar NOT NULL,
employeeTitle varchar,
supervisorId int NULL
);

INSERT INTO appleStructure (employeeId, employeeName, employeeTitle, supervisorId)
	VALUES	(1, 'Steve Jobs', 'CEO', NULL),
		(2, 'Tim Cook', 'COO', 1),
		(3, 'Jeffrey Williams', 'SVP Operations', 2),
		(4, 'Bob Mansfield', 'SVP Hardware', 2),
		(5, 'Jonathan Ive', 'SVP Design', 1);
		
SELECT e.employeeName as employee, e.employeeTitle as employeeTitle, s.employeeName as supervisor, s.employeeTitle as supervisorTitle
FROM appleStructure e
JOIN appleStructure s
ON s.employeeId = e.supervisorId
ORDER BY supervisor, employee;