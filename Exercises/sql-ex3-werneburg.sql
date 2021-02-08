.echo on
.headers on
.mode csv

/*
1. We have noticed that certain customers prefer to make their orders with certain employees. We want to increase business by encouraging the customer/employee pairs that are more productive, and to channel the pairs that are less productive into other relationships. To this end, we have ordered this
query and the following three. First, I need the customer ID, the customer contact name, the employee ID, the employee name, the order ID, the number of orders, and the total amount of each order, where the customer/employee pair has produced five or more orders between them, ordered by the dollar amount of the order from highest to lowest. The output needs to be in a comma separated format
with strings that include spaces and commas delimited by double quotes. The dollar amount should be formatted as a decimal number with two decimal places.
*/
SELECT
    c.customerid, 
	c.contactname,
	e.employeeid,
	e.firstname||' '||e.lastname as emp_name,
	o.orderid,
	count(od.orderid) as num_orders,
	printf('%.2f',sum(unitprice * quantity)) as order_total	
FROM customers c 
	INNER JOIN orders o
	on o.customerid = c.customerid
	INNER JOIN employees e 
	on e.employeeid = o.employeeid
	INNER JOIN order_details od
	on od.orderid = o.orderid
GROUP BY o.orderid
HAVING COUNT(od.orderid) >= 5
ORDER BY order_total desc;
/*
2. Second, I want the least productive pairs with the same columns. The total of orders should be less than three, the dollar amount of the order is less than $50.00, and the orders are ranked by increasing dollar amounts, starting with the least order. Here is the expected output.
*/
SELECT
    c.customerid, 
	c.contactname,
	e.employeeid,
	e.firstname||' '||e.lastname as emp_name,
	o.orderid,
	count(od.orderid) as num_orders,
	printf("%.2f",sum(unitprice * quantity)) as order_total
FROM customers c 
	INNER JOIN orders o
	on o.customerid = c.customerid
	INNER JOIN employees e 
	on e.employeeid = o.employeeid
	INNER JOIN order_details od
	on od.orderid = o.orderid
GROUP BY o.orderid
HAVING COUNT(od.orderid) < 5 AND sum(unitprice * quantity) < 50
ORDER BY order_total asc;

/*
3. Third, I need the most productive pairs as in the first report above, omitting the order ID but ranked by the average amount from highest to lowest of all orders by the customer/employee pair. Include only pairs where the amount of the average exceeds $2,500.00. Here is the expected output.
*/

SELECT
    c.customerid, 
	c.contactname,
	e.employeeid,
	e.firstname||' '||e.lastname as emp_name,
	count(od.orderid) as num_orders,
	printf('%.2f',avg(unitprice * quantity)) as order_avg	
FROM customers c 
	INNER JOIN orders o
	on o.customerid = c.customerid
	INNER JOIN employees e 
	on e.employeeid = o.employeeid
	INNER JOIN order_details od
	on od.orderid = o.orderid
GROUP BY o.orderid
HAVING avg(unitprice*quantity) > 2500
ORDER BY order_avg desc;

/*
4. Finally, I need the least productive pairs as ranked by average order amount, from lowest to highest, formatted as above. Omit the order ID. Include only pairs where the average order amount is less than $50.00. Here is the expected output.
*/
SELECT
    c.customerid, 
	c.contactname,
	e.employeeid,
	e.firstname||' '||e.lastname as emp_name,
	count(od.orderid) as num_orders,
	printf('%.2f',avg(unitprice * quantity)) as order_avg	
FROM customers c 
	INNER JOIN orders o
	on o.customerid = c.customerid
	INNER JOIN employees e 
	on e.employeeid = o.employeeid
	INNER JOIN order_details od
	on od.orderid = o.orderid
GROUP BY o.orderid
HAVING avg(unitprice*quantity) < 50
ORDER BY order_avg asc;

/*
5. Please create a report with the order ID, the customer ID, the customer name, the customer country, and the dollar amount of the order, sorted alphabetically by country and numerically from highest to lowest by the dollar amount of the order, where the order total exceeds $5,000.00. Here is the output.
*/
SELECT 
	o.orderid,
	c.customerid,
	c.companyname, 
	c.country, 
	printf('%.2f',sum(unitprice*quantity)) as total_order
FROM customers c
    INNER JOIN orders o
	on o.customerid = c.customerid
	INNER JOIN order_details od
	on od.orderid = o.orderid
GROUP BY o.orderid
HAVING sum(unitprice*quantity) > 5000
ORDER BY country asc, total_order desc;

/*
6. I want to know the unique (distinct) cities, regions, and postal codes: (a) where we have both customers and employees, (b) where we have customers but no employees AND both customers and employees, and (c) where we have employees but no customers AND both customers and employees. Write three queries, using inner and outer joins. Report the results of the queries. There is no need for any further reporting
*/

.mode list 

--(a)

SELECT DISTINCT
	c.companyname as customer, 
	c.city,
	c.region,
	c.postalcode,
	e.firstname||' '||e.lastname as employee,
	e.city,
	e.region,
	e.postalcode
FROM customers c	
	INNER JOIN employees e
	on e.city = c.city
	AND e.region = c.region 
	AND e.postalcode = c.postalcode;


--(b)

SELECT DISTINCT
    c.companyname as customer,
	c.city,
	c.region,
	c.postalcode,
	e.firstname||' '||e.lastname as employee,
	e.city,
	e.region,
	e.postalcode
FROM customers c	
	LEFT JOIN employees e
	on e.city = c.city
	AND e.region = c.region
	AND e.postalcode = c.postalcode;
	
--(c)

SELECT DISTINCT
	e.firstname||' '||e.lastname as employee,
	e.city,
	e.region,
	e.postalcode,
	c.companyname as customer,
	c.city,
	c.region,
	c.postalcode	
FROM employees e	
	LEFT JOIN customers c
	on e.city = c.city
	AND e.region = c.region
	AND e.postalcode = c.postalcode;

 