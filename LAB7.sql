create database supplier;
use supplier;
create table  SUPPLIERS(SID int , SNAME varchar(50) ,CITY varchar(50) , primary key (SID) );
insert into SUPPLIERS values
(10001,"Acme Widget" ,"Bangalore"),
(10002,"Johns","kolkata"),
(10003,"Vimal","Mumbai"),
(10004,"Reliance","Delhi");
create table PARTS(PID int , PNAME varchar(50) , color varchar(50) ,primary key (PID));
insert into PARTS values 
(20001,"Book","Red"),
(20002,"Pen","Red"),
(20003,"Pencil","Green"),
(20004,"Mobile","Green"),
(20005,"Charger","Black");
create table CATALOG ( SID int ,PID int,COST int, primary key(SID,PID) , foreign key(SID) references SUPPLIERS(SID) ,
foreign key (PID) references PARTS(PID) );
insert into CATALOG values
(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

-- queries 

-- 3.Find the pnames of parts for which there is some supplier.

select distinct PNAME from PARTS p
join CATALOG c on p.PID = c.PID ;

-- 4. Find the snames of suppliers who supply every part.

select SNAME from SUPPLIERS s 
join CATALOG c on c.SID = s.SID 
join PARTS p on p.pid = c.pid
group by s.SID 
having count( Distinct p.PID ) = (Select count(*) from parts);

-- 5. Find the snames of suppliers who supply every red part.
select s.SNAME from SUPPLIERS s 
join CATALOG c on c.SID = s.SID 
join PARTS p on p.pid = c.pid
group by s.SID , p.COLOR
having p.COLOR like "Red";

-- 6.Find the pnames of parts supplied by Acme Widget Suppliers and by no one else.
select  p.PNAME from PARTS p
join CATALOG c on c.PID = p.PID
join SUPPLIERS s on s.SID = c.SID
where p.PNAME 
NOT IN(
select  p1.PNAME from PARTS p1
join CATALOG c1 on c1.PID = p1.PID
join SUPPLIERS s1 on s1.SID = c1.SID
where s1.SNAME NOT LIKE "Acme Widget");


-- 7.Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part).
select c1.sid from catalog c1 where c1.cost>
(select avg(c2.cost) from catalog c2 where c2.pid=c1.pid);

-- 8.For each part, find the sname of the supplier who charges the most for that part.
select p.pname,p.pid, s.sname from parts p
join catalog c on p.pid = c.pid
join supplier s on c.sid = s.sid
where (p.pid, c.cost) in (select pid, max(cost) from catalog group by pid);










