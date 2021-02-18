-- Name: Dakin Werneburg
-- File: sql-ex6-werneburg.sql
-- 2/17/2021



DROP DATABASE IF EXISTS ex06;
go

CREATE DATABASE ex06;
go



CREATE TABLE ex06.dbo.ProductLines
(
	productLine varchar(500) not null,
	textDescription varchar(1000),
	htmlDescription varchar(500),
	images varchar(max),
	CONSTRAINT PK_productLine
		PRIMARY KEY (productLine)
);
go


BULK INSERT ex06.dbo.ProductLines 
	FROM 'C:\Users\Dakin\MSSA2021\Database\ProductLines.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'

);
go

CREATE TABLE ex06.dbo.Products
(
	productCode varchar(25) not null,
	productName varchar(500) not null,
	productLine varchar (500) not null,
	productScale varchar (25),
	productVendor varchar(500) not null,
	productDescription varchar(500),
	quantityInStock int not null,
	buyPrice decimal,
	MSRP decimal,
	CONSTRAINT PK_productCode
		PRIMARY KEY (productCode),
	CONSTRAINT FK_productLine
		FOREIGN KEY (productLine)
		REFERENCES ex06.dbo.productLines(productLine)

);
go

BULK INSERT ex06.dbo.Products 
	FROM 'C:\Users\Dakin\MSSA2021\Database\Products.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'

);
go

CREATE TABLE ex06.dbo.Offices
(
	officeCode int not null,
	city varchar(50) not null,
	phone varchar (50) not null,
	addressLine1 varchar(50),
	addressLine2 varchar (50),
	state varchar(25),
	country varchar(50),
	postalCode varchar(50),
	territory varchar(50),
	CONSTRAINT PK_officeCode
		PRIMARY KEY (officeCode),
);
go

BULK INSERT ex06.dbo.Offices
	FROM 'C:\Users\Dakin\MSSA2021\Database\Offices.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'

);
go

CREATE TABLE ex06.dbo.Employees
(
	employeeNumber int not null,
	lastName varchar(50) not null,
	firstName varchar(50) not null,
	extension varchar(5),
	email varchar(50),
	officeCode int not null,
	reportsTo int,
	jobTitle varchar(50),
	CONSTRAINT PK_employeeNumber 
		PRIMARY KEY (employeeNumber),
	CONSTRAINT FK_officeCode
		FOREIGN KEY (officeCode)
		REFERENCES ex06.dbo.offices(officecode),
	CONSTRAINT FK_reportsTo
		FOREIGN KEY (reportsTo)
		REFERENCES ex06.dbo.employees(employeeNumber)
);
go


BULK INSERT ex06.dbo.Employees
	FROM 'C:\Users\Dakin\MSSA2021\Database\Employees.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	KEEPNULLS

);
go

CREATE TABLE ex06.dbo.Customers
(
	customerNumber int not null,
	customerName varchar(50) not null,
	contactFirstName varchar(50) not null,
	contactLastName varchar(50) not null,
	phone varchar(50),
	addressLine1 varchar(100),
	addressLine2 varchar(100),
	city varchar (100),
	state varchar (50),
	postalCode varchar (50),
	country varchar (50),
	salesRepEmployeeNumber int,
	creditLimit int,
	CONSTRAINT PK_customerNumber 
		PRIMARY KEY (customerNumber),
	CONSTRAINT FK_salesRepEmployeeNumber 
		FOREIGN KEY(salesRepEmployeeNumber)
		REFERENCES ex06.dbo.employees(employeeNumber)
);
go

BULK INSERT ex06.dbo.Customers
	FROM 'C:\Users\Dakin\MSSA2021\Database\Customers.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	KEEPNULLS

);
go

CREATE TABLE ex06.dbo.Orders
(
	orderNumber int not null,
	orderDate date not null,
	requireDate date not null,
	shipDate varchar(50),
	status varchar(50) not null,
	comments varchar(255),
	customerNumber int not null,
	CONSTRAINT PK_orderNumber 
		PRIMARY KEY (orderNumber),
	CONSTRAINT FK_orders_customerNumber
		FOREIGN KEY (customerNumber)
		REFERENCES ex06.dbo.customers(customerNumber)
);
go

