CREATE DATABASE IF NOT EXISTS Bank;
USE Bank;

CREATE TABLE Branch (
  branchname VARCHAR(50) PRIMARY KEY,
  branchcity VARCHAR(50),
  assets FLOAT
);

CREATE TABLE BankAccount (
  accno INT,
  branchname VARCHAR(50),
  balance FLOAT,
  PRIMARY KEY (accno, branchname),
  FOREIGN KEY (branchname) REFERENCES Branch(branchname)
);

CREATE TABLE Depositor (
  customerName VARCHAR(50),
  accno INT,
  PRIMARY KEY (customerName, accno),
  FOREIGN KEY (accno) REFERENCES BankAccount(accno)
);

CREATE TABLE BankCustomer (
  customerName VARCHAR(50) PRIMARY KEY,
  customerStreet VARCHAR(50),
  customerCity VARCHAR(50),
  FOREIGN KEY (customerName) REFERENCES Depositor(customerName)
);

CREATE TABLE Loan (
  loanNumber INT,
  branchName VARCHAR(50),
  amount FLOAT,
  PRIMARY KEY (loanNumber, branchName),
  FOREIGN KEY (branchName) REFERENCES Branch(branchname)
);

INSERT INTO Branch (branchname, branchcity, assets) VALUES
('SBI_Charminarpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 10000),
('SBI_JantarMantar', 'Delhi', 20000);

INSERT INTO BankAccount (accno, branchname, balance) VALUES
(1, 'SBI_Charminarpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParliamentRoad', 9000),
(5, 'SBI_JantarMantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParliamentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_JantarMantar', 2000);

INSERT INTO Depositor (customerName, accno) VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11),
('Mohan', 3);  

INSERT INTO BankCustomer (customerName, customerStreet, customerCity) VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');

INSERT INTO Loan (loanNumber, branchName, amount) VALUES
(1, 'SBI_Charminarpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParliamentRoad', 4000),
(5, 'SBI_JantarMantar', 5000);

 -- queries
 

 select branchname , assets / 100000 as assets_in_lakhs
 from branch ;

select d.customername ,b.branchname , count*(b.accno)
from depositer , bankaccount b 
where d.accno = b.accno 
group by branchname , customername having count(b.accno) >= 2 ;

create view bank_loan as 
select branchname , sum(amount) from loan
group by branchname ;
select * from bank_loan;




