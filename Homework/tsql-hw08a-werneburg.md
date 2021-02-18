# TSQL Homework 08a

---
Dakin Werneburg  
2/15/2021

1. When using INSERT, is the list of columns necessary? Why or why not?
- **No. Because SQL Server will automatically generate defualt vales or will result in error if required, and no default set.**

2. When using INSERT SELECT, do you use a subquery (derived table)? Under what circumstances do you not use a subquery?
- **Yes.  When all the columns to be inserted are not present in the derived table.**

3. What is the operand for the INSERT EXEC statement?
- **A stored procedure**

4. How would you use the INSERT INTO statement?
- **To copy a table into a new one**

5. What are the parameters to the BULK INSERT statement?
- **Target table, the source file, and options**

6. Does IDENTITY guarantee uniqueness? If not, how do you guarantee uniqueness?
- **No. To guarantee uniqueness you must define a primary key or a unique constraint**

7. How do you create a SEQUENCE object?
- **You use the CREATE SEQUENCE command followed by at minimum the sequence name.**

8. How do you use a SEQUENCE object?
- **Invoke the standard function NEXT VALUE FOR followed by sequene name**

9. How do you alter a SEQUENCE object?
- **Using the ALTER SEQUENCE command followed the sequence name.**

10. What is the difference between DELETE and TRUNCATE?
- **DELETE deletes rows based on some predicate whereas TRUNCATE does not use a predicate, is much more efficient due to not being fully logged, TRUNCATE also resets the identity value back to the original seed.**

11. What is the difference between DELETE and DROP TABLE?
- **DELETE deletes records based on some condition whereas DROP table deletes all records of table.**