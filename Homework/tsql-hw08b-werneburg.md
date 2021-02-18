# TSQL Homework 08b

---
Dakin Werneburg  
2/16/2021

1. The sales tax rate for a state just changed. How would you update the state sales tax table to reflect the changes? Assume that this table has an ID column, an RATE column, and a STATE column.
- **UPDATE dbo.statesalestax SET rate = .008 where STATE = 'NY'**

2. The Revenue Division has requested that you provide a report on what the actual sales taxes would have been for all orders in the past year, assuming the retroactivity of the new sales tax rate. How would you calculate this?

- **SELECT rate * unitprice * qty from dbo.Sales.Orders where orderdate SELECT > DATEADD(year,-1,GETDATE())**

3. Explain how the proprietary assignment update command works.
- **ASSIGNMENT UPDATE, updates data in the table and assigns values to variables at the same time.**

4. What is one very important purpose of the MERGE SQL statement? What is ETL (not in book)?
- **To add larger number of records to an already existing table.  ETL or Extraction, Tranformation, and Loading is a process where it first extracts the data from different sources, then it transforms or performs some calculation or operation, then it loads the data.**

5. What are the semantics of MERGE?

```sql
		MERGE <target_table> [AS TARGET]
		USING <table_source> [AS SOURCE]
		ON <search_condition>
		[WHEN MATCHED 
			THEN <merge_matched> ]
		[WHEN NOT MATCHED [BY TARGET]
			THEN <merge_not_matched> ]
		[WHEN NOT MATCHED BY SOURCE
			THEN <merge_matched> ];
```
6. Write a typical INSERT OUTPUT statement.


```sql
		INSERT INTO dbo.Sales.Orders (col1,col2,col3) 
		OUTPUT inserted.* 
		SELECT city,state,country where country = 'USA';
```

7. Write a typical UPDATE OUTPUT statement.

```sql
		UPDATE <target_table> 
		SET <target_column(s) <condition>
		OUTPUT inserted.<column(s) or *>, deleted.<column(s) or *>
		WHERE <targe_column> <condition>;
```
		

8. Write a typical DELETE OUTPUT statement.

```sql
	DELETE FROM dbo.Sales.Orders
	OUTPUT deleted.*
	WHERE orderid=1;
```	
9. Write a typical MERGE OUTPUT statement.

```sql
	MERGE INTO <target_table> 
	USING <source_table>
		ON <Condition>
	WHEN MATCHED THEN
		UPDATE SET
			<target_column(s)> = <source_column(s)>
	WHEN NOT MATCHED THEN
		INSERT <column(s)>
		VALUES <col-values>
	OUTPUT $action inserted.<column/*>, deleted.<column/*>;
```
10. What is nested DML?
- **DML is nested Data Minipulation Language and is used to directly insert into the final target table only the subset of rows you need from the full set of modified rows.**

11. (Not in book) Write a query adding a new column to a table named PERSON. The new column name is DayOfBirth and the data type is string. Use ANSI SQL syntax.

```sql
	ALTER TABLE dbo.Person
	ADD DayOfBirth varchar(50);
	go
```

12. (Not in book) Write a query adding a DEFAULT constraint to the column DayOfBirth. The constraint is that the value matches one of SUN, MON, TUE, WED, THU, FRI, or SAT.

```sql
	ALTER TABLE dbo.Person
	WITH CHECK
	ADD CONSTRAINT DF_Person_DayOfBirth
	DEFAULT 'FRI' FOR DayOfBirth
	ADD CONSTRAINT CK_DayOfBirth
	CHECK(DayOfBirth IN ('MON','TUE','WED','THUR','FRI','SAT','SUN')
```

13. (Not in book) Write a query adding a foreign key to the column DayOfBirth. The referenced table is named WEEK and the referenced column is ValidDay.

```sql
	ALTER TABLE dbo.Week
	ADD FOREIGN KEY (DayOfBirth) REFERENCES(ValidDay)

```
