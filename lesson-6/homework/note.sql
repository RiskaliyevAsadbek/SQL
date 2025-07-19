--1-puzzle
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');
 select * from InputTbl
--1 - usul
select distinct
case
  when col1<col2 then col1 else col2 end as col1,
 case
  when col1<col2 then col2 else col1 end as col2
 from InputTbl
 --2 -usul
 select distinct
   least(col1, col2) as col1,
   greatest(col1,col2) as col2
from InputTbl
--2-puzzle
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
--1-usul
select * from TestMultipleZero
where A<>0 OR B<>0 OR C<>0 OR D<>0
--2-USUL
SELECT * from TestMultipleZero
where NOT(A=0 AND B=0 AND C=0 AND D=0)
--3-usul
select * from TestMultipleZero
where A+B+C+D >0

--3-puzzle
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
select * from section1
where id % 2 =1

--4-puzzle
select * from section1
where id = (select min(id) from section1)

--5-puzzle
select * from section1
where id = (select max(id) from section1)

--6-puzzle
select * from section1
where name like 'B%'

--7-puzzle
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

select * from ProductCodes
where code like '%\_%' escape '\'
