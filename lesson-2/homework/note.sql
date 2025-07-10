                                       -- Basic-level  tasks(10)
--TASK 1 create a table with columns 
create table Employees (EmpID int, Name varchar(50), Salary decimal(10,2))
--TASK 2 insert three records 
insert into Employees values (1, 'Edward', 190.87) 
--single-row insert into
insert into Employees values (2, 'Johnny', 180.65),
(3, 'Tom', 122.45), 
(4, 'Kendal', 122.54), 
(5, 'Bella', 135.76)
--multiple-row inser into
insert into Employees(EmpID, Name, Salary) values (6, 'Joseph', 177.98)
-- single-row inser into with name of columns

--TASK 3 update 
update Employees
set Salary = 7000
where EmpID = 1

--TASK 4 delete
delete from Employees
where EmpID = 2

--TASK 5 definition
--DROP -Jadval yoki butub bazani o'chirib yuboradi, ya'ni jadvalning o'zi va ma'lumotlari ham yo'qoladi.Drop 'where' clause bilan ishlamaydi va ma'lumotlarni qaytin tiklab bo'lmaydi.
--for example, drop table Students- Students jadvalini butunlay ma'lumotlari bilan o'chirib yuboradi.
--DELETE- Jadvaldagi muayyan yoki tanlangan satrlarni o'chiradi.Where bilan ishlatilsa faqat tanlangan ma'lumomotlar o'chirib yuboriladi.Agar tranzaksiya ichida qo'llanilsa ma'lumotni qaytib tiklab bo'ladi.
--ishlashi nisbatan sekin chunki u satrma-satr o'chiradi.
--for example, 
--delete from students  
--where id = 2
--bu yerda id = 2 teng bo'lgan satrdagi ma'lumotlarni o'chirib yuboradi.
--TRUNCATE-Jadvaldagi barcha satrlarni tez o'chiradi lekin tuzilasi ya'ni strukturasu saqlanib qoladi.
--for example, truncate table students - desak students table barcha satrdagi ma'lumotlarni o'chirib yuboradi, lekin jadval strukturasi saqlanib qoladi.

--TASK 6 modify
alter table Employees
alter column name varchar(100)

--TASK 7 add
alter table Employees
add Department varchar(50)

--TASK 8 change
alter table Employees
alter column Salary float

--TASK 9 create
create table Departments (DepartmentID int PRIMARY KEY, DepartmentName varchar(50))

--TASK 10 remove 
truncate table Employees

                                            --Intermediate-level tasks(6)
--TASK 11 INSERT INTO SELECT METHOD
insert into Departments (DepartmentID, DepartmentName) select * from (values (1, 'IT'), (2, 'Finance'), (3, 'Marketing'), (4, 'HumanResources'), (5, 'Sales')) as Temptable(DepartmentID,DepartmentName) 

--TASK 12 UPDATE
Update Employees
set Department = 'Menegement'
where Salary > 5000
 --TASK 13
 truncate table Employees
 --TASK 14
 alter table Employees
 drop column Department

 --TASK 15 rename
  exec sp_rename 'Employees', 'StaffMember'
 --TASK 16 remove
 drop table Departments

                                      -- ADVANCED-LEVEL TASKS(9) 
--TASK 17 create 
create table Products (ProductID int Primary key, ProductName varchar(50), Category varchar(50), Price decimal(5,2), QuantityInStock int, SupplierID int)

--TASK 18 ADD
alter table Products
add constraint price_positive check (Price > 0)

--Task 19 modify
alter table Products
add StockQuantity int default 50

--TASK 20 rename 
exec sp_rename 'Products.Category', 'ProductCategory', 'column'
--TASK 21 INSERT INTO
insert into Products values (1, 'Applewatch', 'Accesory', 22.45, 12, 01, 12), (2, 'Television', 'Electronics', 245.55, 11, 02, 11), (3, 'Copybook', 'SchoolSupplies', 2.3, 11, 03, 11),
(4, 'Water', 'Grocery', 1.5, 19, 04, 19), (5, 'Laptop', 'Electrnics', 234.5, 12, 05, 12)

--TASK 22 CREATE BACKUP
select * into Products_Backup from Products
--TASK 23 RENAME 
exec sp_rename 'Products', 'Inventory'
--TASK 24 ALTER
alter table Inventory
alter column Price float
--TASK 25
alter table Inventory
add ProductCode int identity(1000, 5)
