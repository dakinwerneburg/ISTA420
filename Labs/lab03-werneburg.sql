.echo on
.headers on

-- Name:  Dakin T. Werneburg
-- File:  lab03-werneburg.sql
-- Date:  January 26, 2021


-- 1. What is the order number and the date of each order sold by each employee?

select e.employeeid, e.titleofcourtesy,  e.firstname, e.lastname, o.orderid, o.orderdate from employees as e inner join orders as o on e.employeeid = o.employeeid;

--2. List each territory by region.

select t.territoryid, territorydescription, t.regionid, r.regionid, r.regiondescription from territories as t inner join region as r on t.regionid = r.regionid order by r.regiondescription, t.territorydescription;

--3. What is the supplier name for each product alphabetically by supplier?

select s.supplierid, s.companyname, s.contactname, p.productid, p.productname from suppliers s join products p on  s.supplierid = p.supplierid order by companyname;


--4. For every order on May 5, 1998, how many of each item was ordered, and what was the price of the item?  

select o.orderdate, p.productname, p.unitprice, od.quantity from orders o join order_details od on o.orderid = od.orderid join products p on od.productid = p.productid  where o.orderdate = '1998-05-05';


--6. For every order in May, 1998, what was the customer's name and the shipper's name?

select o.orderid, o.orderdate, o.customerid, c.customerid, c.companyname, o.shipperid, s.shipperid, s.companyname from orders o join customers c on o.customerid = c.customerid join shippers s on o.shipperid = s.shipperid where o.orderdate like '1998-05-%';


--7. What is the customer's name and the employee's name for every order shipped to France?

select c.companyname, e.lastname||', '||e.firstname as full_name,o.orderid from orders o join customers c on o.customerid = c.customerid join employees e on o.employeeid = e.employeeid where o.shipcountry = 'France';

--8. List the products by name that were shipped to Germany