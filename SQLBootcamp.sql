Create Database SQLBootcamp;

USE SQLBootcamp;

Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

Select Salary From EmployeeSalary Limit 6;

Select Distinct(Gender) From EmployeeDemographics;

Select count(LastName) AS LastNameCount From EmployeeDemographics;

Select MAX(Salary) From EmployeeSalary ;
Select MIN(Salary) From EmployeeSalary ;
Select AVG(Salary) From EmployeeSalary ;

Select * From EmployeeDemographics Where FirstName = "Jim";
Select * From EmployeeDemographics Where FirstName <> "Jim";
Select * From EmployeeDemographics Where Age <= 30 And Gender = "Male";
Select * From EmployeeDemographics Where Age <= 30 Or Gender = "Male";

Select * From EmployeeDemographics Where LastName like "S%";
Select * From EmployeeDemographics Where LastName like "%S%";

Select * From EmployeeDemographics Where LastName is not null;
Select * From EmployeeDemographics Where LastName is null;

Select * From EmployeeDemographics Where FirstName in ("Jim","Michael");

Select Gender, Count(Gender)  As CountGender From EmployeeDemographics 
Where Age >31
Group by Gender
Order By Gender Asc;

Select * From EmployeeDemographics Order by Age asc, Gender desc;

/*Inner Join*/

Select * From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;
 
/* To check who earns most after the manager*/

Select EmployeeDemographics.EmployeeID, FirstName, LastName,Salary
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where FirstName <> "Micheal"
Order By Salary Desc;

/* Avg salary for salesman*/

Select JobTitle, avg(Salary)
From EmployeeDemographics
Inner Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Where JobTitle = 'Salesman'
Group by JobTitle;

/*Union*/

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

Table 3 Query:
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Table 3 Insert:
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

Select * From EmployeeDemographics
Union
Select * From WareHouseEmployeeDemographics;

Select * From EmployeeDemographics
Union All
Select * From WareHouseEmployeeDemographics
Order by EmployeeID;

/*Case Statement*/

Select FirstName, LastName, Age,
CASE
	When Age > 30 Then 'Old'
    When Age Between 27 And 30 Then 'Young'
	Else 'Baby'
END
From EmployeeDemographics
Where Age is not null
Order by Age;

Select FirstName, LastName, JobTitle, Salary,
CASE
	When JobTitle = 'Accountant' Then Salary + (Salary * .10)
    When JobTitle = 'Salesman' Then Salary + (Salary * .05)
    When JobTitle = 'HR' Then Salary + (Salary * .00001)
	Else Salary + (Salary * .03)
END As SalaryAfterRaise
From EmployeeDemographics
Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

/*Having Statement*/

Select JobTitle, Count(JobTitle)
From EmployeeDemographics
Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group by JobTitle
Having Count(JobTitle) > 1;

Select JobTitle, Avg(Salary)
From EmployeeDemographics
Join EmployeeSalary
On EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group by JobTitle
Having Avg(Salary) > 4500
Order by Avg(Salary);

/*Updating & Deleting Data*/

Select * From EmployeeDemographics;

Update EmployeeDemographics
Set EmployeeID = 1012
Where FirstName = 'Holly' AND LastName = 'Flax';

Update EmployeeDemographics
Set Age = '32' , Gender = 'Female'
Where FirstName = 'Holly' AND LastName = 'Flax';

Select * From EmployeeDemographics;

Delete From EmployeeDemographics
Where EmployeeID = 1005; 

/*Aliasing*/

Select FirstName + " " + LastName AS FullName
From EmployeeDemographics;

Select Avg(Age) As AvgAge
From EmployeeDemographics;

Select Demo.EmployeeID
From EmployeeDemographics AS demo
join EmployeeSalary AS sal
on demo.EmployeeID = sal.EmployeeID;

Select Demo.EmployeeID,sal.JobTitle, Ware.Age
From EmployeeDemographics AS demo
Left join EmployeeSalary AS sal
on demo.EmployeeID = sal.EmployeeID
Left join WareHouseEmployeeDemographics AS ware
on demo.EmployeeID = ware.EmployeeID;

/*Partition*/

Select FirstName,LastName,Gender, Salary, 
Count(Gender) Over (Partition By Gender) as TotalGender,
Avg(Salary) Over (Partition By Gender) As AvgSalary
From EmployeeDemographics dem
join EmployeeSalary sal
on dem.EmployeeID = sal.EmployeeID
Where Salary>'45000';

/*CTE*/

With CTE_Employee As (
Select FirstName,LastName,Gender, Salary, 
Count(Gender) Over (Partition By Gender) as TotalGender,
Avg(Salary) Over (Partition By Gender) As AvgSalary
From EmployeeDemographics dem
join EmployeeSalary sal
on dem.EmployeeID = sal.EmployeeID
Where Salary>'45000'
)
Select * From CTE_Employee;

/*Temp Table*/
Create Temporary Table temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select * From temp_Employee;

/*Advanced Temp Table*/

Drop Temporary table if exists temp_Employee2;

Create Temporary Table temp_Employee2(
Jobtitle varchar(50),
EmployeePerJob int,
AvgAge int,
AvgSalary int);

Insert into temp_Employee Values(
'1001', 'HR', '45000');

Insert into temp_Employee 
Select * From EmployeeSalary;

Insert into temp_Employee2 
Select JobTitle, count(JobTitle), Avg(Age), avg(Salary)
From EmployeeDemographics emp
Join EmployeeSalary sal
On emp.EmployeeID = sal.EmployeeID
Group by JobTitle;

Select * From temp_Employee2;

/*

String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/

Drop Table EmployeeErrors;


CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
);

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired');

Select *
From EmployeeErrors;

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors ;

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors ;

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors ;

	



-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors;


-- Using Substring

Select Substring(err.FirstName,3,3)
FROM EmployeeErrors err;

-- Using Substring Fuzzy Matching

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3);
    
Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3);



-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors;

Select Firstname, UPPER(FirstName)
from EmployeeErrors;

/*
Subqueries (in the Select, From, and Where Statement)
*/

Select EmployeeID, JobTitle, Salary
From EmployeeSalary;

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary;

-- with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary;

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID;


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID;


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)


/*
Stored Procedures
*/
USE SQLBootcamp;

DELIMITER $$

CREATE PROCEDURE Temp_Employee1()
BEGIN
DROP TABLE if exists temp_employee1;
Create table temp_employee1 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
);
END $$
#DELIMITER;
Call Temp_Employee1;

Insert into temp_employee1
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLBootcamp.EmployeeDemographics emp
JOIN SQLBootcamp.EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle;

Select * 
From #temp_employee
GO;




CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM SQLTutorial..EmployeeDemographics emp
JOIN SQLTutorial..EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle --- make sure to change this in this script from original above
group by JobTitle

Select * 
From #temp_employee3
GO;


exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'
