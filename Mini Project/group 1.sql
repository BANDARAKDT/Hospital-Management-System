create database hospital;
use hospital;

CREATE USER IF NOT EXISTS Admin@localhost IDENTIFIED BY 'admin123';
CREATE USER IF NOT EXISTS Doctor@localhost IDENTIFIED BY 'doctor123';
CREATE USER IF NOT EXISTS Patients@localhost IDENTIFIED BY 'patients123';
CREATE USER IF NOT EXISTS Laboratory_Staff@localhost IDENTIFIED BY 'laboratory123';
SELECT USER FROM mysql.user;   /*Show current users*/
GRANT ALL PRIVILEGES ON *.* TO Admin@localhost WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO Doctor@localhost;
GRANT SELECT,SHOW VIEW ON *.* TO Patients@localhost;
GRANT ALL PRIVILEGES ON *.* TO Laboratory_Staff@localhost;
REVOKE CREATE USER ON *.* FROM Laboratory_Staff@localhost;

create table InPatient
(
p_id VARCHAR(10) NOT NULL PRIMARY KEY,
F_name VARCHAR(30) NOT NULL,
L_name VARCHAR(30) NOT NULL,
Address VARCHAR(100) NOT NULL,
DOB date,
Postal_code VARCHAR(10),
contact_No VARCHAR(15),
date_of_admit DATE,
date_of_discharge DATE,
Gender ENUM('Male','Female')
);

CREATE TABLE OutPatient
(
p_id VARCHAR(10) PRIMARY KEY NOT NULL,
DOB DATE,
Address VARCHAR(100),
P_Name VARCHAR(50)
);

create table InPatientBill
(
bill_no VARCHAR(10) NOT NULL PRIMARY KEY,
room_charge DECIMAL(8,2),
Lab_charge DECIMAL (8,2),
operation_charge DECIMAL(8,2),
nursing_charge DECIMAL(8,2),
doctor_charge DECIMAL(8,2),
Inp_id VARCHAR(10),
FOREIGN KEY(Inp_id) REFERENCES InPatient(P_id)
);
create table OutPatientBill
(
bill_no VARCHAR(10) NOT NULL PRIMARY KEY,
room_charge DECIMAL(8,2),
Lab_charge DECIMAL (8,2),
operation_charge DECIMAL(8,2),
nursing_charge DECIMAL(8,2),
doctor_charge DECIMAL(8,2),
Out_id VARCHAR(10),
FOREIGN KEY(Out_id) REFERENCES OutPatient(P_id)
);

CREATE TABLE Room
(
Room_No VARCHAR(10) NOT NULL PRIMARY KEY,
Room_type VARCHAR(20),
Stat VARCHAR(30),
Inp_id VARCHAR(10) NOT NULL,
FOREIGN KEY(Inp_id) REFERENCES InPatient(P_id)
);

CREATE TABLE InPatientDiseases
(
p_id VARCHAR(10) NOT NULL,
diseases VARCHAR(100),
FOREIGN KEY(p_id) REFERENCES InPatient(P_id)
);

CREATE TABLE OutPatientDiseases
(
p_id VARCHAR(10) NOT NULL,
diseases VARCHAR(100),
FOREIGN KEY(p_id) REFERENCES OutPatient(P_id)
);


CREATE TABLE Staff
(
s_name VARCHAR(30),
s_id VARCHAR(10) NOT NULL PRIMARY KEY,
salary DECIMAL(8,2) NOT NULL,
NID INT
);

CREATE TABLE Administrator
(
a_id VARCHAR(10) NOT NULL PRIMARY KEY,
a_name VARCHAR(30),
gender ENUM('Male','Female'),
as_id VARCHAR(10) NOT NULL,
FOREIGN KEY(as_id) REFERENCES Staff(s_id)
);

CREATE TABLE Department
(
Dep_name VARCHAR(20) NOT NULL,
Dep_id VARCHAR(10) NOT NULL PRIMARY KEY
);

CREATE TABLE Doctor
(
Doc_id VARCHAR(10) NOT NULL PRIMARY KEY,
F_name VARCHAR(30) NOT NULL,
L_name VARCHAR(30),
E_mail VARCHAR(50),
speciality VARCHAR(30),
Doc_password VARCHAR(30),
Gender ENUM('Male','Female'),
Address VARCHAR(100),
contact_no VARCHAR(15),
Dep_id VARCHAR(10) NOT NULL,
s_id VARCHAR(10),
a_id VARCHAR(10),
FOREIGN KEY(Dep_id) REFERENCES Department(Dep_id),
FOREIGN KEY(a_id) REFERENCES Administrator(a_id),
FOREIGN KEY(s_id) REFERENCES Staff(s_id)
);

