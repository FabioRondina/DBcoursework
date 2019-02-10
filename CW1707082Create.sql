IF EXISTS ( SELECT name FROM sys.databases WHERE name = N'CW_1707082')
	DROP DATABASE CW_1707082
GO

--USE master
--GO

--Now create the CW database
CREATE DATABASE CW_1707082
GO

-- Ensure that CW is the current database in use
USE CW_1707082
GO


/* Create Ward table */

IF OBJECT_ID('Ward','U') IS NOT NULL
	DROP TABLE Ward 
GO

CREATE TABLE Ward(
	ward_num		NCHAR(3)		NOT NULL,
	name			NVARCHAR(30)	NULL,
	CONSTRAINT PK_ward_num PRIMARY KEY (ward_num),
	CONSTRAINT CK_ward_num CHECK( ward_num like 'W[0-9][0-9]'))


/*Create table Patient */
IF OBJECT_ID('Patient','U') IS NOT NULL
	DROP TABLE Patient
GO

CREATE TABLE Patient(

	pat_id			NCHAR(5)		NOT NULL,	
	name			NVARCHAR(30),
	surname			NVARCHAR(30),
	sex				NCHAR(1),
	admission_date	DATE			NOT NULL,
	ward_num			NCHAR(3)		NOT NULL,
	CONSTRAINT PK_Patient PRIMARY KEY (pat_id),
	CONSTRAINT FK_Patient_Ward FOREIGN KEY (ward_num) 
							   REFERENCES Ward(ward_num),
	CONSTRAINT CK_sex CHECK (sex ='M' OR sex = 'F' ),
	CONSTRAINT CK_pat_id CHECK (pat_id LIKE 'P[0-9][0-9][0-9][0-9]'))


/* Create Doctor table */

IF OBJECT_ID('Doctor','U') IS NOT NULL
	DROP TABLE Doctor
GO

CREATE TABLE Doctor(
	doc_id				NCHAR(5)	NOT NULL,
	name				NVARCHAR(30)	NOT NULL,				
	surname				NVARCHAR(30)	NOT NULL,
	CONSTRAINT PK_Doctor PRIMARY KEY (doc_id),
	CONSTRAINT CK_doc_id CHECK(doc_id LIKE 'D[0-9][0-9][0-9][0-9]'))

/* Create Treatments table */

IF OBJECT_ID ('Treatment','U') IS NOT NULL
	DROP TABLE Treatment
GO

CREATE TABLE Treatment (
	treat_id			NCHAR(5)	NOT NULL,
	treat_description	NVARCHAR(30),
	CONSTRAINT PK_Treatment PRIMARY KEY (treat_id),
	CONSTRAINT CK_treat_id CHECK (treat_id LIKE 'T[0-9][0-9][0-9][0-9]'))



/*Create Qualification table */

IF OBJECT_ID('Qualification','U') IS NOT NULL
	DROP TABLE Qualification
GO

CREATE TABLE Qualification(
	treat_id			NCHAR(5)	NOT NULL,
	doc_id				NCHAR(5)	NOT NULL,
	qual_date			DATE		NOT NULL,
	CONSTRAINT PK_Qualification PRIMARY KEY (treat_id, doc_id),
	CONSTRAINT FK_Qualification_Treatment FOREIGN KEY (treat_id)
										  REFERENCES Treatment(treat_id),
	CONSTRAINT FK_Qualification_Doctor FOREIGN KEY (doc_id)
									   REFERENCES Doctor(doc_id))

/*Create Appointments table */

IF OBJECT_ID('Appointment','U') IS NOT NULL
	DROP TABLE Appointment
GO

CREATE TABLE Appointment(
	date				DATE		NOT NULL,
	time				TIME		NOT NULL,
	room				NCHAR(2)	NOT NULL,
	doc_id				NCHAR(5)	NOT NULL,
	treat_id			NCHAR(5)	NOT NULL,
	pat_id				NCHAR(5)	NOT NULL,

	CONSTRAINT PK_Appointment PRIMARY KEY (date,time,room),
	CONSTRAINT FK_Appointment_Doctor FOREIGN KEY (doc_id) 
									 REFERENCES Doctor(doc_id),
	CONSTRAINT FK_Appointment_Treatment FOREIGN KEY (treat_id) 
										REFERENCES Treatment(treat_id),
	CONSTRAINT FK_Appointment_Patient FOREIGN KEY (pat_id) 
									 REFERENCES Patient(pat_id)
									 ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT CK_room CHECK( room LIKE '[A-Z][0-9]'))

