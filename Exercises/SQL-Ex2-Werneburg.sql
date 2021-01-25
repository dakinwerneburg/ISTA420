.echo on
.headers on


-- Name:  Dakin T. Werneburg
-- File:  tsql-quiz02-werneburg.sql
-- Date:  1/20/2021


--1. List the company name, the contact name and the country of all customers in Poland.
SELECT companyname,contactname
FROM customers 
WHERE country = 'Poland'; 

--2. List the order Id, the order date, and the destination city of all orders shipped to Berlin.
SELECT orderId, orderDate,shipcity
FROM orders 
WHERE shipcity = 'Berlin';


--3. How many boxes of Filo Mix do we have in stock?
SELECT unitsinstock 
FROM products 
WHERE productname ='Filo Mix';


--4. List the telephone numbers of all of our shippers.
SELECT companyname, phone
FROM shippers;


--5. Who is our oldest employee? Who is our youngest employee?
SELECT "Oldest" as Age, lastname,firstname,min(date(birthdate)) as Birthdate
FROM employees
UNION
SELECT "Youngest",lastname,firstname,max(date(birthdate))
FROM employees;


--6. List the suppliers where the owner of the supplier is also the sales contact.
SELECT companyname, contactname, contacttitle FROM  suppliers WHERE contacttitle = 'Owner';


/*7. Mailing Labels
From the Northwind database we used in class and SQLite, create mailing label for customer representatives. Each label should consist of six, and exactly six lines. The mailing labels should be suitable for printing on sticky label paper, specifically Avery 8160 labels. The format should be as follows:
TITLE FIRSTNAME LASTNAME
COMPANYNAME
STREET ADDRESS
CITY STATE ZIP COUNTRY
[blank line]
[blank line]
*/
   
SELECT contacttitle ||' '|| contactname||'
'||companyname||'
'||address||'
'||city||' '||region||' '||postalcode||' '||country||'
'||'
'FROM customers;

/*
8. Telephone Book From the Northwind database we used in class and SQLite, create a telephone book for customer representatives. Each line in the telehone book should consist of the representative last name, representative first name, company name, and telephone number. Each row should look like this. 

    Lastname, Firstname Middlename [tab] Company name [tab] phone number
*/

SELECT
	--last,
	substr(substr(contactname, instr(contactname,' ')+1),instr(substr(contactname, instr(contactname,' ')+1),' ')+1)||', '||
	--first
	substr(contactname,1,instr(contactname,' '))||' '||
	--middle
	substr (substr(contactname, instr(contactname,' ')+1) , 1, instr(substr(contactname, instr(contactname,' ')+1), ' ')-1)||char(9)||companyname||char(9)||phone
FROM customers;
