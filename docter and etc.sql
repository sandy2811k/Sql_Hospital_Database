create database hospital

Create table province_name
(
province_id char(2) primary key,
province_name varchar(30)
)
insert into province_name  values ('AH','Ahemednagar'),('AU','Aurangabad'),('NA','Nagpur'),('TH','Thane')
--------------------------------------------------------------------------------------------------------------
create table Patient
(
patient_id int primary key,
first_name varchar(30),
last_name varchar(30),
gender char(1),
birth_date date,
city varchar(30),
province_id char(2),
Constraint fk_provinceName_province_id foreign key (province_id) references province_name(province_id),
allergies varchar(80),
height decimal(3,0),
weight decimal(4,0)
)
insert into Patient values(1,'Shubham','Dalvi','M','2001/07/11','Pune','AH','Astama',167,55)
insert into Patient values(2,'Rushi','Kharade','M','1998/11/29','Nagar','AU','Skin',153,60)
insert into Patient values(3,'Shubham','Tidke','M','2000/08/12','Pune','NA','Food',159,70)
insert into Patient values(4,'Sujit','Sabale','M','2001/05/13','Mumbai','TH','Dust',157,65)
insert into Patient values(5,'Ajay','Nikam','M','2002/09/14','Delhi','TH','Perfume',165,54)
insert into Patient values(6,'Alisha','Mhasake','F','1999/02/15','Nagar','AU','Fish',170,50)
insert into Patient values(7,'Riya','Malpani','F','1998/12/16','Satara','AH','Chemical',155,75)
insert into Patient values(8,'Tanuja','Gaygude','F','2003/01/01','Nagar','AU',null,150,40)

--------------------------------------------------------------------------------------------------------------
create table docters
(
doctor_id int primary key,
first_name varchar(30),
last_name varchar(30),
specialty varchar(25)
)	
insert into docters values (111,'Santosh','Fulari','MBBS')
insert into docters values (112,'Iphtikraj','Khatib','BHMS')
insert into docters values (113,'Rushi','Newase','BAMS')
insert into docters values (114,'Anil','Bhatia','BDS')
insert into docters values (115,'Shivaji','Bhuse','Skin')
----------------------------------------------------------------------------------------------------------------
create table admissions
(
patient_id int,
admission_date date,
discharge_date date,
diagnosis varchar(50),
attending_doctoe_id int,
Constraint fk_doctor_attending_doctoe_id foreign key (attending_doctoe_id) references docters(doctor_id),
)
alter table admission  RENAME column attending_doctoe_id To attending_doctor_id

insert into admissions values(1,'2022/09/20','2023/09/20','Lung Test',111)
insert into admissions values(2,'2023/08/20','2023/09/30','Using UV ',112)
insert into admissions values(3,'2022/09/20','2023/02/25','Bllod Test',113)
insert into admissions values(4,'2023/01/20','2023/07/20','Allergy test',114)
insert into admissions values(5,'2023/04/20','2023/05/20','Endoscopy',111)
insert into admissions values(6,'2020/09/20','2022/09/20','Medical Test',112)
insert into admissions values(7,'2022/09/20','2023/01/11','Audiogram',113)


-----------------------------------------------------------------------------------------------------------
select * from province_name
select * from Patient
select * from docters
select * from admissions
-----------------------------------------------------------------------------------------------------------

--1.Show the first name, last name and gender of patients who’s gender is ‘M’
select p.first_name,p.last_name,p.gender from Patient p 
where gender = 'M'

--2.Show the first name & last name of patients who does not have any allergies
select p.first_name,p.last_name from Patient p 
where allergies  is null

--3.Show the patients details that start with letter ‘S’
select * from Patient where first_name like 's%'

--4.Show the patients details that height range 100 to 200
select * from Patient where height between 160 and 170

--5.Update the patient table for the allergies column. Replace ‘NKA’ where allergies is null
update Patient set allergies='NKA' where allergies is null

--6.Show how many patients have birth year is 2020
select count(*) as 'Count'
from Patient p 
where birth_date ='2000'

--7.	Show the patients details who have greatest height
select top 1* from Patient p 
order by height desc

--8.	Show the total amount of male patients and the total amount of female patients in the patients table.
select p.gender,count(* ) as 'count' 
from Patient p
group by gender

--9.Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'.
--Show results ordered ascending by allergies then by first_name then by last_name.
select p.first_name,p.last_name,p.allergies
from Patient p
where allergies in ('Astama','Perfume')
order by allergies ,first_name,last_name

--10.	Show first_name, last_name, and the total number of admissions attended for each doctor. 
--Every admission has been attended by a doctor.
select concat(d.first_name,' ',d.last_name) as 'Full Name' , count(d.doctor_id) as 'Attened admission'
from docters d
inner join admissions a on d.doctor_id = a.attending_doctoe_id
inner join patient p on p.patient_id = a.patient_id
group by concat(d.first_name,' ', d.last_name)  

--11.For every admission, display the patient's full name, their admission diagnosis, and
--their doctor's full name who diagnosed their problem.
select CONCAT(p.first_name, ' ',p.last_name) as 'patient full name', a.diagnosis, CONCAT(d.first_name, ' ', d.last_name) as 'doctor'
from patient p
inner join admissions a on a.patient_id = p.patient_id
inner join docters d on d.doctor_id = a.attending_doctoe_id