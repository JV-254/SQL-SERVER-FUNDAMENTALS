CREATE DATABASE HospitalDB;
-- PATIENTS TABLE
CREATE TABLE Patients(
PatientID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Gender VARCHAR(50) NOT NULL,
DateOfBirth DATE NOT NULL,
Phone VARCHAR(50) NOT NULL,
Address VARCHAR(50) NOT NULL
);

-- DOCTORS TABLE
CREATE TABLE Doctors(
DoctorID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Specialization VARCHAR(50) NOT NULL,
Phone VARCHAR(50) NOT NULL
);

-- DEPARTMENTS TABLE
CREATE TABLE Departments(
DepartmentID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
DepartmentName VARCHAR(50) NOT NULL,
Location VARCHAR(50) NOT NULL
);

-- APPOINTMENTS TABLE
CREATE TABLE Appointments(
AppointmentID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
PatientID int NOT NULL,
DoctorID int NOT NULL,
AppointmentDate DATE NOT NULL,
AppointmentTime TIME NOT NULL,
Status VARCHAR(50) NOT NULL,

FOREIGN KEY(PatientID) REFERENCES Patients(PatientID),
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID)
);

--Altering appointment time column
ALTER TABLE  Appointments
ALTER COLUMN AppointmentTime TIME(0);

-- MEDICINES TABLE
CREATE TABLE Medicines(
MedicineID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
MedicineName VARCHAR(100) NOT NULL,
Quantity DECIMAL(10,2) NOT NULL,
Price DECIMAL(10,2) NOT NULL
);

--Prescriptions Table
CREATE TABLE Prescriptions(
PresctiptionID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
PatientID int NOT NULL,
DoctorID int NOT NULL,
MedicineID int NOT NULL,
PrescriptionDate DATE NOT NULL,
Dosage VARCHAR(50) NOT NULL,
Duration VARCHAR(50) NOT NULL,

FOREIGN KEY(PatientID) REFERENCES Patients(PatientID),
FOREIGN KEY(DoctorID) REFERENCES Doctors(DoctorID),
FOREIGN KEY(MedicineID) REFERENCES Medicines(MedicineID)
);

--INSERTING DATA
--1. Patients Data
INSERT INTO Patients
(FirstName, LastName, Gender, DateOfBirth, Phone, Address)
VALUES
('John', 'Kamau', 'Male', '1998-05-14', '0712345678', 'Nairobi'),
('Mary', 'Wanjiru', 'Female', '2001-08-22', '0723456789', 'Kiambu'),
('David', 'Otieno', 'Male', '1995-11-03', '0734567890', 'Kisumu'),
('Grace', 'Akinyi', 'Female', '2003-02-17', '0745678901', 'Nakuru'),
('Brian', 'Mwangi', 'Male', '1990-09-28', '0756789012', 'Thika');

--2. Doctors Data
INSERT INTO Doctors
(FirstName, LastName, Specialization, Phone)
VALUES
('Peter', 'Kamau', 'Cardiologist', '0711223344'),
('Sarah', 'Wanjiku', 'Pediatrician', '0722334455'),
('James', 'Otieno', 'Dermatologist', '0733445566'),
('Anne', 'Njeri', 'Neurologist', '0744556677'),
('David', 'Mwangi', 'General Physician', '0755667788');


--3. Department table
INSERT INTO Departments
(DepartmentName, Location)
VALUES
('Cardiology', 'Block A - 1st Floor'),
('Pediatrics', 'Block B - Ground Floor'),
('Dermatology', 'Block A - 2nd Floor'),
('Neurology', 'Block C - 1st Floor'),
('General Medicine', 'Block B - 1st Floor');

--4. Appointments Table
INSERT INTO Appointments
(PatientID, DoctorID, AppointmentDate, AppointmentTime, Status)
VALUES
(1, 1, '2026-10-05', '09:00:00', 'Scheduled'),
(2, 2, '2026-10-05', '10:30:00', 'Scheduled'),
(3, 3, '2026-10-06', '11:00:00', 'Completed'),
(4, 4, '2026-10-07', '14:00:00', 'Scheduled'),
(5, 5, '2026-10-08', '15:30:00', 'Cancelled');

