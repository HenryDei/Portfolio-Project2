Create Database PortfolioProjectII
Use PortfolioProjectII

CREATE TABLE Physician (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name nvarchar(50) NOT NULL,
  Position nvarchar(50) NOT NULL,
  SSN INTEGER NOT NULL
); 

CREATE TABLE Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name Nvarchar(50) NOT NULL,
  Head INTEGER NOT NULL
    CONSTRAINT fk_Physician_EmployeeID REFERENCES Physician(EmployeeID)
);

CREATE TABLE Affiliated_With (
  Physician INTEGER NOT NULL,
  Department INTEGER NOT NULL
    CONSTRAINT fk_Department_DepartmentID REFERENCES Department(DepartmentID),
  PrimaryAffiliation int NOT NULL,
  PRIMARY KEY(Physician, Department)
);

CREATE TABLE Proceduree (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name Nvarchar(50) NOT NULL,
  Cost REAL NOT NULL
);

CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL,
  Treatment INTEGER NOT NULL
    CONSTRAINT fk_Procedure_Code REFERENCES Proceduree(Code),
  CertificationDate DATETIME NOT NULL,
  CertificationExpires DATETIME NOT NULL,
  PRIMARY KEY(Physician, Treatment)
);

CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name Nvarchar(50) NOT NULL,
  Address TEXT NOT NULL,
  Phone Nvarchar(50) NOT NULL,
  InsuranceID INTEGER NOT NULL,
  PCP INTEGER NOT NULL
);

CREATE TABLE Nurse (
  EmployeeID INTEGER PRIMARY KEY NOT NULL,
  Name Nvarchar(50) NOT NULL,
  Position Nvarchar(50) NOT NULL,
  Registered Nvarchar(50) NOT NULL,
  SSN INTEGER NOT NULL
);

CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL
    CONSTRAINT fk_Patient_SSN REFERENCES Patient(SSN),
  PrepNurse INTEGER
    CONSTRAINT fk_Nurse_EmployeeID REFERENCES Nurse(EmployeeID),
  Physician INTEGER NOT NULL,
  Start DATETIME NOT NULL,
  Ennd DATETIME NOT NULL,
  ExaminationRoom Nvarchar(50) NOT NULL
);

CREATE TABLE Medication (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name Nvarchar(50) NOT NULL,
  Brand Nvarchar(50) NOT NULL,
  Description Nvarchar(50) NOT NULL
);

CREATE TABLE Prescribes (
  Physician INTEGER NOT NULL,
  Patient INTEGER NOT NULL,
  Medication INTEGER NOT NULL
    CONSTRAINT fk_Medication_Code REFERENCES Medication(Code),
  Date DATETIME NOT NULL,
  Appointment INTEGER
    CONSTRAINT fk_Appointment_AppointmentID REFERENCES Appointment(AppointmentID),
  Dose Nvarchar(50) NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date)
);

CREATE TABLE Block (
  Floor INTEGER NOT NULL,
  Code INTEGER NOT NULL,
  PRIMARY KEY(Floor, Code)
); 

CREATE TABLE Room (
  Number INTEGER PRIMARY KEY NOT NULL,
  Type Nvarchar(50) NOT NULL,
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Unavailable nvarchar(50) NOT NULL,
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block
);

CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL,
  BlockFloor INTEGER NOT NULL,
  BlockCode INTEGER NOT NULL,
  Start DATETIME NOT NULL,
  Ennd DATETIME NOT NULL,
  PRIMARY KEY(Nurse, BlockFloor, BlockCode, Start, Ennd),
  FOREIGN KEY(BlockFloor, BlockCode) REFERENCES Block
);

CREATE TABLE Stay (
  StayID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  Room INTEGER NOT NULL
    CONSTRAINT fk_Room_Number REFERENCES Room(Number),
  Start DATETIME NOT NULL,
  Ennd DATETIME NOT NULL
);

CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL,
  Proceduree INTEGER NOT NULL,
  Stay INTEGER NOT NULL
    CONSTRAINT fk_Stay_StayID REFERENCES Stay(StayID),
  Date DATETIME NOT NULL,
  Physician INTEGER NOT NULL,
  AssistingNurse INTEGER
  PRIMARY KEY(Patient, Proceduree, Stay, Date)
);

