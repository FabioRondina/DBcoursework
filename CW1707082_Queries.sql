
USE CW_1707082
GO

--a ALL the Rooms where there is an Eye treatments

SELECT room,T.treat_description
FROM Treatment T, Appointment A
WHERE T.treat_id = A.treat_id
AND treat_description LIKE '%Eye%'
GROUP BY room,T.treat_description


--b list the information: (patient name, doctor name, treatment) for all Appointments of MALE Patient

SELECT P.name, P.surname , P.sex , D.name, D.surname , treat_description
FROM Patient P , Appointment A, Doctor D, Treatment T
WHERE P.pat_id = A.pat_id
AND T.treat_id = A.treat_id
AND D.doc_id = A.doc_id
AND P.sex LIKE 'M'

--c)	List the number of appointments each patient has had with each doctor 
--		(patient name, doctor name, number of appointments). List only those 
--		patient-doctor combinations that have had more than one appointment together.

SELECT P.name, P.surname , D.name, D.surname , COUNT(D.doc_id) AS Number_of_Appointments
FROM Patient P , Appointment A, Doctor D, Treatment T
WHERE  P.pat_id = A.pat_id
AND T.treat_id = A.treat_id
AND D.doc_id = A.doc_id
GROUP BY P.name, P.surname , D.name, D.surname 
HAVING COUNT(D.doc_id) > 1

