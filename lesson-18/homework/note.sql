CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Samsung Galaxy S23', 'Electronics', 899.99),
(2, 'Apple iPhone 14', 'Electronics', 999.99),
(3, 'Sony WH-1000XM5 Headphones', 'Electronics', 349.99),
(4, 'Dell XPS 13 Laptop', 'Electronics', 1249.99),
(5, 'Organic Eggs (12 pack)', 'Groceries', 3.49),
(6, 'Whole Milk (1 gallon)', 'Groceries', 2.99),
(7, 'Alpen Cereal (500g)', 'Groceries', 4.75),
(8, 'Extra Virgin Olive Oil (1L)', 'Groceries', 8.99),
(9, 'Mens Cotton T-Shirt', 'Clothing', 12.99),
(10, 'Womens Jeans - Blue', 'Clothing', 39.99),
(11, 'Unisex Hoodie - Grey', 'Clothing', 29.99),
(12, 'Running Shoes - Black', 'Clothing', 59.95),
(13, 'Ceramic Dinner Plate Set (6 pcs)', 'Home & Kitchen', 24.99),
(14, 'Electric Kettle - 1.7L', 'Home & Kitchen', 34.90),
(15, 'Non-stick Frying Pan - 28cm', 'Home & Kitchen', 18.50),
(16, 'Atomic Habits - James Clear', 'Books', 15.20),
(17, 'Deep Work - Cal Newport', 'Books', 14.35),
(18, 'Rich Dad Poor Dad - Robert Kiyosaki', 'Books', 11.99),
(19, 'LEGO City Police Set', 'Toys', 49.99),
(20, 'Rubiks Cube 3x3', 'Toys', 7.99);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate)
VALUES
(1, 1, 2, '2025-04-01'),
(2, 1, 1, '2025-04-05'),
(3, 2, 1, '2025-04-10'),
(4, 2, 2, '2025-04-15'),
(5, 3, 3, '2025-04-18'),
(6, 3, 1, '2025-04-20'),
(7, 4, 2, '2025-04-21'),
(8, 5, 10, '2025-04-22'),
(9, 6, 5, '2025-04-01'),
(10, 6, 3, '2025-04-11'),
(11, 10, 2, '2025-04-08'),
(12, 12, 1, '2025-04-12'),
(13, 12, 3, '2025-04-14'),
(14, 19, 2, '2025-04-05'),
(15, 20, 4, '2025-04-19'),
(16, 1, 1, '2025-03-15'),
(17, 2, 1, '2025-03-10'),
(18, 5, 5, '2025-02-20'),
(19, 6, 6, '2025-01-18'),
(20, 10, 1, '2024-12-25'),
(21, 1, 1, '2024-04-20');

/*1. Create a temporary table named MonthlySales to store the total quantity sold and total revenue for each product in the current month.
Return: ProductID, TotalQuantity, TotalRevenue */
select Products.ProductID, SUM(Sales.Quantity) as total_quantity, SUM(Sales.Quantity * Products.Price) as total_revenue  into #MonthlySales from Products
join Sales
on Products.ProductID = Sales.ProductID
where MONTH(Sales.SaleDate) = 4 and YEAR(SaleDate) =YEAR(GETDATE())
group by Products.ProductID

select * from #MonthlySales

-- my cuurent month is august and there is no sale in this months thats why i used max month of this table
--version 2
select Products.ProductID, SUM(Sales.Quantity) as total_quantity, SUM(Sales.Quantity * Products.Price) as total_revenue  into #MonthlySales_ from Products
join Sales
on Products.ProductID = Sales.ProductID
where MONTH(Sales.SaleDate) = MONTH(GETDATE()) and YEAR(SaleDate) =YEAR(GETDATE())
group by Products.ProductID

select * from #MonthlySales_

/*2. Create a view named vw_ProductSalesSummary that returns product info along with total sales quantity across all time.
Return: ProductID, ProductName, Category, TotalQuantitySold */
go
create view vw_productsalessummary as
(
select Products.ProductID, Products.ProductName, Products.Category, SUM(Sales.Quantity) as total_quantity_sold from Products
join Sales
on Products.ProductID = Sales.ProductID
group by Products.ProductID, Products.ProductName, Products.Category
)
go
select * from vw_productsalessummary

/*3. Create a function named fn_GetTotalRevenueForProduct(@ProductID INT)
Return: total revenue for the given product ID */
go
create function fn_gettotalrevenueforproduct(@ProductID int)
returns table
as
return 
(
select  SUM(Products.Price * Sales.Quantity) AS total_revenue from Products
join Sales
on Products.ProductID = Sales.ProductID
where Products.ProductID = @ProductID
)
go
select * from  fn_gettotalrevenueforproduct(1)