CREATE TABLE InPatient_Lab_report
(
LabR_no VARCHAR(10) NOT NULL PRIMARY KEY,
Amount INT,
category VARCHAR(20),
patient_type VARCHAR(20),
Date_ DATE,
Doc_id VARCHAR(10) NOT NULL,
Inp_id VARCHAR(10) NOT NULL,
FOREIGN KEY(Doc_id) REFERENCES Doctor(Doc_id),
FOREIGN KEY(Inp_id) REFERENCES InPatient(p_id)
);

CREATE TABLE OutPatient_Lab_report
(
LabR_no VARCHAR(10) NOT NULL PRIMARY KEY,
Amount INT,
category VARCHAR(20),
patient_type VARCHAR(20),
Date_ DATE,
Doc_id VARCHAR(10) NOT NULL,
Outp_id VARCHAR(10) NOT NULL,
FOREIGN KEY(Doc_id) REFERENCES Doctor(Doc_id),
FOREIGN KEY(Outp_id) REFERENCES OutPatient(p_id)
);

INSERT INTO InPatient
(p_id,F_name,L_name,Address,DOB,Postal_code,contact_No,date_of_admit,date_of_discharge,Gender)
VALUES
('INP001','Nimal','Harischandra','Galle','1987-5-1','80000','112338741','2022-12-8','2022-2-16','male'),
('INP002','Dharshana','Rupasinghe','Matara','1986-5-26','81000','011 257441','2022-1-24','2022-2-14','male'),
('INP003','Piyamantha','Yasitha','Rathnapura','1978-5-4','70000','011 2195566','2022-2-14','2022-3-1','male'),
('INP004','Dilshan','Pathirana','Embilipitiya','1988-3-8','70200','112338741','2022-2-17','2022-2-27','male'),
('INP005','Sumith','Bandara','Kahawatta','1998-9-25','70150','011 2321160','2022-3-27','2022-4-12','male'),
('INP006','Kamala','Jayasooriya','Kuruwita','1956-12-30','70500','011 2118913','2022-5-22','2022-5-26','female'),
('INP007','Vimala','Senevirathne','Tangalle','1965-4-12','82200','011 7640500','2022-6-20','2022-7-1','male'),
('INP008','Salinda','jayasinghe','Kegalle','1962-07-8','71000','011 7640507','2022-7-4','2022-7-25','male'),
('INP009','Kawinda','Lakshan','Dikwella','1977-5-28','81200','011 7640215','2022-5-23',NULL,'male'),
('INP010','Thalatha','Herath','Mirissa','1989-10-13','81740','011 2445487','2022-10-1',NULL,'female');

INSERT INTO OutPatient
(p_id,DOB,Address,P_Name)
VALUES
('OUTP001','1987-1-5','Galle','gunawardhene'),
('OUTP002','1986-5-26','Matara','rathnayeka'),
('OUTP003','1978-5-4','Rathnapura','amarasiri'),
('OUTP004','1988-3-8','Embilipitiya','sugath'),
('OUTP005','1998-9-25','Kahawatta','rathnayake'),
('OUTP006','1956-12-30','Kuruwita','rajapaksha'),
('OUTP007','1965-4-12','Tangalle','gunarathne'),
('OUTP008','1962-7-8','Kegalle','silva'),
('OUTP009','1977-5-28','Dikwella','arachchi'),
('OUTP010','1989-10-13','Mirissa','sumanadasa');

INSERT INTO InPatientBill
(bill_no,room_charge,Lab_charge,operation_charge,nursing_charge,doctor_charge,Inp_id)
VALUES
('IB001',600.00,1500.00,500.00,200.00,5000.00,'INP001'),
('IB002',700.00,1525.00,550.00,100.00,4500.00,'INP002'),
('IB003',650.00,1600.00,600.00,150.00,3000.00,'INP003'),
('IB004',700.00,1700.00,550.00,100.00,2500.00,'INP004'),
('IB005',800.00,1650.00,450.00,200.00,4500.00,'INP005'),
('IB006',600.00,1500.00,600.00,250.00,2500.00,'INP006'),
('IB007',550.00,1400.00,700.00,250.00,3000.00,'INP007'),
('IB008',800.00,1450.00,650.00,150.00,2750.00,'INP008'),
('IB009',750.00,1300.00,800.00,300.00,3650.00,'INP009'),
('IB010',850.00,1250.00,600.00,100.00,5500.00,'INP010');

