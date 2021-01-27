.echo on
.headers on

-- Name: Dakin Werneburg
-- File Name: lab2a-werneburg.sql
-- Date:  January 19, 2021

--1. What are the regions?

SELECT * FROM region;

--2. What are the cities?

SELECT * FROM territories;

--3. What are the cities in the Southern region?

SELECT * FROM territories WHERE regionid = 4;

--4. How do you run this query with the fully qualified column name?

SELECT 
	territories.territoryid, 
	territories.territorydescription, 
	territories.regionid 
FROM territories where regionid = 4;

--5. How do you run this query with a table alias?

SELECT 
	T.territoryid, 
	T.territorydescription, 
	T.regionid 
FROM territories T where regionid = 4;

--6. What is the contact name, telephone number, and city for each customer?

SELECT contactname, phone, city FROM customers;

--7. What are the products currently out of stock?

SELECT productid, productname, unitsinstock FROM products WHERE unitsinstock = 0;

--8. What are the ten products currently in stock with the least amount on hand?

SELECT 
	productid, 
	productname, 
	unitsinstock 
FROM products WHERE unitsinstock > 0 ORDER BY unitsinstock limit 10;

-- 9. What are the five most expensive products in stock?

SELECT 
	productid, 
	productname, 
	unitsinstock, 
	unitprice 
FROM products WHERE unitsinstock > 0 ORDER  BY unitprice DESC LIMIT 5;

--10. How many products does Northwind have? How many customers? How many suppliers?

SELECT COUNT(productid) FROM products;
SELECT COUNT(customerid) FROM customers;
SELECT COUNT(supplierid) FROM suppliers;
