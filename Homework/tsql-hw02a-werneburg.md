# TSQL Homework 02a

---
## Dakin T. Werneburg
## 1/18/2021

---

1.  List the order of execution of a SQL query.
    1. **FROM**
    1. **WHERE**
    1. **GROUP BY**
    1. **HAVING**
	1. **SELECT**
	1. **ORDER BY**
	
1. What does the *from* clause do?
	- **The *FROM* is logically processed first and states the name of the table you want to query and returns all the rows.**  
	
1. What does the *where* clause do?
	- **The *WHERE* clause filters your query to only the records that meet a given critera.**

1. What does the *group by* clause do?
	- **The *GROUP BY* clause produces a group for each unique combination of the elements that you specify**
	
1. What does the *having* clause do?
	- **The *HAVING* clasue is similar to the *WHERE* clause but filters the subset that is produced on the *GROUP BY* clause**
	
1. What does the *select* clause do?
	- **The *SELECT* clause specifies what attributes or columns are returned from a query** 
	
1. What does the distinct keyword do?
	- **The *DISTINCT* keywork supresses duplicate rows in a group and is used before the input expression**
	
1. What does the *order by* clause do?
	- **The *ORDER BY* clause sorts the output result of the query in either ascending (ASC) or descending order (DESC)**

1. What does the limit clause do? This is not in the book.
	- **The *LIMIT* clause limits the number of rows that are returned by a query.  
	
1. What does the top clause do?
	- **The *TOP* clause is Microsoft's proprietary equivalent to the *LIMIT* clause which limits the number or percentage of rows that are retrieved from a query.**  
	
1. What do the offset . . . fetch . . . clauses do?
	- **Combined the *OFFSET* clause allows you to skip rows and *FETCH* specifies the number of from the *OFFSET* to retrieve.  OFFSET and FETCH are dependent and must be used together and cannot be used without a *ORDER BY* clause.**