INSERT INTO Physician VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO Physician VALUES(2,'Elliot Reid','Attending Physician',222222222);
INSERT INTO Physician VALUES(3,'Christopher Turk','Surgical Attending Physician',333333333);
INSERT INTO Physician VALUES(4,'Percival Cox','Senior Attending Physician',444444444);
INSERT INTO Physician VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO Physician VALUES(6,'Todd Quinlan','Surgical Attending Physician',666666666);
INSERT INTO Physician VALUES(7,'John Wen','Surgical Attending Physician',777777777);
INSERT INTO Physician VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO Physician VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

INSERT INTO Department VALUES(1,'General Medicine',4);
INSERT INTO Department VALUES(2,'Surgery',7);
INSERT INTO Department VALUES(3,'Psychiatry',9);

INSERT INTO Affiliated_With VALUES(1,1,1);
INSERT INTO Affiliated_With VALUES(2,1,1);
INSERT INTO Affiliated_With VALUES(3,1,0);
INSERT INTO Affiliated_With VALUES(3,2,1);
INSERT INTO Affiliated_With VALUES(4,1,1);
INSERT INTO Affiliated_With VALUES(5,1,1);
INSERT INTO Affiliated_With VALUES(6,2,1);
INSERT INTO Affiliated_With VALUES(7,1,0);
INSERT INTO Affiliated_With VALUES(7,2,1);
INSERT INTO Affiliated_With VALUES(8,1,1);
INSERT INTO Affiliated_With VALUES(9,3,1);

