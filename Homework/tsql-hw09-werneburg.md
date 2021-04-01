# TSQL Homework 09

---
Dakin Werneburg  
3/24/2021

---
## 1. What is a temporal table?
- A system-versioned temporal table is a type of user table designed to keep a full history of data changes to allow easy point in time analysis.

## 2. Under what circumstances would you use a temporal table? Temporal tables are in widespread use in certain kinds of businesses.
> Auditing all data changes and performing data forensics when necessary

> Reconstructing state of the data as of any time in the past

> Calculating trends over time

> Maintaining a slowly changing dimension for decision support applications

> Recovering from accidental data changes and application errors

## 3. What are the semantics of a temporal table? There are seven of them.
> A primary key 

> Two columns defined as DATETIME2 with any precision, which are non-nullable and represent the start and end of the row’s validity period in the UTC time zone 

> A start column that should be marked with the option GENERATED ALWAYS AS ROW START 

> An end column that should be marked with the option GENERATED ALWAYS AS ROW END

> A designation of the period columns with the option PERIOD FOR SYSTEM_TIME (\<startcol\>, \<endcol\>) 

> The table option SYSTEM_VERSIONING, which should be set to ON 

> A linked history table (which SQL Server can create for you) to hold the past states of modified rows

## 4. How do you search a history table?
- If you want to query a past state of the data, you still query the current table, but you add a clause called FOR SYSTEM_TIME

## 5. How do you modify a history table?
- Just like you would with a regular table except there is no support for TRUNCATE

## 6. How do you delete data from a history table? Why would you want to delete data from a history table?
- Need to turn System_Versioning OFF then delete as normally would, then turn System_Versioning back on.  You would delete data to purge from some cut-off date for space savings or to remove incorrect data.

## 7. How do you search a history table?
- If you want to query a past state of the data, you still query the current table, but you add a clause called FOR SYSTEM_TIME

## 8. How do you query all data from both a history File and the current data?
- Use ALL when you need to query current and historical data without any restrictions

## 9. How do you drop a temporal table?
- To Drop a Temporal Table you first need to turn System_Versioning OFF. Then Delete your required temporal table.


