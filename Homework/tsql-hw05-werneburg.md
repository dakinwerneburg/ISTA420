# TSQL Homework 05

---
Dakin Werneburg  
2/01/2021

---
1. What is a table expression? Can you give a technical definition of a table expression?
- **Table expression is a named query that represents a valid relational table.  A Technical definition is a result set that can be attached to an outer query**

2. In what SQL clause are derived tables (table valued subqueries) located?
- **From Clause**

3. Why can you refer to column aliases in an outer query that you defined in an inner table valued subquery?
- **Because a derived table or inner table is defined in the FROM clause which is executed before the SELECT statement**

4. What SQL key word defines a common table expression?
- **WITH**

5. When using common table expressions, can a subsequent derived table use a table alias declared in a preceding table expression?
- **Yes because CTE already exists before it reaches the outer query**


6. Can a main query refer to a previously defined common table expression by multiple aliases?
- **Yes, as long as it refers to table that was previously defined**

7. In SQL, is a view a durable object?
- **It is stored in the database so it is stateful, but if changes occur such as new columns, the view will need to be updated, so in this sense it is not durable.**

8. In a view, what does WITH CHECK OPTION do? Why is this important?
- **To prevent modifications through the view that conflict with the views filter.  This protects modification such as UPDATE or INSERT that conflict with the view's filter.**

9. In a view, what does SCHEMABINDING do? Why is this important?
- **SCHEMABINDING binds the schema of referenced objects and columns to the schema of the referencing object.  This is important so columns or entire tables that are being referenced can't be deleted or modified**


10. What is a table valued function?
- **Table valued function is a method or function that accepts parameters and returns a table**

11. What does the APPLY operator do?
- **APPLY operator, like a join, uses two input tables, but unlike join, you can reference from both the left and right**.

12. What are the two forms of the APPLY operator? Give an example of each.
- **CROSS APPLY and OUTER APPLY.**

```sql
SELECT S.Shipperid, E.empid
FROM Sales.Shippers AS S 
    CROSS APPLY HR.Employees AS E;
    
SELECT C.custid, A.orderid, A.orderdate
FROM Sales.Customers AS C 
    OUTER APPLY
      (SELECT TOP (3) orderid, empid, orderdate, requireddate
       FROM Sales.Orders AS OPTION
       WHERE O.custid = C.custid
       ORDER BY orderdate DESC, orderid DESC) AS A;