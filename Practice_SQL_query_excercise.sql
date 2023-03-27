use psingh;

-- Query:

--From the doctors table, fetch the details of doctors who work in the same hospital but in different speciality.

--Table Structure:
create table doctors
(
id int primary key,
name varchar (50),
speciality varchar (100),
hospital varchar (50),
city varchar (50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

select * from doctors;

select d1.*
from doctors d1
inner join doctors d2 
on d1.id <> d2.id and d1.hospital = d2.hospital and d1.speciality <> d2.speciality;

