CREATE TABLE sales_data (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity_sold INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(50)
);

INSERT INTO sales_data VALUES
    (1, 101, 'Alice', 'Electronics', 'Laptop', 1, 1200.00, 1200.00, '2024-01-01', 'North'),
    (2, 102, 'Bob', 'Electronics', 'Phone', 2, 600.00, 1200.00, '2024-01-02', 'South'),
    (3, 103, 'Charlie', 'Clothing', 'T-Shirt', 5, 20.00, 100.00, '2024-01-03', 'East'),
    (4, 104, 'David', 'Furniture', 'Table', 1, 250.00, 250.00, '2024-01-04', 'West'),
    (5, 105, 'Eve', 'Electronics', 'Tablet', 1, 300.00, 300.00, '2024-01-05', 'North'),
    (6, 106, 'Frank', 'Clothing', 'Jacket', 2, 80.00, 160.00, '2024-01-06', 'South'),
    (7, 107, 'Grace', 'Electronics', 'Headphones', 3, 50.00, 150.00, '2024-01-07', 'East'),
    (8, 108, 'Hank', 'Furniture', 'Chair', 4, 75.00, 300.00, '2024-01-08', 'West'),
    (9, 109, 'Ivy', 'Clothing', 'Jeans', 1, 40.00, 40.00, '2024-01-09', 'North'),
    (10, 110, 'Jack', 'Electronics', 'Laptop', 2, 1200.00, 2400.00, '2024-01-10', 'South'),
    (11, 101, 'Alice', 'Electronics', 'Phone', 1, 600.00, 600.00, '2024-01-11', 'North'),
    (12, 102, 'Bob', 'Furniture', 'Sofa', 1, 500.00, 500.00, '2024-01-12', 'South'),
    (13, 103, 'Charlie', 'Electronics', 'Camera', 1, 400.00, 400.00, '2024-01-13', 'East'),
    (14, 104, 'David', 'Clothing', 'Sweater', 2, 60.00, 120.00, '2024-01-14', 'West'),
    (15, 105, 'Eve', 'Furniture', 'Bed', 1, 800.00, 800.00, '2024-01-15', 'North'),
    (16, 106, 'Frank', 'Electronics', 'Monitor', 1, 200.00, 200.00, '2024-01-16', 'South'),
    (17, 107, 'Grace', 'Clothing', 'Scarf', 3, 25.00, 75.00, '2024-01-17', 'East'),
    (18, 108, 'Hank', 'Furniture', 'Desk', 1, 350.00, 350.00, '2024-01-18', 'West'),
    (19, 109, 'Ivy', 'Electronics', 'Speaker', 2, 100.00, 200.00, '2024-01-19', 'North'),
    (20, 110, 'Jack', 'Clothing', 'Shoes', 1, 90.00, 90.00, '2024-01-20', 'South'),
    (21, 111, 'Kevin', 'Electronics', 'Mouse', 3, 25.00, 75.00, '2024-01-21', 'East'),
    (22, 112, 'Laura', 'Furniture', 'Couch', 1, 700.00, 700.00, '2024-01-22', 'West'),
    (23, 113, 'Mike', 'Clothing', 'Hat', 4, 15.00, 60.00, '2024-01-23', 'North'),
    (24, 114, 'Nancy', 'Electronics', 'Smartwatch', 1, 250.00, 250.00, '2024-01-24', 'South'),
    (25, 115, 'Oscar', 'Furniture', 'Wardrobe', 1, 1000.00, 1000.00, '2024-01-25', 'East')

/*Easy Questions */
/* 1. Compute Running Total Sales per Customer */

select *,
SUM(total_amount) over (partition by customer_id order by order_date) as running_total
from sales_data

/* 2.Count the Number of Orders per Product Category */

select *,
COUNT(sale_id) over (partition by product_category) as cnt_per_category
from sales_data

/* 3.Find the Maximum Total Amount per Product Category */

select *,
MAX(total_amount) over (partition by product_category) as max_per_category
from sales_data

/* 4.Find the Minimum Price of Products per Product Category */

select *,
MIN(total_amount) over (partition by product_category) as min_per_category
from sales_data

/* 5.Compute the Moving Average of Sales of 3 days (prev day, curr day, next day) */

select *,
AVG(total_amount) over (order by order_date rows between 1 preceding and 1 following)
from sales_data

/* 6.Find the Total Sales per Region */

select *,
SUM(total_amount) over (partition by region) total_per_region
from sales_data

/* 7.Compute the Rank of Customers Based on Their Total Purchase Amount */

select *,
DENSE_RANK() over (order by total_amount desc) as rnk
from sales_data