--5.Medicines Table
INSERT INTO Medicines
(MedicineName, Quantity, Price)
VALUES
('Paracetamol', 500.0, 50.00),
('Amoxicillin', 250.0, 120.00),
('Ibuprofen', 300.0, 80.00),
('Cetirizine', 200.0, 60.00),
('Omeprazole', 150.0, 100.00);

--6. Prescriptions Table
INSERT INTO Prescriptions
(PatientID, DoctorID, MedicineID, PrescriptionDate, Dosage, Duration)
VALUES
(1, 1, 1, '2026-09-30', '500 mg', '5 days'),
(2, 2, 2, '2026-09-30', '500 mg', '7 days'),
(3, 3, 3, '2026-09-30', '400 mg', '5 days'),
(4, 4, 4, '2026-09-30', '10 mg', '7 days'),
(5, 5, 5, '2026-09-30', '20 mg', '14 days');

-- DISPLAYING DATA
SELECT*FROM Patients;
SELECT*FROM Doctors;
SELECT*FROM Departments;
SELECT*FROM Appointments;
SELECT*FROM Medicines;
SELECT*FROM Prescriptions;

-- (No. 16)  CHANGING PHONE NUMBER OF A PARTICULAR PATIENT
UPDATE Patients
SET Phone='0708795295'
WHERE PatientID=1;

SELECT FirstName,LastName,Phone
FROM Patients
WHERE PatientID=1;

--CHANGING ADDRESS OF A PATIENT FROM ONE LOCATION TO ANOTHER
UPDATE Patients
SET Address='Eldoret'
WHERE PatientID=3;

SELECT FirstName,LastName,Address
FROM Patients
WHERE PatientID=3;

--( No. 18) INCREASING THE PRICE OF ALL MEDICINES BY 10%
UPDATE Medicines
SET Price=(Price*1.10);

-- (No. 19) REDUCING THE QUANTITY OF A PARTICULAR MEDICINE BY 20
UPDATE Medicines
SET Quantity=(Quantity-20)
WHERE MedicineID=2;

SELECT MedicineName,Quantity
FROM Medicines
WHERE MedicineID=2;

--DELETING A PATIENT WHO HAVE NO APPOINTMENTS RECORD
SELECT p.*
FROM Patients AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM Appointments AS a
    WHERE a.PatientID = p.PatientID
);
SELECT*FROM Patients;
SELECT*FROM Appointments;

DELETE p
FROM Patients AS p
WHERE NOT EXISTS (
    SELECT 1
    FROM Appointments AS a
    WHERE a.PatientID = p.PatientID
);

--(No.21)  Find all patients whose gender is Female.
SELECT FirstName,LastName,Gender
FROM Patients
WHERE Gender='Female';

-- (No.22) Find all patients born after the year 1990.
-- Extracting the year of birth
SELECT FirstName,Lastname,
YEAR(DateOfBirth) AS BirthYear
FROM Patients
WHERE YEAR(DateOfBirth)>1990;

-- Find all doctors whose specialization is Cardiology.
SELECT*FROM Doctors;

SELECT FirstName,LastName,Specialization
FROM Doctors
WHERE Specialization='Cardiologist';

--  Display all medicines costing more than 100.
SELECT*FROM Medicines;

SELECT MedicineName,Price
FROM Medicines
WHERE Price>100;

-- Display medicines whose quantity is less than 200.
SELECT MedicineName, Quantity
FROM Medicines
WHERE Quantity<200;

-- Display patients in alphabetical order by their last name.
SELECT LastName
FROM Patients
ORDER BY LastName ASC;

-- Display doctors in descending order according to their specialization.
SELECT FirstName,LastName,Specialization
FROM Doctors
ORDER BY Specialization DESC;

-- Count the total number of patients.
SELECT COUNT(*) AS TotalNumberOfPatients
FROM Patients;

-- Count the total number of doctors.
SELECT COUNT(*) AS Total_Doctors
FROM Doctors;

