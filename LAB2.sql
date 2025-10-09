create database if not exists car_insurance;
use car_insurance;

create table person(
  driver_id varchar(10), 
  name char(20),
  address varchar(40), 
  primary key(driver_id)
);

create table car (
  reg_num varchar(15), 
  model char(15),
  year int,
  primary key (reg_num)
);

create table owns (
  driver_id varchar(10),
  reg_num varchar(15),
  primary key (driver_id, reg_num),
  foreign key (driver_id) references person(driver_id),
  foreign key (reg_num) references car(reg_num)
);

create table accident (
  report_num int,
  accident_date date,
  location varchar(20),
  primary key (report_num)
);

create table participated (
  driver_id varchar(10),
  reg_num varchar(15),
  report_num int,
  damage_amount int,
  primary key (driver_id, reg_num, report_num),
  foreign key (driver_id, reg_num) references owns(driver_id, reg_num),
  foreign key (report_num) references accident(report_num)
);

insert into person (driver_id, name, address)
values
  ('A01','Richard','Srinivas Nagar'),
  ('A02','Pradeep','Rajajinagar'),
  ('A03','Smith','Ashoknagar'),
  ('A04','Venu','N.R.Colony'),
  ('A05','John','Hanumanth Nagar');

insert into car(reg_num, model, year) 
values
  ('KA052250','Indica', 1990),
  ('KA031181','Lancer', 1957),
  ('KA095477','Toyota', 1998),
  ('KA053408','Honda', 2008),
  ('KA041702','Audi', 2005);

insert into owns (driver_id, reg_num) 
values
  ('A01', 'KA052250'),
  ('A02', 'KA053408'),
  ('A03', 'KA031181'),
  ('A04', 'KA095477'),
  ('A05', 'KA041702');

insert into accident (report_num, accident_date, location) 
values
  (11, '2003-01-01', 'Mysore Road'),
  (12, '2004-02-02', 'South end Circle'),
  (13, '2003-01-21', 'Bull temple Road'),
  (14, '2008-02-17', 'Mysore Road'),
  (15, '2005-03-04', 'Kanakapura Road');

insert into participated (driver_id, reg_num, report_num, damage_amount)
values
  ('A01', 'KA052250', 11, 10000),
  ('A02', 'KA053408', 12, 50000),
  ('A03', 'KA031181', 13, 25000),
  ('A04', 'KA095477', 14, 3000),
  ('A05', 'KA041702', 15, 5000);
  
update participated set damage_amount=25000 
where reg_num='KA053408' and report_num=12;

select count(distinct driver_id) CNT 
from participated a, accident b 
where a.report_num=b.report_num and b.accident_date like '2008%';

select accident_date , location from accident;

select driver_id from participated where damage_amount >= 25000;

select * from participated order by damage_amount desc;

SET @avg_damage = (SELECT AVG(damage_amount) FROM participated);

DELETE FROM participated WHERE damage_amount < @avg_damage;


select max(damage_amount) as maximum_amount from participated ;
