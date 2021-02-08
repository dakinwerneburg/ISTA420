# TSQL Homework 03

---
Dakin Werneburg  
1/24/2021

---

1. In general, why would you even want to join two (or more) tables together? This is a good time to think about the nature of relational algebra.
> - ** To merge data from two or more tables into one.**


1. Describe in your own words the output from an inner join.
> - **The output from an inner join combines the rows that match both tables, based on the predicate and discard those that do not match.**


1. Describe in your own words the output from an outer join.
> - **Output of the outer joins produces all the tables from the first one and the keeps unmatched rows of the other and fills them with null values.**

1. Describe in your own words the output from an cross join.  
> - **The output is one big list with every possible combination of each table joined into one.  A big mess.**


1. A convenient mnemonic for remembering the various joins is "Ohio." Why is this true?
> - **I could not find any literature on this, but my guess it stands for Outer Has Inner's Outer.????.


1. Give an example of a composite join.

> - **Returns all orderid, the name of the employees that sold had items shipped to thier same home town of London.

> - **SELECT O.orderid, E.lastname, E.firstname, O.shipcity FROM orders AS O INNER JOIN employees AS E on O.employeeid = E.employeeid and O.shipcity = E.city WHERE O.shipcity ='London';**


1. What is the diference between the following two queries? The business problem is "How many orders do we have from each customer?"  

    ```sql
    ================first query===============
    SELECT C.custid, COUNT(*) AS numorders
    FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid
    GROUP BY C.custid;
    ================second query===============
    SELECT C.custid, COUNT(O.orderid) AS numorders
    FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid
    GROUP BY C.custid;
    ```    
    
> - **The first one will count all the rows return where both the orders table and the cutomer table have the same custid which might misrepresent the actual number of orders, whereas the second is the right one that returns the number of orders that the customer placed.**


1. What might be one reason the following query does not return the column custID in this query?  
    ```sql
    SELECT C.custid, C.companyname, O.orderid, O.orderdate
    FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid
    WHERE O.orderdate >= '20160101';
    ```
    
> - **This customer didn't place any order on January 1, 2016"