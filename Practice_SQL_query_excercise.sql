use psingh;

-- Query 1:

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

-- Query 2:

--From the login_details table, fetch the users who logged in consecutively 3 or more times.

--Table Structure:

create table Login_details(
login_id int primary key,
user_name varchar (50) not null,
login_date date
);

select * from Login_details;

insert into login_details values
(101, 'Michael', current_date),
(102, 'James', current_date),
(103, 'Stewart', current_date+1),
(104, 'Stewart', current_date+1),
(105, 'Stewart', current_date+1),
(106, 'Michael', current_date+2),
(107, 'Michael', current_date+2),
(108, 'Stewart', current_date+3),
(109, 'Stewart', current_date+3),
(110, 'James', current_date+4),
(111, 'James', current_date+4),
(112, 'James', current_date+4),
(113, 'James', current_date+4);

select distinct user_name from
(select *,
case when user_name = lead(user_name,1) over(order by login_id)
	and user_name = lead(user_name,2) over(order by login_id)
    then user_name
    else null
end as repeated_names
from login_details) as x
where x.repeated_names is not null;

-- Query 3:

--From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.

--Note: Weather is considered to be extremely cold then its temperature is less than zero.

--Table Structure:

create table weather(
id int,
city varchar (50),
temprature int,
day date
);

insert into weather values
(1, 'London', -1,'2021-01-01'),
(2, 'London', -2,'2021-01-02'),
(3, 'London', 4,'2021-01-03'),
(4, 'London', 1,'2021-01-04'),
(5, 'London', -2,'2021-01-05'),
(6, 'London', -5,'2021-01-06'),
(7, 'London', -7,'2021-01-07'),
(8, 'London', 5,'2021-01-08');

select id, city, temprature, day 
from(
	select *, 
	case when temprature < 0
		and lead (temprature) over(order by id) < 0
		and lead (temprature,2) over(order by id) < 0 
		then "yes"
		when temprature < 0
		and lag (temprature) over(order by id) < 0
		and lead (temprature) over(order by id) < 0 
		then "yes"
		when temprature < 0
		and lag (temprature) over(order by id) < 0
		and lag (temprature,2) over(order by id) < 0 
		then "yes"
	else null end as flag
	from weather) x
where x.flag = "yes";
