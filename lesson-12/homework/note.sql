--1. Combine Two Tables
--Write a solution to report the first name, last name, city, and state of each person in the Person table. 
--If the address of a personId is not present in the Address table, report null instead
Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select Person.firstName, Person.lastName, Address.city, Address.state from Person
left join Address
on Person.personId = Address.personId
--2. Employees Earning More Than Their Managers
--Write a solution to find the employees who earn more than their managers.
Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)

select emp1.name from Employee as emp1
left join Employee as emp2
on  emp1.managerId = emp2.id
where emp1.salary > emp2.salary

--3. Duplicate Emails
--Write a solution to report all the duplicate emails. Note that it''s guaranteed that the email field is not NULL.
create table person (id int, email varchar(255)) 
insert into Person (id, email) values (1, 'a@b.com')
insert into Person (id, email) values (2, 'c@d.com')
insert into Person (id, email) values (3, 'a@b.com')

select email from Person
group by email
having count(email) > 1

--4. Delete Duplicate Emails
--Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
drop table Person

create table person (id int primary key, email varchar(255))
insert into person values (1, 'john@example.com'), (2, 'bob@example.com'), (3, 'john@example.com')

delete p1 from person as p1
join person as p2 
on p1.email=p2.email
and p1.id > p2.id

--5. Find those parents who has only girls.
CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

select distinct girls.ParentName from girls 
left join boys
on girls.ParentName = boys.ParentName
where boys.ParentName is null

--6. Total over 50 and least
--Find total Sales amount for the orders which weights more than 50 for each customer along with their least weight.(from TSQL2012 database, Sales.Orders Table)
select custid,  sum(freight) as total_sales_amout, min(freight) as least_weight from [TSQL_2012].Sales.Orders
where freight > 50
group by custid

--7. Carts
DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

select isnull(Cart1.Item, ' ') as item_cart1, isnull(Cart2.Item, ' ') as item_cart2 from Cart1
full join Cart2 
on Cart1.Item = Cart2.Item

--8. Customers Who Never Order
--Write a solution to find all customers who never order anything.
Create table Customers (id int, name varchar(255))
Create table Orders (id int, customerId int)
Truncate table Customers
insert into Customers (id, name) values ('1', 'Joe')
insert into Customers (id, name) values ('2', 'Henry')
insert into Customers (id, name) values ('3', 'Sam')
insert into Customers (id, name) values ('4', 'Max')
Truncate table Orders
insert into Orders (id, customerId) values ('1', '3')
insert into Orders (id, customerId) values ('2', '1')

select Customers.name from Customers
left join Orders
on Customers.id = Orders.customerId
where Orders.id is null

--9. Students and Examinations
--Write a solution to find the number of times each student attended each exam.
Create table Students (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Students
insert into Students (student_id, student_name) values ('1', 'Alice')
insert into Students (student_id, student_name) values ('2', 'Bob')
insert into Students (student_id, student_name) values ('13', 'John')
insert into Students (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')


select Students.student_id, Students.student_name, Subjects.subject_name, count( Examinations.student_id) from Students
cross join Subjects
left join Examinations
on Students.student_id = Examinations.student_id and Examinations.subject_name = Subjects.subject_name
group by Students.student_id, Students.student_name, Subjects.subject_name
