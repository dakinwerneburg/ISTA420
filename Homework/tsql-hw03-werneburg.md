# TSQL Homework 02c

---
Dakin Werneburg  
1/24/2021

---

1. List the date/time types in T-SQL.
> - **time**
> - **date**
> - **smalldatetime**
> - **datetime**
> - **datetime2**
> - **datetimeoffset**

1. How do you express a date/time literal in T-SQL?
> - **T-SQL doesn’t provide the means to express a date and time literal, but express data and times  using character-string literals and coverting them to date time data types instead**

1. What is the setting DATEFORMAT used for?
> - **Determins how SQL Server interprets the literals you enter when they are converted from character-string type to a date time type. i.e (d,m,y) us_english**

1. Write a T-SQL snippet changing the date format to German. Read the documentation on how to do this.
> - **SET LANGUAGE German;**

1. What is the difference between CAST(), CONVERT(), and PARSE()?
> - **CAST is part of the ANSI-SQL specification and is standard providing my compatability, wheras CONVERT AND PARSE are not; CONVERT() supports the style argument that allow formatting, where as CAST and PARSE don't.  PARSE requires the .NET framework where as CAST and CONVERT do not.  PARSE also accepts only strings and converts to datetime and number formats only where as CAST and CONVERT accept any input and can convert between any data type.**

1. What function returns the current date? This is very useful in a table that maintains a log of events, such as user logins.
> - **There are six functions to retrieve the current date and time: GETDATE, CURRENT_TIMESTAMP, GETUTCDATE, SYSDATETIME, SYSUTCDATETIME,and SYSDATETIMEOFFSET, but GETDATE is normally used.

1. How do you add one day to the current date? Add one week? Add one month? Add one year?
> - **Utilizing the DATEADD function with the specified parameters.  
>> - SELECT DATEADD(day,1,GETDATE());
>> - SELECT DATEADD(week,1,GETDATE());
>> - SELECT DATEADD(month,1,GETDATE());
>> - SELECT DATEADD(year,1,GETDATE());

1. Write a SQL snippet to return the number of years between your birth date and today’s date.
> - **SELECT DATEDIFF(year,'19770520',GETDATE());

1. How do you check a string literal to see if it represents a valid date?
> - **Using the ISDATE() function.

1. What does EOMONTH() do? Give an example of why this might be very useful.
> - **EOMONTH() fucntion returns the last day of the month.  This couuld be used to calculate maturity dates or due dates**

1. Payments are due exactly 30 days from the date of the last function. Write a select query that calculates the date of the next payment. Pretend we want to update a column in a database that contains the date of the next payment. We will do this when we write UPDATE queries.
> - **SELECT DATEADD(day,30,'paymentdate' AS "Due Date");  // paymentdate uknown

1. Suppose your son or daughter wants to run a query every day that tells them the number of days until their 16th birthday. Write a select query that does this.
> -  **SELECT DATEDIFF(day,GETDATE(),'20210216');  //unknown month of 16th birthday**
