--Write a PL/SQL procedure to list the name and relationship of the dependents. For this, you
--can use a simple CURSOR FOR loop. Use SELECT * FROM dependent for your query.


SET SERVEROUTPUT ON;
DECLARE
CURSOR ec IS
SELECT * FROM dependent WHERE ESSN = 333445555;
dep ec%ROWTYPE;
BEGIN
FOR dep IN ec
LOOP 
DBMS_OUTPUT.PUT_LINE (dep.dependent_name ||' ' ||dep.relationship);
END LOOP;
END;
/

---------------------------

CREATE
PROCEDURE which_Dependent(x IN number) 

IS
CURSOR ec IS
SELECT * FROM dependent WHERE ESSN = x;
dep ec%ROWTYPE;

BEGIN 
  FOR dep IN ec
   LOOP 
    DBMS_OUTPUT.PUT_LINE (dep.dependent_name ||' ' ||dep.relationship);
   END LOOP;

END which_Dependent;    
/
---------------------------

--Write a PL/SQL procedure that takes a project number and lists the ssn and number of hours
--each employee worked on the project. Raise an exception if the hours are less than 8.0 and
--have the exception print a message.

SET SERVEROUTPUT ON;
DECLARE
CURSOR ec IS
SELECT ESSN, HOURS FROM works_on WHERE PNO = 20;
dep ec%ROWTYPE;
BEGIN
FOR dep IN ec
LOOP 
DBMS_OUTPUT.PUT_LINE (dep.ESSN ||' ' ||dep.hours);
END LOOP;
END;
/

---------------------------

CREATE
PROCEDURE project_timeSpent(x IN number) 

IS
CURSOR ec IS
SELECT ESSN, HOURS FROM works_on WHERE PNO = x;
dep ec%ROWTYPE;
little_work_done EXCEPTION;

BEGIN 
  FOR dep IN ec
   LOOP 
    DBMS_OUTPUT.PUT_LINE (dep.ESSN ||' ' ||dep.hours);
   
		IF dep.hours<8 THEN
			RAISE little_work_done;
		END IF;
	END LOOP;

EXCEPTION
	WHEN little_work_done THEN
		DBMS_OUTPUT.PUT_LINE('Very little work done on the project');

END project_timeSpent;    
/
---------------------------


--Triggers
--Get the file, company_trigger.sql, from /coursework/344/pickup/oracle-sql. It is an Oracle
--script that creates and populates two tables, E1 and D1. E1 is a simplified version of
--employee that only has fname, ssn, salary, and dno. D1 is a different version of department
--that has dname, dnumber, and tot_sal. Tot_sal is the sum of the salaries of all employees
--assigned to a department.
--DONE

--Create triggers that maintain tot_sal consistent with the data in the database. You need to
--think through all the database actions that might cause it to become inconsistent.

--Create a procedure to calculate the sum of salaries in every department.
--Call this procedure inside the trigger to update tot_sal
---Create table which provides the total salaries of all employees in the every department.

SELECT dno, sum(salary) AS deptTotal_salary FROM e1
GROUP BY dno;


CREATE OR REPLACE PROCEDURE deptTotal_salary
IS
 --sal_sum e1.salary%TYPE;
BEGIN
 UPDATE d1 
 SET 
d1.tot_sal = (
 SELECT sum(salary) 
 AS deptTotal_salary 
 FROM e1 emp
 WHERE emp.dno = d1.dnumber);
END;
/
 ---------
 ---------

CREATE OR REPLACE TRIGGER update_dept_salary
AFTER UPDATE OF salary, dno ON e1
BEGIN
	deptTotal_salary();
END;
/


--At first, create your triggers in a file and check their operation. Once you think they are
--correct, insert the trigger code between the CREATE TABLE E1 statement and the INSERT
--statements for E1 in company_trigger.sql file. Try loading the file. The initial values of
--tot_sal should be:
 --1 55000
 --4 93000
 --5 133000
--Try updating employee's salary, inserting new employees, and deleting employees. Try

/home/cshome/coursework/344/pickup/oracle-sql/company_trigger.sql

scp isharma@titanium.otago.ac.nz:/home/cshome/i/isharma/COS344/Lab7/ 
scp isharma@hextreme.otago.ac.nz:/home/cshome/i/isharma/COS344/titanium_transfers/company_trigger.sql .

--changing employees between departments. Do your triggers maintain consistency?



CREATE OR REPLACE TRIGGER after_delete_customer 
AFTER DELETE ON customers FOR EACH ROW 
BEGIN 
INSERT INTO cust_history(cno, cname, address) 
VALUES (:old.cnum,:old.cname,:old.city); 
END;
/

Customer tables can only be modified between 8am to 6pm

CREATE or REPLACE TRIGGER modified 8_6
BEFORE DELETE OR UPDATE OR INSERT ON custormers
BEGIN

	If to_char(sysdate, 'hh24')<'08' OR
		to_char (sysdate, 'hh24')>'18' THEN
	RAISE_APPLICATION_ERROR ( -20001, 'Data cannot be
	modified at this time');
	
	END IF;
	
END;
/


CREATE OR REPLACE TRIGGER calculate_tot_hr
AFTER UPDATE OF hours ON PROJECT
	FOR EACH ROW
	BEGIN
		UPDATE PROJECT
		SET total_hours = total_hours + :NEW.hours
							- :OLD.hours
		END;
		/





