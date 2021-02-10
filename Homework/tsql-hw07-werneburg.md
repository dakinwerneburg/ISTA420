# TSQL Homework 06

---
Dakin Werneburg  
2/07/2021

1. What is a window function?
- **A window function is a function that, for each row, computes a scalar result value based on a calculation against a subset of the rows from the underlying query. *Own words:* Kind of like a correlated  or subquery query but keeps the view from the underlying query** 

2. What does PARTITION do?
- **The window-partition clause (PARTITION BY) restricts the window to the subset of rows that have the same values in the partitioning columns as in the current row.  *Own words:* A Partition applies the window function against rows of the underlying query that meet the partition element**

3. What does ORDER BY do?
- **the window-order clause (ORDER BY) defines ordering but only within the window function**

4. What does ROWS BETWEEN do?
- **A window-frame clause (ROWS BETWEEN <top delimiter> AND <bottom delimiter>) filters a frame, or a subset, of rows from the window partition between the two specified delimiters. *Own Word:* specifies the range within the window, which the window function applies to for each row in the underlying query**
 
5. What is a ranking window function? Why would you use it? Give an example.
- **Ranking Window Functions allow us to rank set depending on the type of ranking function.  For example if I wanted to know the sequence that the results appear, I could use ROW_NUMBER() but if I want to know the sequence that they appear but also but  also considering duplicates, I would use RANK().**

6. What is an offset window function? Why would you use it? Give an example.
- **An Offset Window Function will return the value that is the offset from the current value.  This is handy if you want to know the difference between the current value and the highest value within a window frame**

7. What do LEAD and LAG DO
- **LEAD specifies the number of rows AFTER the current value, and LAG specifies the number of rows BEFORE the current value, and no value is specified for either of them, it is 1 by default.**

8. What do FIRST VALUE and LAST VALUE do?
- **FIRST VALUE returns the first value within the window frame and LAST value will return the last value within the window frame.**


9. What is an aggragate window function? Why would you use it? Give an example.
- **Aggragae Window Function allows you to apply an aggragated function again a window frame.  This is useful if want to apply the aggregated function for each row of the underlying query**


10. What is a pivot table and what does it do?
- **A Pivot table just switches the Rows to columns and columns to rows and if an aggregation is used, the aggregated result is the intersection of the row and column.** 


11. In mathematical theory, what is a power set? How does this definition of power set relate to grouping sets?
- **In mathematical theory, a power set is every possible subset of a provided set.  A TSQL feature is the CUBE function that simplifies grouping sets by specifying the elements to be grouped then returns every possible subset, including the empyty set.  ROLLUP is similar but only list subsets based on the hierachy of elements which removes one element for each subset.**


12. What is a bit array? How can you implement a bit array to represent a set of flags? How does the GROUPING ID() function implement a bit array?
- **A Bit Array is a an array that holds binary data.  You can implement a bit array to represent a set of flags by associated each binary value with the place they appear in the group.  GROUPING ID() implements this bitmap array by associating the binary value to the group elements position from right to left.**


13. Read the documentation on the UNIX/Linux chmod command. How would interpret this command: chmod 755 myscript.sql?
- **This is the level of access that is assigned to file.  Each level of access is broken down into the different types of users in UNIX/Linux (owner, group,other).  For each type of user a binary value represents a level of permision. 4 for read, 2 for write, and 1 representing execute or 0 meaning no permission.  So 755 means full access (read,write, execute) for owners, read and execute for group users and other users.**