INSERT INTO OutPatientBill
(bill_no,room_charge,Lab_charge,operation_charge,nursing_charge,doctor_charge,Out_id)
VALUES
('OB011',null,null,700.00,null,6000.00,'OUTP001'),
('OB012',null,null,600.00,null,5500.00,'OUTP002'),
('OB013',null,null,450.00,null,4550.00,'OUTP003'),
('OB014',null,null,500.00,null,3500.00,'OUTP004'),
('OB015',null,null,450.00,null,4525.00,'OUTP005'),
('OB016',null,null,500.00,null,3650.00,'OUTP006'),
('OB017',null,null,350.00,null,2300.00,'OUTP007'),
('OB018',null,null,300.00,null,3300.00,'OUTP008'),
('OB019',null,null,500.00,null,2500.00,'OUTP009'),
('OB020',null,null,400.00,null,4250.00,'OUTP010');

INSERT INTO Room
(Room_No,Room_type,Stat,Inp_id)
VALUES
('RM01','special','unknown','INP001'),
('RM02','special','unknown','INP002'),
('RM03','special','unknown','INP003'),
('RM04','special','unknown','INP004'),
('RM05','special','unknown','INP005'),
('RM06','local','unknown','INP006'),
('RM07','local','unknown','INP007'),
('RM08','local','unknown','INP008'),
('RM09','local','unknown','INP009'),
('RM10','local','unknown','INP010');

INSERT INTO InPatientDiseases
(p_id,diseases)
VALUES
('INP001','Bird flu'),
('INP001','malariya'),
('INP002','Arthritis'),
('INP003','Asthma'),
('INP003','dengue'),
('INP004','Autism'),
('INP004','Bird flu'),
('INP005','chikungunya'),
('INP005','dengue'),
('INP006','depression'),
('INP007','edema'),
('INP008','leukemia'),
('INP008','Bird flu'),
('INP009','edema'),
('INP010','Bird flu');

INSERT INTO Staff
(S_id,S_name,salary,NID)
VALUES
('S01','M.G. Shehan',20000.00,112233),
('S02','K.P. Dulani',35000.00,223344),
('S03','H.G.Piyantha',45000.00,334455),
('S04','B. Lalith',25000.00,445566),
('S05','K.S. Pathirana',20000.00,556677),
('S06','R. Kaushi',25000.00,778899);

INSERT INTO Administrator
(a_id,a_name,gender,as_id)
VALUES
('A01','A.W.Perera','Male','S01'),
('A02','M.Shekar','Male','S02'),
('A03','S.M. Kumar','Male','S03'),
('A04','P.L.Lalith','Male','S04'),
('A05','K.N.Dilipa','Female','S05'),
('A06','Y.A. Suren','Male','S06');

INSERT INTO Department
(Dep_id,Dep_name)
VALUES
('D01','General Medicine'),
('D02','Surgery'),
('D03','Psychiatry');

INSERT INTO Doctor
(Doc_id,F_name,L_name,E_mail,speciality,Doc_password,Gender,Address,contact_no,Dep_id,S_id,a_id)
VALUES
('DOC001','Agatha','Smith','ag123tha@gmail.com','Preventive medicine','DPW001','Female','Galle','011 3478904','D01','S01','A01'),
('DOC002','Peter','Flanders','pet609@gmail.com','Gynecology','DPW002','Male','Mathara','071 6709238','D02','S02','A02'),
('DOC003','Joe','Williams','joewill987@gmail.com','Ophthalmology','DPW003','Male','Colombo','078 9863521','D03','S03','A03'),
('DOC004','Jack','Granger','jackgra567@gmail.com','Pathalogy','DPW004','Male','Gampaha','011 5867900','D01','S04','A04'),
('DOC005','Angela','Beckham','angelab765@gmail.com','Neurology','DPW005','Female','Kaluthara','091 6790432','D03','S05','A05'),
('DOC006','Amanda','Potter','pottera543@gmail.com','Pathalogy','DPW006','Female','Mathale','076 8990341','D03','S06','A06'),
('DOC007','Andrew','Taylor','andrewt322@gmail.com','Surgery','DPW007','Male','Kandy','075 0213456','D02','S03','A03'),
('DOC008','Rose','Alexandra','alexand598@gmail.com','Emergency medicine','DPW008','Female','Ampara','072 5679801','D01','S05','A04'),
('DOC009','Anne','Beatrix','anne698@gmail.com','Preventive medicine','DPW009','Female','Polonnaruwa','011 0968432','D02','S06','A01'),
('DOC010','David','Jack','davidj792@gmail.com','Emergency medicine','DPW010','Male','Kurunegala','071 5679802','D03','S01','A02');