/* 8.Calculate the Difference Between Current and Previous Sale Amount per Customer */
;with cte as (
select *,
LAG(total_amount) over (partition by customer_id order by order_date) as prev
from sales_data
)
select *,
isnull(total_amount - prev, 0) as [difference]
from cte

/* 9.Find the Top 3 Most Expensive Products in Each Category */

; with cte as(
select *,
DENSE_RANK() over (partition by product_category order by unit_price desc) as rnk
from sales_data
)
select * from cte
where rnk in (1, 2, 3)

/* 10.Compute the Cumulative Sum of Sales Per Region by Order Date */

select *,
SUM(total_amount) over (partition by region order by order_date rows unbounded preceding ) as cumulative_sale
from sales_data

--Medium Questions

/* 11.Compute Cumulative Revenue per Product Category */

select *,
SUM(total_amount) over (partition by product_category order by order_date rows unbounded preceding ) as cumulative_revenue
from sales_data

/* 12.Here you need to find out the sum of previous values. Please go through the sample input and expected output. */
create table #table(ID int)
insert into #table values (1), (2), (3), (4), (5)

select *,
SUM(ID) over (order by id) as SumPreValues
from #table

/* 13.Sum of Previous Values to Current Value */

CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select *,
SUM(Value) over (order by value rows between 1 preceding and current row) sum_of_previous
from OneColumn

/* 14.Find customers who have purchased items from more than one product_category */

; with cte as (
select *,
rank() over (partition by customer_id order by product_category) as rnk
from sales_data
)

select * from cte
where rnk >= 2

/* 15.Find Customers with Above-Average Spending in Their Region */

; with cte as (
select *,
AVG(total_amount) over (partition by region) as avg_per_region
from sales_data
)
select * from cte
where total_amount > avg_per_region

/* 16.Rank customers based on their total spending (total_amount) within each region.
If multiple customers have the same spending, they should receive the same rank. */

select *,
DENSE_RANK() over (partition by region order by total_amount desc) as rank_within_region
from sales_data

/* 17.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date. */

select *,
SUM(total_amount) over (partition by customer_id order by order_date rows unbounded preceding) as cumulative_sales
from sales_data

/* 18.Calculate the sales growth rate (growth_rate) for each month compared to the previous month. */
; with cte as (
select DATEPART(MONTH, order_date) as [month],
SUM(total_amount) as total    from sales_data
group by DATEPART(MONTH, order_date) 
)
select *,
LAG(total) over (order by month) as previous,
(total - LAG(total) over (order by month))/ LAG(total) over (order by month) as growth_rate
from cte

/* 19.Identify customers whose total_amount is higher than their last order''s total_amount.(Table sales_data) */
; with cte as (
select *,
LAST_VALUE(total_amount) over (partition by customer_id order by order_date rows between unbounded preceding and unbounded following) as last_order_amount
from sales_data
)
select * from cte
where total_amount > last_order_amount

--Hard Questions
/* 20.Identify Products that prices are above the average product price */

; with cte as (
select *,
AVG(unit_price) over () as average_price
from sales_data
)
select * from cte
where unit_price > average_price

/* 21.In this puzzle you have to find the sum of val1 and val2 for each group and put that value at the beginning of the group in the new column.
The challenge here is to do this in a single select. For more details please see the sample input and expected output. */

CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

select * ,
case when ROW_NUMBER() over (partition by Grp order by id) = 1 then 
SUM(Val1 + Val2) over (partition by Grp) end Tot
from MyData

/* 22. Here you have to sum up the value of the cost column based on the values of Id. 
For Quantity if values are different then we have to add those values.
Please go through the sample input and expected output for details. */

CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

;with cte as (
    select 
        Id,
        sum(Cost) over (partition by Id) as Cost,
        sum(Quantity) over (partition by Id) as Quantity,
        row_number() over (partition by Id order by (select null)) as rn
    from TheSumPuzzle
)
select Id, Cost, Quantity
from cte
where rn = 1;

select 
    Id,
    sum(Cost) as Cost,
    sum(distinct Quantity) as Quantity
from TheSumPuzzle
group by Id;

/* 23.From following set of integers, write an SQL statement to determine the expected outputs */

CREATE TABLE Seats 
( 
SeatNumber INTEGER 
); 

INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30), 
(31),(32),(33),(34),(35),(52),(53),(54); 

;with cte as (
select *,
        LAG(SeatNumber, 1, 0) OVER (ORDER BY SeatNumber) AS PreviousSeat
from Seats
)
select
PreviousSeat + 1 as GapStart,
SeatNumber - 1 as GapEnd
from cte
where SeatNumber - PreviousSeat > 1