BULK INSERT ex06.dbo.orders
	FROM 'C:\Users\Dakin\MSSA2021\Database\Orders.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	KEEPNULLS

);
go

CREATE TABLE ex06.dbo.OrderDetails
(
	orderNumber int not null,
	productCode varchar(25) not null,
	quantityOrdered int not null,
	priceEach decimal not null,
	orderLineNumber int not null,
	CONSTRAINT PK_orderdetails 
		PRIMARY KEY (orderNumber,productCode),
	CONSTRAINT FK_OrderDetails_productcode
		FOREIGN KEY (productCode)
		REFERENCES ex06.dbo.products(productCode),
	CONSTRAINT FK_OrderDetails_orders
		FOREIGN KEY (orderNumber)
		REFERENCES ex06.dbo.orders(orderNumber)
);
go


BULK INSERT ex06.dbo.orderdetails
	FROM 'C:\Users\Dakin\MSSA2021\Database\OrderDetails.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	KEEPNULLS

);
go

CREATE TABLE ex06.dbo.Payments
(
	customerNumber int not null,
	checkNumber varchar(255) not null,
	paymentDate date,
	amount decimal,
	CONSTRAINT PK_payment
		PRIMARY KEY (customerNumber,checkNumber),
	CONSTRAINT FK_payments_customerNumber
		FOREIGN KEY(customerNumber)
		REFERENCES ex06.dbo.customers(customerNumber)
);
go

BULK INSERT ex06.dbo.Payments
	FROM 'C:\Users\Dakin\MSSA2021\Database\Payments.csv'
WITH
(
	FORMAT = 'csv',
	FIELDQUOTE ='"',
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	KEEPNULLS

);
go


------------------------------------------QUERIES----------------------------------------------------

--(a) How many distinct products does ClassicModels sell?

SELECT COUNT(DISTINCT p.productName) as DistinctProducts
FROM ex06.dbo.Products p


--(b) Report the name and city of customers who don't have sales representatives?

SELECT c.customerNumber,c.city
FROM ex06.dbo.Customers c
WHERE c.salesRepEmployeeNumber is NULL;


--(c) What are the names of executives with VP or Manager in their title? Use the CONCAT function
--    to combine the employee's first name and last name into a single field for reporting.

SELECT e.firstName + ' ' + e.lastName as Employee, e.jobTitle
FROM ex06.dbo.Employees e
WHERE e.jobTitle like '%VP%' OR e.jobTitle like '%Manager%'
ORDER BY Employee;


--(d) Which orders have a value greater than $5,000?

SELECT od.orderNumber, (od.quantityOrdered * od.priceEach) as SalePrice 
FROM ex06.dbo.OrderDetails od
WHERE (od.quantityOrdered * od.priceEach) > 5000
ORDER BY SalePrice desc;


--(e) Report the account representative for each customer.

SELECT c.customerName, e.firstName + ' ' + e.lastName as Account_Respresentative
FROM ex06.dbo.Customers c
 INNER JOIN ex06.dbo.Employees e
	ON c.salesRepEmployeeNumber = e.employeeNumber
ORDER BY c.customerName;


--(f) Report total payments for Atelier graphique.

SELECT c.customerName, SUM(p.amount) as Total_Payments 
FROM ex06.dbo.Payments p
	INNER JOIN ex06.dbo.Customers c
		on p.customerNumber = c.customerNumber
WHERE c.customerName = 'Atelier graphique'
GROUP BY c.customerName;


--(g) Report the total payments by date

SELECT p.paymentDate, SUM(p.amount) as Total_Payments
FROM ex06.dbo.Payments p
GROUP BY p.paymentDate
ORDER BY p.paymentDate;

--(h) Report the products that have not been sold.

