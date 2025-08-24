/*1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region,
rovide a zero-dollar value for that day. Assume there is at least one sale for each region */
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);

select * from #RegionSales




;with region as (
select distinct Region from #RegionSales
)
, distributer as (
select distinct Distributor from #RegionSales
)
select region.Region, distributer.Distributor, isnull(SUM(#RegionSales.Sales), 0) as sales from region
cross join distributer
left join #RegionSales
on region.Region = #RegionSales.Region and distributer.Distributor = #RegionSales.Distributor
group by region.Region, distributer.Distributor





--2. Find managers with at least five direct reports
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);

INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);

with cte as(
select e1.name, e1.department, e2.name as manager_name, e2.id as manager_id from Employee as e1
inner join Employee as e2
on 
e1.managerId = e2.id
)
select manager_name from cte
group by manager_name
having COUNT(manager_id) >= 5

/*3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount. */
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

;with cte as (
select product_id, SUM(unit) as total from Orders
where MONTH(order_date) = 2 and YEAR(order_date) = 2020
group by product_id
having SUM(unit) >= 100
)
select Products.product_name, cte.total as unit from cte
join Products
on cte.product_id = Products.product_id

/*4. Write an SQL statement that returns the vendor from which each customer has placed the most orders */
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

with cte as (
select CustomerID, sum(Count) as total, Vendor from Orders
group by CustomerID, Vendor
)
select CustomerID, Vendor from cte as c1
where total = (select MAX(total) from cte as c2 where c1.CustomerID = c2.CustomerID)

/* 5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 
'This number is prime' else return 'This number is not prime' */
DECLARE @Check_Prime INT = 91;
declare @i int =  1
while @Check_Prime <= @i
begin
   if @Check_Prime % @i = 1
   begin
   print 'your number is prime'
   end
else 
begin
 print 'your number is not prime'
end

end


/*6. Write an SQL query to return the number of locations,in which location most signals sent, and 
total number of signal for each device from the given table. */
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');


; with locationcount as (
select Device_id, Locations, COUNT(*) as cnt_signal from Device
group by  Device_id, Locations
), max_location as (
select Device_id, max(cnt_signal) as max_signal from locationcount
group by Device_id
)


select Device.Device_id, COUNT(distinct Device.Locations) as no_of_location, locationcount.Locations as max_signal_location, COUNT(*) as no_of_signal from Device
join locationcount
on Device.Device_id = locationcount.Device_id
join max_location
on Device.Device_id = max_location.Device_id and locationcount.cnt_signal= max_location.max_signal
group by Device.Device_id, locationcount.Locations

/* 7. Write a SQL to find all Employees who earn more than the average salary in their corresponding department.
Return EmpID, EmpName,Salary in your output */
drop table Employee
CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);

with cte as (
select DeptID, AVG(Salary) as average_salary from Employee
group by DeptID)
select Employee.EmpID, Employee.EmpName, Employee.Salary from cte
join Employee
on cte.DeptID = Employee.DeptID
where cte.average_salary < Employee.Salary

/*8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers.
If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. 
Calculate the total winnings for today’s drawing. */

CREATE TABLE Numbers (
    Number INT
);
INSERT INTO Numbers (Number)
VALUES
(25),
(45),
(78);

CREATE TABLE Tickets (
    TicketID VARCHAR(10),
    Number INT
);
INSERT INTO Tickets (TicketID, Number)
VALUES
('A23423', 25),
('A23423', 45),
('A23423', 78),
('B35643', 25),
('B35643', 45),
('B35643', 98),
('C98787', 67),
('C98787', 86),
('C98787', 91);

with cte as (
select Tickets.TicketID, COUNT(distinct Tickets.Number) as tick_number, COUNT(distinct Numbers.Number) as numb from Tickets
left join Numbers
on Numbers.Number = Tickets.Number
group by Tickets.TicketID
), winning as (
select TicketID, 
case when  numb = (select  count(*) from Numbers) then 100
when numb > 1 then 10
else 0 end as prize 
from cte

)
select SUM(prize) as total from winning


/*9. The Spending table keeps the logs of the spendings history of users that 
make purchases from an online shopping website which has a desktop and a mobile devices.
Write an SQL query to find the total number of users and the total amount spent using mobile only,
desktop only and both mobile and desktop together for each date. */
CREATE TABLE Spending (
  User_id INT,
  Spend_date DATE,
  Platform VARCHAR(10),
  Amount INT
);
INSERT INTO Spending VALUES
(1,'2019-07-01','Mobile',100),
(1,'2019-07-01','Desktop',100),
(2,'2019-07-01','Mobile',100),
(2,'2019-07-02','Mobile',100),
(3,'2019-07-01','Desktop',100),
(3,'2019-07-02','Desktop',100);

WITH purchase
     AS (SELECT user_id,
                spend_date,
                Max(platform) AS platform,
                Sum(amount)   AS amount
         FROM   spending
         GROUP  BY user_id,
                   spend_date
         HAVING Count(DISTINCT platform) = 1
         UNION ALL
         SELECT user_id,
                spend_date,
                'both'      AS platform,
                Sum(amount) AS amount
         FROM   spending
         GROUP  BY user_id,
                   spend_date
         HAVING Count(DISTINCT platform) = 2
         UNION ALL
         SELECT NULL   AS user_id,
                spend_date,
                'both' AS platform,
                0      AS amount
         FROM   spending
         GROUP  BY spend_date)
SELECT spend_date,
       platform,
       Sum(amount)    AS total_amount,
       Count(user_id) AS total_users
FROM   purchase
GROUP  BY spend_date,
          platform
ORDER  BY spend_date,
          platform DESC 



/*10. Write an SQL Statement to de-group the following data.*/
DROP TABLE IF EXISTS Grouped;
CREATE TABLE Grouped
(
  Product  VARCHAR(100) PRIMARY KEY,
  Quantity INTEGER NOT NULL
);
INSERT INTO Grouped (Product, Quantity) VALUES
('Pencil', 3), ('Eraser', 4), ('Notebook', 2);

;WITH Numbers AS
(
    SELECT Product, Quantity, 1 AS n
    FROM Grouped
    UNION ALL
    SELECT Product, Quantity, n + 1
    FROM Numbers
    WHERE n + 1 <= Quantity
)
SELECT Product, 1 AS Quantity
FROM Numbers
OPTION (MAXRECURSION 0)
