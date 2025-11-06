create database if not exists Employee_database;
use Employee_database;
create table dept ( DEPTNO INT , DNAME VARCHAR(40) , DLOC VARCHAR(50) , primary key (DEPTNO) ) ;

INSERT INTO dept VALUES
(10, 'HR', 'Bengaluru'),
(20, 'Finance', 'Hyderabad'),
(30, 'IT', 'Mysuru'),
(40, 'Marketing', 'Boston'),
(50, 'Operations', 'Seattle');

create table Employee( EMPNO VARCHAR(20) , ENAME  VARCHAR(50), MGR_NO VARCHAR(50) , HIREDATE DATE , SAL INT , DEPTNO INT , primary key (EMPNO , DEPTNO) , foreign key (DEPTNO) references dept(DEPTNO) ) ;

INSERT INTO Employee VALUES
('E001', 'Alice','E002' , '2020-01-15', 75000, 10),
('E002', 'Bob', 'E005', '2019-03-22', 60000, 20),
('E003', 'Charlie', 'E002', '2021-07-10', 70000, 30),
('E004', 'Diana', 'E005' ,'2018-11-05', 65000, 40),
('E005', 'Evan', 'E004', '2022-04-18', 55000, 50);

create table Project(PNO INT , PLOC VARCHAR(50) , PNAME VARCHAR(50) , PRIMARY KEY(PNO) ) ;

INSERT INTO Project VALUES
(10, 'NY Lab', 'Recruitment AI'),
(20, 'Chicago Hub', 'Budget Tracker'),
(30, 'SF Bay', 'Cloud Migration'),
(40, 'Boston Studio', 'Ad Campaign'),
(50, 'Seattle Ops', 'Logistics Optimizer');

-- update Project 
-- set PLOC = "Bengaluru" 
-- where  PNO = 10 ;

create table ASSIGNED_TO ( EMPNO VARCHAR(20) , PNO INT , JOB_ROLE VARCHAR(50), PRIMARY KEY (EMPNO , PNO ) ,foreign key(EMPNO) references Employee(EMPNO) , 
foreign key(PNO) references Project(PNO) ) ;

INSERT INTO ASSIGNED_TO VALUES
('E001', '10', 'Team Lead'),
('E002', '20', 'Financial Analyst'),
('E003', '30', 'Backend Developer'),
('E004', '40', 'Marketing Strategist'),
('E005', '50', 'Operations Planner');


create table incentives (EMPNO VARCHAR(50) , INCENTIVE_DATE DATE , INCENTIVE_AMOUNT INT , PRIMARY KEY (EMPNO , INCENTIVE_DATE) , foreign key(EMPNO) references Employee(EMPNO) );

INSERT INTO incentives VALUES
('E001', '2019-01-01', 5000),
('E002', '2023-02-15', 3000),
('E003', '2019-01-10', 4000),
('E004', '2023-04-05', 3500),
('E005', '2023-05-20', 2500);

-- WEEK 6 QUERIES 
-- 3 

select e.ENAME as Manager_name 
from Employee e
join Employee m
on e.EMPNO = m.MGR_NO 
group by e.ENAME 
HAVING count(e.ENAME) = (select count(p.ENAME) 
from Employee p
join Employee q
on p.EMPNO = q.MGR_NO 
group by p.ENAME 
order by count(e.ENAME) DESC
limit 1  );

-- 4
select e.ENAME as Manager_name 
from Employee e 
join Employee m 
on e.EMPNO = m.MGR_NO
group by e.ENAME ,e.SAL
having e.SAL > avg(e.SAL);

-- 5 
SELECT DISTINCT e.ENAME AS Second_Level_Manager, e.DEPTNO
FROM Employee e
JOIN Employee m ON e.MGR_NO = m.EMPNO
WHERE m.EMPNO IN (
    SELECT DISTINCT mgr.EMPNO
    FROM Employee mgr
    WHERE mgr.EMPNO NOT IN (
        SELECT DISTINCT e2.MGR_NO FROM Employee e2 WHERE e2.MGR_NO IS NOT NULL
    )
)
AND e.EMPNO IN (
    SELECT DISTINCT e3.MGR_NO FROM Employee e3 WHERE e3.MGR_NO IS NOT NULL
)
ORDER BY e.DEPTNO;
-- 6 
select e.ENAME from Employee e
join incentives i
on e.EMPNO = i.EMPNO
where i.INCENTIVE_DATE BETWEEN '2019-01-01' AND '2019-01-31'  
ORDER BY  i.INCENTIVE_AMOUNT
LIMIT 1 OFFSET 1;
-- 7
SELECT e.EMPNO, e.ENAME, e.DEPTNO AS Employee_Dept, m.ENAME AS Manager_Name, m.DEPTNO AS Manager_Dept
FROM Employee e                                                  
JOIN Employee m ON e.MGR_NO = m.EMPNO
WHERE e.DEPTNO = m.DEPTNO;