INSERT INTO InPatient_Lab_report
(LabR_no,Amount,category,Patient_type,Date_,Doc_id,Inp_id)
VALUES	
('InLab01',24,'Pediatric','Primary','2022-10-12','DOC001','INP001'),
('InLab02',56,'Gynecology','Speciality','2022-10-13','DOC002','INP002'),
('InLab03',45,'Ophthalmology','Emergency','2022-10-24','DOC003','INP003'),
('InLab04',23,'Anesthesiology','Long-term','2022-10-21','DOC004','INP004'),
('InLab05',34,'Neurology','Urgent','2022-10-23','DOC005','INP005'),
('InLab06',54,'Pathalogy','Emergency','2022-10-10','DOC006','INP006'),
('InLab07',12,'Surgery','Long-term','2022-10-15','DOC007','INP007'),
('InLab08',78,'Psychiatry','Primary','2022-10-4','DOC008','INP008'),
('InLab09',34,'Preventive medicine','Mental','2022-10-17','DOC009','INP009'),
('InLab10',67,'Emergency medicine','Emergency','2022-10-25','DOC010','INP010');



INSERT INTO OutPatient_Lab_report
VALUES
('OutLab01',43,'Surgery','Urgent','2022-10-31','DOC003','OUTP004'),
('OutLab02',56,'Neurology','Urgent','2022-10-25','DOC005','OUTP008'),
('OutLab03',23,'Gynecology','Speciality','2022-10-17','DOC008','OUTP001'),
('OutLab04',65,'Pediatric','Primary','2022-10-24','DOC002','OUTP008'),
('OutLab05',89,'Opthalmology','Emergency','2022-11-1','DOC001','OUTP008'),
('OutLab06',23,'Pathalogy','Emergency','2022-10-21','DOC007','OUTP005'),
('OutLab07',43,'Emergency medicine','Emergency','2022-10-30','DOC009','OUTP001'),
('OutLab08',12,'Psychiatry','Primry','2022-10-27','DOC004','OUTP008');



select*from OutPatient_Lab_report;

select*FROm inpatient_lab_report;

show GRANTS for Laboratory_Staff@localhost;

SELECT InPatient.F_name AS Patient_Name,Doctor.F_name AS Doctor_Name
FROM InPatient,Doctor,InPatient_lab_report
WHERE InPatient.p_id=InPatient_lab_report.Inp_id AND InPatient_lab_report.Doc_id=Doctor.Doc_id;

SELECT InPatient.p_id AS Patient_ID,InPatient.F_name AS Patient_Name,Room.Room_No,Room.Room_type
FROM InPatient,Room
WHERE InPatient.p_id=Room.Inp_id;

CREATE DATABASE Hospital2;		 /*Using user Patients*/

SELECT p_id AS Inpatient_ID, F_name AS Inaptient_Name,DOB
FROM inpatient
WHERE (DOB>='1988-1-1')AND(DOB<='1989-12-31');

SELECT p_id AS Inpatient_ID, F_name AS Inaptient_Name,DOB
FROM inpatient
WHERE DOB BETWEEN '1988-1-1' AND '1989-12-31';


SELECT p_id AS Inpatient_ID, F_name AS Inatient_Name,year(curdate())-year(DOB) AS Inpatient_Age		/*Calculate Age*/
FROM InPatient;

UPDATE OutPatient
SET Address='Matara',P_Name='Chathumina'
WHERE p_id='OUTP001';

ALTER TABLE inpatientdiseases
ADD Condition_ VARCHAR(20);
select*from inpatientdiseases;

SELECT*FROM Doctor
WHERE Speciality LIKE 'Suergery';

SELECT S_id,S_name,salary
FROM Staff
ORDER BY Salary DESC LIMIT 5;

DELETE FROM inpatientdiseases
WHERE p_id='INP010';
select*from inpatientdiseases;

INSERT INTO inpatientdiseases
(p_id,diseases)
VALUES
('INP010','Bird flue');
select*from inpatientdiseases;

SELECT speciality,COUNT(Doc_id)
FROM Doctor
Group By speciality;