INSERT INTO Proceduree VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO Proceduree VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO Proceduree VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO Proceduree VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO Proceduree VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO Proceduree VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO Proceduree VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO Patient VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO Patient VALUES(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO Patient VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO Nurse VALUES(101,'Carla Espinosa','Head Nurse','True',111111110);
INSERT INTO Nurse VALUES(102,'Laverne Roberts','Nurse','True',222222220);
INSERT INTO Nurse VALUES(103,'Paul Flowers','Nurse','False',333333330);

INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO Appointment VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO Appointment VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO Appointment VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO Appointment VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO Appointment VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO Appointment VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO Appointment VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO Appointment VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO Medication VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO Medication VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO Medication VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO Medication VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO Prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO Prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO Block VALUES(1,1);
INSERT INTO Block VALUES(1,2);
INSERT INTO Block VALUES(1,3);
INSERT INTO Block VALUES(2,1);
INSERT INTO Block VALUES(2,2);
INSERT INTO Block VALUES(2,3);
INSERT INTO Block VALUES(3,1);
INSERT INTO Block VALUES(3,2);
INSERT INTO Block VALUES(3,3);
INSERT INTO Block VALUES(4,1);
INSERT INTO Block VALUES(4,2);
INSERT INTO Block VALUES(4,3);

INSERT INTO Room VALUES(101,'Single',1,1,'False');
INSERT INTO Room VALUES(102,'Single',1,1,'False');
INSERT INTO Room VALUES(103,'Single',1,1,'False');
INSERT INTO Room VALUES(111,'Single',1,2,'False');
INSERT INTO Room VALUES(112,'Single',1,2,'True');
INSERT INTO Room VALUES(113,'Single',1,2,'False');
INSERT INTO Room VALUES(121,'Single',1,3,'False');
INSERT INTO Room VALUES(122,'Single',1,3,'False');
INSERT INTO Room VALUES(123,'Single',1,3,'False');
INSERT INTO Room VALUES(201,'Single',2,1,'True');
INSERT INTO Room VALUES(202,'Single',2,1,'False');
INSERT INTO Room VALUES(203,'Single',2,1,'False');
INSERT INTO Room VALUES(211,'Single',2,2,'False');
INSERT INTO Room VALUES(212,'Single',2,2,'False');
INSERT INTO Room VALUES(213,'Single',2,2,'True');
INSERT INTO Room VALUES(221,'Single',2,3,'False');
INSERT INTO Room VALUES(222,'Single',2,3,'False');
INSERT INTO Room VALUES(223,'Single',2,3,'False');
INSERT INTO Room VALUES(301,'Single',3,1,'False');
INSERT INTO Room VALUES(302,'Single',3,1,'True');
INSERT INTO Room VALUES(303,'Single',3,1,'False');
INSERT INTO Room VALUES(311,'Single',3,2,'False');
INSERT INTO Room VALUES(312,'Single',3,2,'False');
INSERT INTO Room VALUES(313,'Single',3,2,'False');
INSERT INTO Room VALUES(321,'Single',3,3,'True');
INSERT INTO Room VALUES(322,'Single',3,3,'False');
INSERT INTO Room VALUES(323,'Single',3,3,'False');
INSERT INTO Room VALUES(401,'Single',4,1,'False');
INSERT INTO Room VALUES(402,'Single',4,1,'True');
INSERT INTO Room VALUES(403,'Single',4,1,'False');
INSERT INTO Room VALUES(411,'Single',4,2,'False');
INSERT INTO Room VALUES(412,'Single',4,2,'False');
INSERT INTO Room VALUES(413,'Single',4,2,'False');
INSERT INTO Room VALUES(421,'Single',4,3,'True');
INSERT INTO Room VALUES(422,'Single',4,3,'False');
INSERT INTO Room VALUES(423,'Single',4,3,'False');

INSERT INTO On_Call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO On_Call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO On_Call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO Stay VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO Stay VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO Stay VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO Undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO Undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO Undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO Undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO Undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO Undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO Trained_In VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO Trained_In VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO Trained_In VALUES(7,7,'2008-01-01','2008-12-31');


-- An SQL query to find out which nurses have not yet been registered.
select * from Nurse

Select * from nurse
where Registered = 'False';


-- An SQL query to identify the nurse(s) in charge of each department. Returning nursename as “name”, Position as “Position”.
SELECT name AS "Name",
       POSITION AS "Position"
FROM nurse
WHERE POSITION = 'Head Nurse';


-- A query to identify the physicians who are the department heads. Returning Department name as “Department” and Physician name as “Physician”
SELECT P.Name as Physician,
       D.Name as Department
FROM Physician P, 
     Department D
WHERE P.EmployeeID = D.Head


--A query to count the number of patients who scheduled an appointment with at least one physician.
SELECT count(Distinct Patient) as 'No_ of patient taken at least one appointment' 
FROM [dbo].[Appointment]


-- SQL query to locate the floor and block where room number 212 is located
SELECT Blockfloor as 'Floor', 
       Blockcode as 'Block' 
FROM Room
WHERE Number = 212


-- A Query to count the number of  available rooms
Select Count(Unavailable) as 'Rooms Available' from Room
where Unavailable = 'False'


-- SQL query to identify the physician and the department with which he or she is affiliated
SELECT P.name as Physician, 
       D.Name as Deparment
FROM  Affiliated_With A, Physician P, Department D
WHERE P.EmployeeID = A.Physician 
  AND D.DepartmentID = A.Department
       --OR(Using Join)--
SELECT P.name as Physician, 
       D.Name as Deparment
FROM  Affiliated_With A
JOIN  Physician P
  ON P.EmployeeID = A.Physician 
JOIN Department D
  ON D.DepartmentID = A.Department


-- SQL query to find those physicians who have received special training and the treatment.
SELECT P.Name as Physician,
       Pr.Name as Treatment
FROM Physician P
JOIN Trained_In T
  ON P.EmployeeID = T.Physician
JOIN Proceduree Pr
  ON Pr.Code = T.Treatment


-- SQL query to identify physicians who are not specialised. Returning Physician name as "Physician", position as "Designation"
SELECT p.name AS Physician,
       p.position Designation
FROM Physician p
LEFT JOIN trained_in t 
  ON p.employeeid = t.physician
WHERE t.treatment IS NULL
ORDER BY employeeid;


-- SQL query to find the patients with their address and the physicians by whom they received preliminary treatment.
SELECT Pa.Name as Patient,
       Pa.Address,
       P.Name as Physician 
FROM Physician P
JOIN Patient Pa
  ON p.EmployeeID = pa.PCP


 -- SQL query to count the number of unique patients who have been scheduled for examination room 'C'.
SELECT Count(ExaminationRoom) AS 'No. of patients who got appointment for room C'
FROM Appointment
WHERE ExaminationRoom = 'C'


-- SQL query to identify the patients and the number of physicians with whom they have scheduled appointments
SELECT Pa.Name as Patient, Count(Physician) AS  "Appointment for No. of Physicians"
FROM Patient Pa
JOIN Appointment A
  ON Pa.SSN = A.Patient
GROUP BY Pa.Name
ORDER BY 'Appointment for No. of Physicians'


-- SQL query to find the names of the patients the Examinationroom where they need to be treated and the date to be treated.
SELECT Pa.Name AS Patient, 
       ExaminationRoom, 
	   Start AS 'Date and Time of appointment'
FROM Patient Pa
JOIN Appointment A
  ON Pa.SSN = A.Patient


-- SQL query to identify the name of nurses and the room in which they will assist the physicians
Select N.Name 'Nurses Name', 
       Examinationroom 
FROM Nurse N, Appointment A
WHERE N.EmployeeID = A.PrepNurse
ORDER BY ExaminationRoom


--SQL query to locate the Physicians, Nurses and the patients who attended the appointment on the 25th of April at 10 a.m.
SELECT Pa.Name AS 'Patient',
       N.Name AS 'Assisting Nurse',
	   P.Name AS 'Physician',
       Start AS 'Appointment',
	   ExaminationRoom
FROM Patient Pa
JOIN Appointment A
  ON Pa.SSN = A.Patient
JOIN Nurse N
  ON N.EmployeeID = A.PrepNurse
JOIN Physician P
  ON P.EmployeeID = A.Physician
WHERE Start = '2008-04-25 10:00:00'


-- SQL query to identify those patients and their physicians who do not require any nursing assistance
SELECT Pa.Name AS Patient,
       P.Name AS Physician,
	   ExaminationRoom
FROM Patient Pa
JOIN Appointment A
  ON Pa.SSN = A.Patient
JOIN Physician P
  ON P.EmployeeID = A.Physician
WHERE PrepNurse IS NULL


--  SQL query to find out the patient, the medications given and the treated physician.
SELECT Pa.name AS 'Patient',       
	   M.name AS 'Medication',
	   P.name AS 'Physician'
FROM Patient Pa
JOIN Prescribes Pr ON Pa.SSN = Pr.Patient
JOIN Physician P   ON P.EmployeeID = Pr.Physician
JOIN Medication M  ON M.Code = Pr.Medication
ORDER BY Patient

-- SQL query to count the number of available rooms in each block.
SELECT BlockCode AS 'Block', 
       Count(*) 'No. of Available Rooms'
FROM Room
WHERE Unavailable = 'False'
GROUP BY BlockCode

--- CREATING STORED PROCEDURE for available rooms in each block
CREATE Procedure Block_Available_Rooms 
AS
SELECT BlockCode AS 'Block', 
       Count(*) 'No. of Available Rooms'
FROM Room
WHERE Unavailable = 'False'
GROUP BY BlockCode

Exec Block_Available_Rooms


-- SQL query to count the number of available rooms in each floor.
SELECT Blockfloor AS 'Floor',
       Count(*) 'No. of Available Rooms'
FROM Room
WHERE Unavailable = 'False'
GROUP BY Blockfloor


-- SQL query to count the number of rooms that are unavailable in each block and on each floor.
SELECT Blockcode AS 'Block',
       Blockfloor AS 'Floor',
	   Count(*) 'No. of Unavailable Rooms'
FROM Room
WHERE Unavailable = 'True'
GROUP BY BlockCode, BlockFloor
ORDER BY BlockCode, BlockFloor


--SQL query to find the floor where the maximum number of rooms are available.
SELECT Top 1 
       Blockfloor AS 'Floor',
       Count(Blockfloor) AS 'No. of Available Rooms' 
FROM Room
WHERE Unavailable = 'False'
GROUP BY BlockFloor
ORDER BY 'No. of Available Rooms' Desc
		 --OR--
SELECT BlockFloor AS 'Floor',
       Count(*) AS  'No. of available rooms'
FROM Room
WHERE Unavailable= 'False'
GROUP BY BlockFloor
HAVING count(*) =
  (SELECT max(zz) AS highest_total
   FROM
  (SELECT blockfloor,
          count(*) AS zz
   FROM room
   WHERE unavailable= 'False'
   GROUP BY blockfloor ) AS t )


--  Creating a View for easy access
Create View the_maximum_number_of_rooms_available 
AS
SELECT BlockFloor AS 'Floor',
       Count(*) AS  'No. of available rooms'
FROM Room
WHERE Unavailable= 'False'
GROUP BY BlockFloor
HAVING count(*) =
  (SELECT max(zz) AS highest_total
   FROM
  (SELECT blockfloor,
          count(*) AS zz
   FROM room
   WHERE unavailable= 'False'
   GROUP BY blockfloor ) AS t )


Select * from the_maximum_number_of_rooms_available
