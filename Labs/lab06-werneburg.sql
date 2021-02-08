--Name: Dakin T. Werneburg
-- File: LAB06-werneburg.sql
-- Date: 02/08/2021

use TSQLV4;
go
--1. Find employee ids who had orders in both January, 2016 AND February, 2016.

select o.empid from sales.orders o where o.orderdate like '2016-01-%'
intersect
select o1.empid from sales.orders o1 where o1.orderdate >= '2016-02-01' and o1.orderdate < '2016-03-01';

--2. Find employee ids who had orders in both January, 2016 OR February, 2016.

select o.empid from sales.orders o where o.orderdate like '2016-01-%'
union
select o1.empid from sales.orders o1 where o1.orderdate >= '2016-02-01' and o1.orderdate < '2016-03-01';

--3. Find employee id who had orders in both 2016 NOT 2014.
select o.empid from sales.orders o where year(o.orderdate) = 2016
except
select o1.empid from sales.orders o1 where year(o1.orderdate) = 2014;

--4. cities and countries where we have both customers and employees

select e.city, e.country from hr.employees e
intersect
select c.city, c.country from sales.customers c;

--5. cities and countries where we have either customers or employees

select e.city, e.country from hr.employees e
union
select c.city, c.country from sales.customers c;

--6. cities and countries where we have customers but not employees

select c.city, c.country from sales.customers c
except
select e.city, e.country from hr.employees e;

--7. cities and countries where we have empolyees but not customers

select e.city, e.country from hr.employees e
except
select c.city, c.country from sales.customers c;

--7. cities and countries where we have empolyees but not customers and 
--cities and countries where we have customers but not employees


(select e.city, e.country from hr.employees e
union
select c.city, c.country from sales.customers c)
except
(select e.city, e.country from hr.employees e
intersect
select c.city, c.country from sales.customers c)
