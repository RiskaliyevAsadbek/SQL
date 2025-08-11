--Easy Tasks
--task 1 Write a SQL query to split the Name column by a comma into two separate columns: Name and Surname.(TestMultipleColumns)
select  SUBSTRING(Name, 1, CHARINDEX(',',Name )-1) as name, 
SUBSTRING(Name, CHARINDEX(',', name)+1, len(name)) as surname 
from TestMultipleColumns
--task 2 Write a SQL query to find strings from a table where the string itself contains the % character.(TestPercent)
select * from TestPercent
where Strs  like '%/%%' escape '/'
--task 3 In this puzzle you will have to split a string based on dot(.).(Splitter)
select * from Splitter 
cross apply (select value from string_split(Vals, '.')) as A
--task 4 Write a SQL query to replace all integers (digits) in the string with 'X'.(1234ABC123456XYZ1234567890ADS) 
declare @string varchar(100) = '1234ABC123456XYZ1234567890ADS'
declare @i int = 1

while @i<= len(@string)
begin
set @string = replace(@string, cast(@i as varchar(1)), 'X')
set @i = @i +1
end
select @string as replaced
--task 5 Write a SQL query to return all rows where the value in the Vals column contains more than two dots (.).(testDots)
select *, LEN(Vals)- len(REPLACE(Vals, '.', '')) as number_of_dots from testDots
where LEN(Vals)- len(REPLACE(Vals, '.', '')) > 2
--task 6 Write a SQL query to count the spaces present in the string.(CountSpaces)
select *, len(texts) - LEN(REPLACE(texts, ' ', '')) as number_of_space from CountSpaces
--task 7 write a SQL query that finds out employees who earn more than their managers.(Employee)
select * from Employee as e1
left join Employee as e2
on e1.ManagerId = e2.Id
where e1.Salary > e2.Salary
--task 8 Find the employees who have been with the company for more than 10 years, but less than 15 years.
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service (calculated as the number of years between the current date and the hire date).(Employees)
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME, HIRE_DATE, DATEDIFF(YEAR, HIRE_DATE, GETDATE()) as years_of_service from Employees
where DATEDIFF(YEAR, HIRE_DATE, getdate()) > 10 and DATEDIFF(YEAR, HIRE_DATE, getdate()) < 15
--                      medium tasks
--task 1 Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
declare @character varchar(100) = 'rtcfvty34redt'
declare @integer varchar(100) = ''
declare @charactervalues varchar(100) = ''
declare @count int = 1

while @count <= len(@character)
begin
if ascii(SUBSTRING(@character, @count, 1)) between 97 and 122
    begin
set @charactervalues = @charactervalues + SUBSTRING(@character, @count, 1)
set @count = @count +1
    end
else 
begin
set @integer = @integer + SUBSTRING(@character, @count, 1)
set @count = @count +1

end
end
 select @character, @charactervalues, @integer
--task 2 write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.(weather)
select * from weather as w1
left join weather as w2
on w1.RecordDate = DATEADD(DAY,1, w2.RecordDate)
where w1.Temperature > w2.Temperature
--task 3 Write an SQL query that reports the first login date for each player.(Activity)
select player_id, min(event_date) as first_logindate from Activity
group by player_id
--task 4 Your task is to return the third item from that list.(fruits)
select SUBSTRING(fruit_list, 
CHARINDEX(',', fruit_list, charindex(',', fruit_list)+1)+1, 
CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, charindex(',', fruit_list)+1)+1)- charindex(',', fruit_list, charindex(',', fruit_list)+1)-1)
from fruits
--task 5 Write a SQL query to create a table where each character from the string will be converted into a row.(sdgfhsdgfhs@121313131)
DECLARE @s VARCHAR(100) = 'sdgfhsdgfhs@121313131';
DECLARE @c INT = 1;

CREATE TABLE chars0 (
    char_value VARCHAR(1)
)

WHILE @c <= LEN(@s)
BEGIN
    INSERT INTO chars0 
    VALUES ( SUBSTRING(@s, @c, 1))

    SET @c = @c + 1;
END

SELECT * 
FROM chars0;
--task 6 You are given two tables: p1 and p2. Join these tables on the id column. The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
select *,
case when p1.code = 0 then p2.code
else p1.code end  as replaced 
from p1
inner join p2
on p1.id = p2.id
--task 7 Write an SQL query to determine the Employment Stage for each employee based on their HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
select *,
case when DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 then 'new hire'
when  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 1 and  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 5 then 'junior'
when  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 5 and  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 10 then 'mid-level'
when  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10 and  DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 20 then 'senior'
else 'veteran' end as status
from Employees
--task 8 Write a SQL query to extract the integer value that appears at the start of the string in a column named Vals.(GetIntegers)
select SUBSTRING(VALS, PATINDEX('[0-9]%', vals), 1) from GetIntegers
--            difficult tasks
--task 1 In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
select *,SUBSTRING(Vals, CHARINDEX(',', Vals)+1, 1) + '.' + SUBSTRING(Vals,1, 1) + '.' +SUBSTRING(Vals, CHARINDEX(',', vals, charindex(',', vals)+1), len(vals)) as swapped  from MultipleVals
--task 2 Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT a1.player_id, a1.device_id, a1.event_date
FROM Activity a1
LEFT JOIN Activity a2
  ON a1.player_id = a2.player_id
 AND a2.event_date < a1.event_date
WHERE a2.event_date IS NULL
--task 3 You are given a sales table. Calculate the week-on-week percentage of sales per area for each financial week.
--For each week, the total sales will be considered 100%, and the percentage sales for each day of the week should be calculated based on the area sales for that week.(WeekPercentagePuzzle)
select * from WeekPercentagePuzzle
SELECT
  financialweek,
  area,
  SUM(isnull(saleslocal, salesremote)) AS weekly_area_sales,
  SUM(isnull(saleslocal, salesremote)) * 100.0 / SUM(SUM(isnull(saleslocal, salesremote))) OVER (PARTITION BY financialweek) AS percentage_of_week
FROM WeekPercentagePuzzle
GROUP BY financialweek, area
ORDER BY financialweek, area;
