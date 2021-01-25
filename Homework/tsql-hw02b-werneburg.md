# TSQL Homework 02b

---
Dakin Werneburg  
1/19/2021

---
1. What is a data type? Why do we have data types?
 **Data type is a  representation of the data that is being stored and share some property.  We have data types so the computer knows how much memory to allocate and constrain the value that an expression might take.**
 
1. What is a collation? Name four elements of a collation.
 **A Collation is a set of character and character encoding rules that the database uses to sort and compare.  Instance, database, column, and expression are four different elements of a collation.**
 
1. How would you strip whitespace from a string? For example, suppose you had “ Dave ” but wanted only “Dave”.
 - **There are several options but the simplest is to pass the string literal into the TRIM function.  But you could also use the RTRIM function, and nestle that inside a LTRIM function.  For example:  (LTRIM(RTRIM(" Dave ")).
 
1. Suppose you wanted to make a list of every college and university that was called an Institute from the college table. Write the query.
 - **SELECT * FROM college where name = "Institute";**
 
1. How would you find the number of the index of the first space in a string? For example, the index of the first space in “Barack Hussein Obama” would be 7.
 - **In TSQL you would use the CHARINDEX and SQLITE3 you would use the INSTR function.**
 > **TSQL Example: SELECT CHARINDEX(' ','Barack Hussein Obama');**
 
 > **SQLITE3 Example:  SELECT INSTR("Barack Hussein Obama", " ");**
      
1. How would you select just the first name in a list of the presidents. Each record looks like the: ”George Washington”, ”John Adams”, ”Thomas Jefferson”. First names can be an arbitrary length, from “Cal” to “Benjamin.” (e.g., Cal College, Benjamin Harrison)
 - **There are several ways to do this but for me the easiest was to use the substring function and remove everything after the first space.**
 
 > **TSQL Example:   SELECT SUBSTRING('George Washington',1,CHARINDEX(' ','George Washington') -1);**
 
 >**SQLITE3 Example: SELECT SUBSTRING("George Washington",1,INSTR("George Washington", " ") -1);**
 
1. What is the order of precedence for the logical operators?
 1. **NOT**
 1. **AND**
 1. **BETWEEN, IN, LIKE, OR**
  
1. What is the order of precedence for the math operators?
 1. **\* (Multiplication), / (Division), % (Modulo)**
 1. **+ (Addition), – (Subtraction)**


1. What is the difference between a simple and a searched CASE expression?;
 - **The simple CASE expression compares an expression to a set of simple expressions to determine the result; whereas, the searched cased expression evaluates a set of Boolean expressions to determine the result.**
 
1. How would you turn a list of names like this: “LASTNAME, FIRSTNAME”, to a list like this: “FIRSTNAME LASTNAME”?
 - **SELECT RIGHT('LASTNAME, FIRSTNAME', LEN('LASTNAME, FIRSTNAME') - CHARINDEX(',','LASTNAME, FIRSTNAME')) + ' ' + LEFT('LASTNAME, FIRSTNAME', CHARINDEX(',','LASTNAME, FIRSTNAME')-1);

1. How would you turn a list of names like this: “FIRSTNAME LASTNAME”, to a list like this: “LASTNAME, FIRSTNAME”?
 - **SELECT RIGHT('FISTNAME LASTNAME', LEN('FISTNAME LASTNAME') - CHARINDEX(' ','FISTNAME LASTNAME')) + ', ' +LEFT('FIRSTNAME LASTNAME', CHARINDEX(' ','FIRSTNAME LASTNAME')-1 );**
