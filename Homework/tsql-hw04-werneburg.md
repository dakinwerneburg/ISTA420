# TSQL Homework 04

---
Dakin Werneburg  
1/31/2021

---

1. In your own words, what is a subquery?
- **Subquery is a query within a query that returns a result at runtime.**

2. In your own words, what is a self contained subquery?
- **Self contained subquery is a query that can be run by it self without referencing tables in the outer query**

3. In your own words, what is a correlated subquery?
- **A correlated subquery is a query that is dependant on the tables from the outer query**


4. Give an example of a subquery that returns a single value. When would you use this kind of subquery? 
- **You would use single value when you want to return a scalar value that is aggregated or to calculate a summary value for use in a query**  

```sql
SELECT orderid, orderdate
FROM Sales.Orders
WHERE orderid = (SELECT MAX(orderid)  FROM Sales.Orders);
```



5. Give an example of a subquery that returns multiple values. When would you use this kind of subquery?
- **You would use a multiple value subquery when you want the outer query to return results that in the set of the inner query**
```sql
SELECT orderid, orderdate
FROM Sales.Orders
WHERE orderid < (SELECT MAX(orderid)  FROM Sales.Orders);
```


6. Give an example of a subquery that returns table values. When would you use this kind of subquery?
- **You use table value subqueries when you want the outer query to use the subquery table in the from clause**

```sql
SELECT orderid, orderdate
FROM (SELECT orderid, orderdate FROM orders where orderid < 11000; 

```

7. What does the exists predicate do? Give an example.
- **Exis predicate will apply a filter only if the table returns rows**
```sql
SELECT custid, companyname
FROM Sales.Customers as C
WHERE country = 'Spain'
 AND EXISTS
   (SELECT * FROM Sales.Orders As O 
   WHERE O.custid = C.custid; 
```

8. What happens if we use the not operator before a predicate? Give an example.
- **Using the Not Operator will filter for only rows that do not exist in the table**
```sql
SELECT custid, companyname
FROM Sales.Customers as C
WHERE country = 'Spain'
 AND NOT EXISTS
   (SELECT * FROM Sales.Orders As O 
   WHERE O.custid = C.custid; 
```

9. When you use exists or not exists with respect to a row in a database, does it return two or three values? Explain your answer.
- **Exists and Not Exists return two value logic because either it's true or false and there is no situation where it would be unknown if rows exists.**


10. How would you use a subquery to calculate aggregates? For example, you want to calculate yearly sales of a product, and you also want to keep a running sum of total sales. Explain how you would use a subquery to do this.
- **You would use the aggregated function inside the subquery and correlated it with the outer query**
```sql
SELECT orderyear, qty, 
   (SELECT SUM(O2.qty)
     FROM Sales.OrderTotalsByYear AS O2
	 WHERE O2.orderyear <= O1.orderyear) AS runqty
FROM Sales.OrderTotalsByYear as O1
ORDER by orderyear;           
```


