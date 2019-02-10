

USE CW_1707082
GO


--A
/*(A)	A procedure that returns the number of patients in a given ward. 
The ward number should be an input parameter and the number of patients 
should be an output parameter. Also write test code to execute the 
procedure and write the number of patients to the screen.*/


CREATE PROCEDURE ShowPatiences
@wardnum NCHAR(3)

AS

SELECT COUNT(P.pat_id) AS Number_of_Patients 
FROM Patient P, Ward W
WHERE W.ward_num = P.ward_num
AND W.ward_num = @wardnum

EXECUTE ShowPatiences 'W02'


--B
/*(B)	A procedure that discharges a patient
 specified by the user. The procedure should 
 take the patient’s number as input. 
The patient’s details, including their appointments,
should be added to archive tables (creating the tables
if they do not already exist). The patient’s data should
 then be deleted from the remaining tables.*/

 --Complete solution
	/* -this solution maintain the same two separate tables to archive the data, in my opinion this will take less space and
		keep the table as simple as possible
	   -i create a reusable procedure that create the tables the first execution and add data on the same tables
	    on all the other execution*/
	

CREATE PROCEDURE ArchivePatient
@patid NCHAR(5)

AS

IF OBJECT_ID('Patient_Archive','U') IS NOT NULL

-- if table exist add new data
INSERT INTO Patient_Archive 
SELECT * 
FROM Patient 
WHERE pat_id = @patid

ELSE 
--add selected data to new table
SELECT * INTO Patient_Archive
FROM Patient 
WHERE pat_id = @patid
ALTER TABLE Patient_Archive 
ADD CONSTRAINT PK_PAtient_Archive PRIMARY KEY (pat_id)


IF OBJECT_ID('Appointment_Archive','U') IS NOT NULL
INSERT INTO Appointment_Archive
SELECT *
FROM Appointment
WHERE pat_id = @patid

ELSE 
--add selected data to new table
SELECT * INTO Appointment_Archive
FROM Appointment
WHERE pat_id = @patid
ALTER TABLE Appointment_Archive 
ADD CONSTRAINT PK_Appointment_Archive PRIMARY KEY (date,time,room);
ALTER TABLE Appointment_Archive 
ADD CONSTRAINT FK_Appointment_Archive_Patient_Archive FOREIGN KEY (pat_id)
										REFERENCES Patient_Archive(pat_id);

--delete the data from the original tables

DELETE FROM Appointment
WHERE pat_id = @patid--'P0001'

DELETE FROM Patient
WHERE pat_id = @patid --'P0001'

--tested execution
EXECUTE ArchivePatient 'P0001' -- Create archive table , add requested data , delete data from original table
EXECUTE ArchivePatient 'P0002' -- add requested data to the existing archive table , delete data from original table

---OTHER SOLUTION LESS ACCURATE-------------------------------------------------------------------------
/*
DROP PROCEDURE ArchivePatient 2

CREATE PROCEDURE ArchivePatient 2
@patid NCHAR(5)

AS
--add selected data to new table
SELECT * INTO Patient_Archive
FROM Patient P
WHERE P.pat_id = @patid


SELECT * INTO Appointment_Archive
FROM Appointment
WHERE pat_id = @patid

--delete the data from the original table

DELETE FROM Appointment
WHERE pat_id = @patid--'P0001'

DELETE FROM Patient
WHERE pat_id = @patid --'P0001'

EXECUTE ArchivePatient 'P0001' --This solution will work only once, the second time will give error due the table already exists
*/

--UNIQUE TABLE VERSION---------------------------------------------------------------------------------
/* -- version to archive all data in only a table Patient/appointment
AS
PRINT 'Patient Archived'

SELECT P.pat_id, P.name, P.surname, P.sex, P.admission_date , P.ward_num, A.date,A.time,A.room,A.doc_id,A.treat_id INTO Patient_Archive
FROM Patient P, Appointment A
WHERE P.pat_id = A.pat_id
GROUP BY P.pat_id, P.name, P.surname, P.sex, P.admission_date , P.ward_num, A.date,A.time,A.room,A.doc_id,A.treat_id
HAVING P.pat_id = @patid
*/