/*4. Create an function fn_GetSalesByCategory(@Category VARCHAR(50))
Return: ProductName, TotalQuantity, TotalRevenue for all products in that category.*/
go
create function fn_Getsalesbycategory(@category varchar(50))
returns table
as
return (
select Products.ProductName, SUM(Sales.Quantity) as totalquantity, SUM(Products.Price * Sales.Quantity) as totalrevenue from Products
join Sales
on Products.ProductID = Sales.ProductID
where Products.Category = @category 
group by Products.ProductName

)
go
select * from fn_Getsalesbycategory('Electronics')

/*5. You have to create a function that get one argument as input from user and the function should return 'Yes' 
if the input number is a prime number and 'No' otherwise. You can start it like this:*/
go
create function udf_fn_IsPrime (@Number INT)
Returns varchar(10)
as
begin
 declare @result varchar(10)= 'yes', @int int = 2
 if @Number < 2 
 begin
 set @result = 'no'
 return @result
 end
 while @int * @int <= @Number
  BEGIN
        IF @Number % @int = 0
        BEGIN
            SET @result = 'No'
            RETURN @result
        END
        SET @int = @int + 1
    END
	return @result
end

select dbo. udf_fn_IsPrime(14)

/* 6.. Create a table-valued function named fn_GetNumbersBetween that accepts two integers as input: */
go
create function udf_fn_GetNumbersBetween (@start int, @end int)
returns @numbers table(number int)
as
begin
 while @start <= @end
 begin
 insert into @numbers (number)
 values (@start)

 set @start = @start + 1 
 end
 return
 end
 go

 select * from udf_fn_GetNumbersBetween (6, 10)

 /* 7. Write a SQL query to return the Nth highest distinct salary from the Employee table. 
 If there are fewer than N distinct salaries, return NULL.*/
 go
 CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    DECLARE @result INT;

    SELECT @result = salary
    FROM (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET (@N - 1) ROWS FETCH NEXT 1 ROWS ONLY
    ) AS t;

    RETURN @result;
END

/* 8.8. Write a SQL query to find the person who has the most friends.
Return: Their id, The total number of friends they have
Friendship is mutual. For example, if user A sends a request to user B and it's accepted, both A and B are considered friends with each other.
The test case is guaranteed to have only one user with the most friends. */
Create table RequestAccepted (requester_id int not null, accepter_id int null, accept_date date null)
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09')

WITH cts AS (
    SELECT requester_id, accepter_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id, requester_id FROM RequestAccepted
)

SELECT TOP 1 requester_id AS id, COUNT(accepter_id) AS num
FROM cts
GROUP BY requester_id
ORDER BY num DESC

/* 9. Create a View for Customer Order Summary.*/
CREATE TABLE Customers_ (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Orders_ (
    order_id INT PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
    order_date DATE,
    amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers_(customer_id, name, city)
VALUES
(1, 'Alice Smith', 'New York'),
(2, 'Bob Jones', 'Chicago'),
(3, 'Carol White', 'Los Angeles');

-- Orders
INSERT INTO Orders_ (order_id, customer_id, order_date, amount)
VALUES
(101, 1, '2024-12-10', 120.00),
(102, 1, '2024-12-20', 200.00),
(103, 1, '2024-12-30', 220.00),
(104, 2, '2025-01-12', 120.00),
(105, 2, '2025-01-20', 180.00);
go
 create view vw_CustomerOrderSummary 
 as 
select Customers_.customer_id,
Customers_.name as FullName,
COUNT(Orders_.order_id) as total_orders,
sum(Orders_.amount) as total_amount,
MAX(Orders_.order_id) as last_order_date from Customers_
left join Orders_
on Customers_.customer_id = Orders_.customer_id
group by Customers_.customer_id, Customers_.name

select * from vw_CustomerOrderSummary

/*10. Write an SQL statement to fill in the missing gaps. You have to write only select statement, no need to modify the table. */
DROP TABLE IF EXISTS Gaps;

CREATE TABLE Gaps
(
RowNumber   INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NULL
);

INSERT INTO Gaps (RowNumber, TestCase) VALUES
(1,'Alpha'),(2,NULL),(3,NULL),(4,NULL),
(5,'Bravo'),(6,NULL),(7,NULL),(8,NULL),(9,NULL),(10,'Charlie'), (11, NULL), (12, NULL)

SELECT g.RowNumber,
       (
         SELECT TOP 1 g2.TestCase
         FROM Gaps g2
         WHERE g2.RowNumber <= g.RowNumber
           AND g2.TestCase IS NOT NULL
         ORDER BY g2.RowNumber DESC
       ) AS Workflow
FROM Gaps g
ORDER BY g.RowNumber
