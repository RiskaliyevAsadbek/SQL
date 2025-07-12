--                                  EASY-LEVEL TASKS
--TASK 1
-- BULK INSERT-bu SQL Server buyrug‘i bo‘lib, tashqi fayldagi (odatda .csv, .txt) katta hajmdagi ma’lumotlarni jadvalga tezda yuklash uchun ishlatiladi.
--Asosiy sintaksis ko'rinishi
--bulk insert [database_name].[table_name]
--from 'file_path'
--with
--( 
--firstrow = 2
--fieldterminator = ','
--rowterminator = '\n'
--)
--bu yerda shu databasedagi manashu tablega manashu fayldagi datalarni kiritish foydalaniladi
--table_name – Ma'lumotlar import qilinadigan jadval nomi.
--file_path – Faylning to‘liq yo‘li (serverdagi).
--FIELDTERMINATOR – Ustunlar orasidagi ajratgich (masalan, , yoki \t).
--ROWTERMINATOR – Qatorlar orasidagi ajratgich (\n, \r\n).
--FIRSTROW – Nechanchi qatordan boshlab import qilishni bildiradi (odatda 2, agar 1-qator sarlavha bo‘lsa).
--for exaomple,
--bulk insert [class.35].[dbo].[directors]
--from 'C:\Data\employees.csv'
--with
--(
--firstrow = 2,
--fieldterminator = ',',
--rowterminator = '\n'
--)
--class.35 databasedagi directors jadvaliga employees fayldan data import qilinadi.

--TASK 2
--SQL ga CSV,Excel,XML,JSON turdagi fayllarni import qilsa bo'ladi.
--CSV (.csv) – Comma-separated values; widely used for importing tabular data.
--Excel (.xls, .xlsx) – Microsoft Excel files; used for structured data with multiple sheets.
--XML (.xml) – Extensible Markup Language; useful for hierarchical data.
--JSON (.json) – JavaScript Object Notation; supported for semi-structured data imports.

--TASK 3
create table Products (ProductID int primary key, ProductName varchar(50), Price decimal(10,2))
--TASK 4
insert into Products values (1, 'laptop', 10.22), (2, 'telephone', 22.5), (3, 'mouse', 2.55)
--TASK 5
--NULL-ushbu ustunda qiymat bo'lmasligi,noma'lum yoki yo'q bo'lishi mumkin.NULL 0 yoki ' ' degani ham emas balki data kiritilmagan ekanligini anglatadi.
--for example, create table students (id int, name varchar(50))
--insert into students values (1, 'ali'), (2, NULL)
-- bu yerda id = 2 bulgan rowda name haqida data yo'q ekanligini bildiradi.
--NOT NULL-ustunda har doim data bo'lishi shartligini bildiradi.bu ustunga NULL value kiritib bo'lmaydi.
--for example, create table employee (id int, name varchar(50) NOT NULL)
-- bu yerda name ga ma'lumot kiritilishi shart ekanligini bildiradi.
--TASK 6
alter table Products
add constraint UQ_ProductName UNIQUE (ProductName)


create table Products (ProductID int primary key, ProductName varchar(50) UNIQUE, Price decimal(10,2))
--TASK 7
--SQL so'rovlariga kommentariya qo'shish, kodni tushunarli qilish uchun juda foydalidir.Komment yozishning ikki xil turi mavjud
--1- (--) bilan yoziladi bu faqat bitta qator uchun foydalaniladi (single-row comment)
--2 - ko'p qatorli kamment /*......*/ ichida yoziladi/
--TASK 8
alter table Products
add CategoryID int

--TASK 9
create table Categories (CategoryID int primary key, CategoryName varchar(50) unique)
--TASK 10
/* IDENTITY- ustuni SQLda har bir yangi satr uchun avtomatik son berish uchun ishlatilinadi,va odatda primary key sifatida ishlatilinadi.
masalan, create table people (id int identity(1,1), name varchar(50))
IDENTITY(1,1)- 1- bo'shlangich qiymati (starting value), 1-har  bir yangi satrda qanchadan ortib borishi(increment value) */
--                                  MEDIUM-LEVEL TASKS
--TASK 11
bulk insert [SchoolDB].[dbo].[Products]
from 'C:\Users\user\Desktop\Book1.xlsx'
with
(
firstrow = 2,
fieldterminator = ',',
rowterminator = '\n'
)
--TASK 12
ALTER table Products
add constraint fk_products_categories foreign key (categoryid)
references categories(categoryid)

--TASK 13
/* PRIMARY KEY -jadvalda bir marotaba ishlatilinadi, har bir record unique bo'lishini ta'minlaydi. NULL value ni qabul qilmaydi.
UNIQUE KEY- jadvalda bir necha marotaba qo'llash mumkin va u ham record unique bo'lishini ta'minlaydi. NULL valueni qabul qiladi.*/
--TASK 14
alter table Products
add constraint CHK_PRICE 
check (price > 0)
--TASK 15
alter table Products
add Stock int not null default 0
--TASK 16
 select isnull(Price,0) as Price from Products 
 --TASK 17
 --FOREIGN KEY-bu bir jadvaldagi ustunni boshqa jadvaldagi ustun bilan bog'laydigan cheklov.
 /* MASALAN, 
 create table categories (category id int primary key,
 categoryName varchar(50))

create table products (productsid int primary key,
productname varchar(59), 
categoryid int foreign key (categoryid) references categories(categoryid)
)
bu yerda products.categoryid, categories.categoryid bilan bog'langan.*/
--              HARD-LEVEL TASKS
--TASK 18
create table customers (age int check (age>=18))
--TASK 19
create table table_name (column_1 int identity(100,10))
--TASK 20
create table OrderDetails (orderID int, productsid int, quantity int, unitprice decimal(10,2), primary key (orderid, productsid))
--TASK 21
/* ISNULL- agar ustun yoki qiymat NULL bo'lsa , o'rniga belgilangan zaxira qiymatni qaytaradi.
isnull(expression(column name), replacement_value) va isnull bitta ustun bilan ishlatilinadi.
for example, 
select isnull(phonenumber, 'unknown') as phine fromn emplyees --agar phonenumber null bo'lsa o'rniga 'unknown' chiqaradi.
COALESCE- xuddi isnull kapi ishlaydi va u bir nechta ustun bilan qo'llash mumkin.
coalesce(exp1,exp2,.....,relacement)
for example,
coalesce(phonenumber, homenumber, 'unknown')---agar phonenumber null bo'lsa homephonega qaraydi agar u ham null bo'lsa 'unknown' deb chiqaradi.*/
--TASK 22
create table Employees (EmpID int primary key, email varchar(50) unique)
--TASK 23
create table orders (
orderid int primary key,
customerid int,
customername varchar(50),
constraint fk_orders_customers
foreign key (customerid)
references Customers(customerid)
on delete cascade
on update cascade
)