-- Find the most expensive medicine.
SELECT*FROM Medicines;

SELECT TOP(1)
MedicineName,
Price
FROM Medicines
ORDER BY Price DESC;

-- Find the cheapest medicine.
SELECT TOP(1)
MedicineName,
Price
FROM Medicines
ORDER BY Price ASC;

-- Calculate the total value of all medicines in stock using:
SELECT Quantity,
Price,
ROUND((Quantity*Price),2) AS Total_Value
FROM Medicines;

-- (No.33) Display each appointment together with the patient's first name and last name.
SELECT
P.FirstName,
P.LastName,
A.AppointmentID
FROM Appointments AS A
JOIN Patients P
ON P.PatientID=A.PatientID;

-- Display each appointment together with the doctor's name.
SELECT
D.FirstName,
D.LastName,
A.AppointmentID
FROM Appointments AS A
JOIN Doctors D
ON D.DoctorID=A.DoctorID;

-- Display the patient's name, doctor's name, appointment date, and status.
SELECT*FROM Appointments;

SELECT
P.FirstName AS PatientFirstName,
P.LastName AS PatientLastName,
D.FirstName AS DoctorFirstName,
D.LastName AS DoctorLastName,
A.AppointmentDate,
A.Status,
A.PatientID,
A.DoctorID
FROM Appointments AS A
JOIN Patients P
ON P.PatientID=A.PatientID
JOIN Doctors D
ON D.DoctorID=A.DoctorID;

-- Display all patients who have appointments.
SELECT
P.FirstName,
P.LastName,
A.AppointmentID
FROM Appointments AS A
JOIN Patients P
ON P.PatientID=A.PatientID;

-- Display all doctors and the patients they are scheduled to see.
SELECT
D.FirstName AS Doctor_FirstName,
D.LastName AS Doctor_LastName,
P.FirstName AS Patient_FirstName,
P.LastName AS Patient_LastName,
A.AppointmentID
FROM Appointments AS A
JOIN Doctors D
ON D.DoctorID=A.DoctorID
JOIN Patients P
ON P.PatientID=A.PatientID;

-- (No. 38)  Display all prescriptions together with: Patient name, Doctor name, Medicine name, Dosage, Prescription dat
SELECT
PT.FirstName AS Patient_FirstName,
PT.LastName AS Patient_LastName,
D.FirstName AS Doctor_FirstName,
D.LastName AS Doctor_LastName,
M.MedicineName,
P.Dosage,
P.PrescriptionDate
FROM Prescriptions AS P
JOIN Patients PT
ON PT.PatientID=P.PatientID
JOIN Doctors D
ON D.DoctorID=P.DoctorID
JOIN Medicines M
ON M.MedicineID=P.MedicineID;

-- (No.39)  Find all patients who were prescribed Paracetamol.
SELECT
P.FirstName,
P.LastName,
M.MedicineName,
PT.PresctiptionID
FROM Prescriptions AS PT
JOIN Patients AS P
ON P.PatientID=PT.PatientID
JOIN Medicines AS M
ON M.MedicineID=PT.MedicineID
WHERE M.MedicineName='Paracetamol';

--(No.40)  Find all patients treated by a doctor specializing in Cardiology. 
SELECT
P.FirstName,
P.LastName,
D.Specialization
FROM Appointments AS A
JOIN Patients AS P
ON P.PatientID=A.PatientID
JOIN Doctors AS D
ON D.DoctorID=A.DoctorID
WHERE D.Specialization='Cardiologist';

-- Display the number of appointments handled by each doctor.
SELECT
D.FirstName,
D.LastName,
COUNT(A.AppointmentID) AS Number_Of_Appointments
FROM Appointments AS A
JOIN Doctors AS D
ON D.DoctorID=A.DoctorID
GROUP BY D.DoctorID,D.FirstName,D.LastName;

-- AGGREGATE FUNCTIONS
--( No. 46) Find the total number of patients.
SELECT
COUNT(*) AS Total_Patients
FROM Patients;

--(No.47)  Find the average price of all medicines.
SELECT
ROUND(AVG(Price),2) AS Avg_Price
FROM Medicines;

