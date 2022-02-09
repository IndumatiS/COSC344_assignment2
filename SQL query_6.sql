
--COSC344- Lab6- StudentID 5910918
--18.Using a correlated subquery, list the names and numbers of all salespeople with more than one customer.
SELECT salespeople.sname, salespeople.snum
	FROM salespeople
	WHERE salespeople.snum IN(
		SELECT customers.snum
		FROM customers
		GROUP BY customers.snum
		HAVING COUNT(*)>1
		);


--19.Using a correlated subquery that correlates the orders table with itself, 
--list the orders with above average amounts for the particular customer.  
--Look at the output to help understand what is desired 

SELECT * FROM orders o 
WHERE o.amt> (
	SELECT AVG(amt)  FROM orders
	WHERE cnum=o.cnum
	);
--20.Use a correlated subquery and EXISTS to find the employess who have no dependents.
SELECT fname, lname  FROM employee
WHERE NOT  EXISTS (
	SELECT * FROM dependent
	WHERE employee.ssn=dependent.essn
);

	
--21.First type the following lines to add two rows into the 
--database:INSERT INTO department VALUES(‘TempDept’, 6, 123456789, TO_DATE(’18-Jul-2002’, ‘DD-MON-YYYY’));
--INSERT INTO project VALUES(‘TempProject’, 50, ‘Houston’, 6);Now use a UNION to list all project 
--numbers of projects that involve Smith as either a worker or as a manager of the department that 
--controls the project.  HINT:  Union two queries:  one that retrieves projects that involve Smith as 
--a worker; one that retrieves projects that involve Smith as manager of the department that controls the project.

INSERT INTO department VALUES
('TempDept',6, 123456789,
TO_DATE('18-Jul2002','DD-MON-YYYY'));
INSERT INTO project VALUES
('TempProject',50,'Houston',6);

SELECT pno 
FROM works_on
WHERE ESSN = (
SELECT ssn
 FROM employee
 WHERE lname='Smith'
)
UNION
SELECT pnumber
FROM project
WHERE DNUM = (
SELECT dnumber
 FROM department
 WHERE mgrssn =(
 SELECT ssn
 FROM employee
 WHERE lname='Smith'
)
);
--22.Give everybody except Borg (he makes too much anyway J) a 10% pay raise.  
--After you do this, select lname, salary to verify it worked properly.  If not, reload the company script and try again.

UPDATE employee
SET SALARY =( SALARY*0.1) + SALARY
WHERE lname!='Borg';

--23.Create a new table like the employee table that has only the workers who live in Houston. Create the table with the appropriate columns and data type and populate it usingasingleSQL command.  After the table is created, do aSELECT * FROM hou_empto verify your results.

CREATE TABLE hou_emp
  AS (SELECT * FROM employee
	WHERE address LIKE '%Houston%');
	
	
--24.Create a new table called emp_dep.  Its attributes consist of the first and last name of employees, 
--and the names, sex and birthdates of the employees dependents.  Create this table in a single SQL 
--statement by selecting appropriate data from existing tables.  
--After the table is created, do a SELECT * FROM emp_dep to verify your results.


CREATE TABLE emp_dep
  AS SELECT  employee.fname, employee.lname, dependent.dependent_name, dependent.sex, dependent.bdate
FROM dependent
INNER JOIN employee ON dependent.essn=employee.ssn
ORDER BY employee.fname;




