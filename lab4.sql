create database if not exists Employee_database;
use Employee_database;
create table dept ( DEPTNO INT , DNAME VARCHAR(40) , DLOC VARCHAR(50) , primary key (DEPTNO) ) ;

INSERT INTO dept VALUES
(10, 'HR', 'Bengaluru'),
(20, 'Finance', 'Hyderabad'),
(30, 'IT', 'Mysuru'),
(40, 'Marketing', 'Boston'),
(50, 'Operations', 'Seattle');

create table Employee( EMPNO VARCHAR(20) , ENAME  VARCHAR(50), MGR_NO INT , HIREDATE DATE , SAL INT , DEPTNO INT , primary key (EMPNO , DEPTNO) , foreign key (DEPTNO) references dept(DEPTNO) ) ;

INSERT INTO Employee VALUES
('E001', 'Alice',1 , '2020-01-15', 75000, 10),
('E002', 'Bob', 2, '2019-03-22', 60000, 20),
('E003', 'Charlie', 3, '2021-07-10', 70000, 30),
('E004', 'Diana', 4 ,'2018-11-05', 65000, 40),
('E005', 'Evan', 5, '2022-04-18', 55000, 50);


create table Project(PNO INT , PLOC VARCHAR(50) , PNAME VARCHAR(50) , PRIMARY KEY(PNO) ) ;

INSERT INTO Project VALUES
(10, 'NY Lab', 'Recruitment AI'),
(20, 'Chicago Hub', 'Budget Tracker'),
(30, 'SF Bay', 'Cloud Migration'),
(40, 'Boston Studio', 'Ad Campaign'),
(50, 'Seattle Ops', 'Logistics Optimizer');

update Project 
set PLOC = "Bengaluru" 
where  PNO = 10 ;

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
('E001', '2023-01-01', 5000),
('E002', '2023-02-15', 3000),
('E003', '2023-03-10', 4000),
('E004', '2023-04-05', 3500),
('E005', '2023-05-20', 2500);

-- queries 

select e.EMPNO from EMPLOYEE e , Project p , ASSIGNED_TO a 
where e.EMPNO = a.EMPNO AND a.PNO = p.PNO AND p.PLOC IN ( 'Bengaluru' , 'Hyderabad' , 'Mysuru' );

select e.EMPNO FROM Employee e , incentives i 
where i.INCENTIVE_AMOUNT = NULL ;
SELECT 
    E.ENAME , E.EMPNO ,D.D_NAME ,E.JOB ,D.D_LOC ,P.P_LOC
FROM 
    Employee1 E
JOIN 
    dept D ON E.D_NO = D.D_NO
JOIN 
    ASSIGNED_TO A ON E.EMPNO = A.EMPNO
JOIN 
    Project2 P ON A.P_NO = P.D_NO
WHERE 
    D.D_LOC = P.P_LOC;
