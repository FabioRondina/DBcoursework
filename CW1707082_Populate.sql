USE CW_1707082
GO

-- Populate Ward
INSERT INTO Ward
	VALUES('W01','Tulip');

INSERT INTO Ward
	VALUES('W02','Primrose');

INSERT INTO Ward
	VALUES ('W03','Lylli');


--Poulate Patient

INSERT INTO Patient
	VALUES('P0001', 'George' , 'Wells', 'M' ,'11/06/2017', 'W02');

INSERT INTO Patient
	VALUES('P0002', 'Jean' , 'Austen', 'f' ,'01/13/2018', 'W01');

--Populate Doctor
INSERT INTO Doctor
	VALUES ('D0001', 'Andrew' , 'Balfur');

INSERT INTO Doctor
	VALUES ('D0002', 'James' , 'Wolfe');

INSERT INTO Doctor
	VALUES ('D0003', 'Wendy' , 'Golding');

INSERT INTO Doctor
	VALUES ('D0004', 'Petra' , 'Pavic');

INSERT INTO Doctor
	VALUES ('D0005', 'Derek' , 'Chen');


--Populate Treatment
INSERT INTO Treatment
		VALUES ('T0001','Eye Examination');

INSERT INTO Treatment
		VALUES ('T0002','Hearth Surgery');

INSERT INTO Treatment
		VALUES ('T0003','Laser Eye Surgery');

INSERT INTO Treatment
		VALUES ('T0004','Physiotherapy');

--Populare Qualification
INSERT INTO Qualification
	VALUES ('T0002','D0002','08/14/2015');

INSERT INTO Qualification
	VALUES ('T0001','D0001','09/25/2001');

INSERT INTO Qualification
	VALUES ('T0001','D0003','03/11/2010');

INSERT INTO Qualification
	VALUES ('T0003','D0001','11/17/2003');

INSERT INTO Qualification
	VALUES ('T0004','D0004','09/30/1997');

INSERT INTO Qualification
	VALUES ('T0004','D0005','05/03/2013');

--Populate Appointment
INSERT INTO Appointment
	VALUES ('11/06/2017','13:00:00','A2','D0001','T0001','P0001');

INSERT INTO Appointment
	VALUES ('11/07/2017','06:00:00','B3','D0001','T0003','P0001');

INSERT INTO Appointment
	VALUES ('11/08/2017','15:30:00','A1','D0003','T0001','P0001');

INSERT INTO Appointment
	VALUES ('01/19/2018','04:00:00','B3','D0002','T0002','P0002');

INSERT INTO Appointment
	VALUES ('02/22/2018','11:30:00','C1','D0004','T0004','P0002');