SELECT DISTINCT p.productName
FROM ex06.dbo.Products p
	LEFT JOIN ex06.dbo.OrderDetails od
		on p.productCode = od.productCode
WHERE od.productCode IS NULL
ORDER BY p.productName;


--(i) List the amount paid by each customer.

SELECT c.customerName, sum(p.amount) as Amount_Paid
FROM ex06.dbo.Customers c
	INNER JOIN ex06.dbo.Payments p
		on c.customerNumber = p.customerNumber
GROUP BY c.customerName;


--(j) List products sold by order date.

SELECT DISTINCT o.orderdate, p.productName
FROM ex06.dbo.Products p
	INNER JOIN ex06.dbo.OrderDetails od
		on p.productCode = od.productCode
	INNER JOIN ex06.dbo.Orders o
		on od.orderNumber = o.orderNumber
ORDER BY o.orderDate;

--(k) List the order dates in descending order for orders for the 1940 Ford Pickup Truck.

SELECT DISTINCT o.orderNumber, o.orderdate
FROM ex06.dbo.Products p
	INNER JOIN ex06.dbo.OrderDetails od
		on p.productCode = od.productCode
	INNER JOIN ex06.dbo.Orders o
		on od.orderNumber = o.orderNumber
WHERE p.productName = '1940 Ford Pickup Truck'
ORDER BY o.orderDate;


--(l) List the names of customers and their corresponding order number where a particular order from
--    that customer has a value greater than $25,000?

WITH Customer_Orders_CTE 
AS 
(
	SELECT c.customerName, o.orderNumber, SUM(od.quantityOrdered * od.priceEach) as OrderValue
	FROM  ex06.dbo.Orders o
		INNER JOIN ex06.dbo.OrderDetails od
			on o.orderNumber = od.orderNumber
		INNER JOIN ex06.dbo.Customers c
			on o.customerNumber = c.customerNumber
	GROUP BY c.customerName, o.orderNumber
)

SELECT customerName, orderNumber, OrderValue
FROM Customer_Orders_CTE
WHERE OrderValue > 25000
ORDER BY customerName, orderNumber;


--(m) Compute the commission for each sales representative, assuming the commission is 5% of the
--    value of an order. Sort by employee last name and first name.



WITH Employee_Orders_CTE(FirstName, LastName, Commision_Per_Order) 
AS 
(
	SELECT e.lastName, e.firstName, 
		(SUM(od.priceEach *od.quantityOrdered)*.05)
	FROM  ex06.dbo.OrderDetails as od
		INNER JOIN ex06.dbo.Orders as o 
			on od.orderNumber = o.orderNumber
		INNER JOIN ex06.dbo.Customers as c 
			on c.customerNumber = o.customerNumber
		INNER JOIN ex06.dbo.Employees as e 
			on c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY o.ordernumber, e.employeeNumber, e.lastName, e.firstName
)

SELECT LastName, FirstName, SUM(Commision_Per_Order) as Total_Commision
FROM Employee_Orders_CTE
GROUP BY LastName, FirstName 
ORDER BY LastName,FirstName;

--(n) What is the difference in days between the most recent and oldest order date in the Orders file?

SELECT DATEDIFF(DAY, MIN(o.orderdate), MAX(o.orderdate)) as Elapse_Days
FROM ex06.dbo.Orders o;


-- (o) Compute the average time between order date and ship date for each customer ordered by the
--     largest difference.

WITH Customer_Orders_CTE 
AS 
(
	SELECT DISTINCT c.customerName, o.orderNumber, DATEDIFF(DAY, o.orderdate, o.shipDate ) as Elapse_Shipped
	FROM  ex06.dbo.Orders o
		INNER JOIN ex06.dbo.Customers c
			on o.customerNumber = c.customerNumber
	WHERE status = 'Shipped'
)

SELECT customerName, AVG(Elapse_Shipped) as Average_Shipping_Days
FROM Customer_Orders_CTE
GROUP BY customerName
ORDER BY Average_Shipping_Days desc;








	




