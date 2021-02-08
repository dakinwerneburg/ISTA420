# TSQL Homework 06

---
Dakin Werneburg  
2/07/2021

1. What does a set operator do?
- **Set operators are operators that combine rows from two query result sets**

2. What are the general requirements of a set operator
- **The two sets must have the same number of columns with compatible data types, and there cannot be an order by within each query**

3. What is a Venn Diagram? This is not in the book.
- **A Venn Diagram shows how sets are related using overlapping circles**

4. Draw a Venn Diagram of the UNION operator. What does it do?
- **It merges the results of the two select statements and returns unique values**

5. Draw a Venn Diagram of the UNION ALL operator. What does it do?
- **UNION ALL is similar to UNION but instead of only returning unique values it returns all data from al tables no mater if there are duplicates.**


6. Draw a Venn Diagram of the INTERSECT operator. What does it do?
- **INTERSECT operator merges two tables and the result is what appears in both tables.**


7. If SQL Server supported the INTERSECT ALL operator, what would it do?
- **It would do the same thing as INTERSECT but it won't eliminate duplicate rows.**


8. Draw a Venn Diagram of the EXCEPT operator. What does it do?
- **EXCEPT operator returns those tuples that are present in one set but not the other.**


9. If SQL Server supported the EXCEPT ALL operator, what would it do?
- **Same as EXCEPT but won't remove the duplicats**


10. What is the precedence of the set operators?
- **Parentheses, then INTERSECT operator precedes UNION and EXCEPT, and UNION and EXCEPT are evaluated in order of appearance.**


11. The symmetric difference of two sets A and B is all elements in A that are also not in A and B, and all elements of B that are also not in A and B. For example, if set A consisted of all integers between 1 and 100 that are divisible by 2, and set B consisted of all integers between 1 and 100 that are divisible by 3, the symmetric difference of A and B would include all integers in A and B except integers divisible by both 2 and 3, e.g., 6, 12, 18, etc. Write a SQL query that computes the symmetric difference of two tables A and B.

```sql

SELECT integer FROM A WHERE interger % 2 = 0

INTERSECT

SELCT integer FROM B WHERE integer % 3 =0 ;

```