--Find the maximum medicine price.
SELECT
MAX(Price) AS Max_Price
FROM Medicines;

-- Find the minimum medicine price.
SELECT
MIN(Price) AS Min_Price
FROM Medicines;

-- Find the total quantity of medicines in stock.
SELECT
SUM(Quantity) AS Total_Quantity
FROM Medicines;

-- Find the total value of medicines in the pharmacy.
SELECT
SUM(Price) AS Total_Value
FROM Medicines;

-- Count the number of doctors in each specialization.
SELECT
Specialization,
COUNT(Specialization) AS Number_Of_Doctors
FROM Doctors
GROUP BY Specialization;

-- Count the number of appointments for each doctor.
SELECT
D.FirstName,
D.LastName,
COUNT(A.AppointmentID) AS Number_Of_Appointments
FROM Appointments AS A
JOIN Doctors AS D
ON D.DoctorID=A.DoctorID
GROUP BY D.DoctorID,D.FirstName,D.LastName;

-- Create a MsSQL user named: Doctor1 with an appropriate password.Doc# 123
CREATE LOGIN Doctor1
WITH PASSWORD ='Doc# 123';

CREATE USER Doctor1
FOR LOGIN Doctor1;

-- Create a user named: receptionist1
CREATE USER receptionist1
FOR LOGIN receptionist1;

-- Create a user named: pharmacist1
CREATE USER pharmacist1
FOR LOGIN pharmacist1;

-- Display the privileges assigned to doctort.
SELECT*
FROM fn_my_permissions('Doctor1','USER');

-- Display the privileges assigned to receptionist1.
SELECT*
FROM fn_my_permissions('receptionist1','USER');

-- Display the privileges assigned to pharmacistt.
SELECT*
FROM fn_my_permissions('pharmacist1','USER');

-- ROLES
-- Create a role called: Doctor Role
CREATE ROLE [Doctor Role];

-- Verifying the role
SELECT name
FROM sys.database_principals
WHERE name = 'Doctor Role';

-- Create a role called: Receptionist Role
CREATE ROLE [Receptionist Role];

--Verifying the role
SELECT name
FROM sys.database_principals
WHERE name= 'Receptionist Role';

-- Grant the doctor role permission to view patient information.
GRANT SELECT ON Patients TO [Doctor Role];

-- Verifying the permission granted
SELECT*
FROM fn_my_permissions('Patients','OBJECT');

-- Grant the doctor role permission to view appointments.
GRANT SELECT ON Appointments TO [Doctor Role];

-- Verifying the role granted
SELECT*
FROM fn_my_permissions('Appointments','OBJECT');

-- Grant the doctor role permission to insert and update prescriptions.
GRANT INSERT,UPDATE ON Prescriptions TO [Doctor Role];

--Verifying the query
SELECT*
FROM fn_my_permissions('Prescriptions','OBJECT');

-- Grant the receptionist role permission to insert and update patient records.
GRANT INSERT, UPDATE ON Patients TO [Receptionist Role];

-- Verifying the permission
SELECT*
FROM fn_my_permissions('Patients','OBJECT');

-- Grant the receptionist role permission to insert, update, and delete appointments.
GRANT INSERT,UPDATE,DELETE ON Appointments TO [Receptionist Role];

-- Creating role called pharmacist role
CREATE ROLE [Pharmacist Role];

-- Grant the pharmacist role permission to view prescriptions.
GRANT SELECT ON Prescriptions TO [Pharmacist Role];

-- Grant the pharmacist role permission to insert and update medicine records.
GRANT INSERT,UPDATE ON Medicines TO [Pharmacist Role];

-- Assign doctor role to doctor1.
ALTER ROLE [Doctor Role]
ADD MEMBER Doctor1;

-- .Assign receptionist role to receptionistt.
ALTER ROLE [Receptionist Role]
ADD MEMBER receptionist1;

-- Assign pharmacist role to pharmacist t.
ALTER ROLE [Pharmacist Role]
ADD MEMBER pharmacist1;

SELECT*FROM Patients;