

USE TSQLV4;

--1. Create an appropriate table schema.
SELECT '------------------Question #1 TABLE CREATED Output------------------------';

DROP TABLE IF EXISTS dbo.Presidents;
GO
CREATE TABLE dbo.Presidents
(
	id varchar(30),
	lname varchar(30) not null,
	fname varchar(30) not null,
	mname varchar(30),
	orderOfPres varchar(30) not null,
	dob varchar(30) not null,
	death varchar(30),
	birthTown varchar(30),
	birthState varchar(30),
	homeState varchar (30),
	party varchar(50),
	dateTookOffice varchar(30),
	dateLeftOffice varchar(30),
	assassinatedAttempt varchar(30),
	assassinated varchar(30),
	religion varchar(30),
	imgPath varchar(255)
);
GO








--2. Insert the CSV data into the table you just created.
SELECT '------------------Question #2 IMPORTED CSV INTO TABLE Output------------------------';

BULK INSERT dbo.Presidents FROM 'C:\Users\Dakin\MSSA2021\Database\presidents.csv'
WITH
(
	DATAFILETYPE = 'char',
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);
GO







--3. Delete the column that contains the path to the images.
SELECT '------------------Question #3 DROP IMAGE PATH COLUMN Output------------------------';

ALTER TABLE dbo.Presidents
DROP COLUMN imgPath;
GO





/*4. Delete the first record from your table using the output clause. This is the header.
	> You may combine the following two steps.
	> Alter the presidents table by adding an integer column, beginning at 1 and ending at 44, that is NOT NULL and UNIQUE.
	>Alter the presidents table by adding the column you created as a primary key column with a new constraint.*/
SELECT '------------------Question #4  DROP ORIGINAL ID COLUMN AND ADD AGAIN Output------------------------';

DELETE FROM dbo.Presidents output deleted.* WHERE id = 'ID';

ALTER TABLE dbo.Presidents
DROP COLUMN IF EXISTS id;
GO

ALTER TABLE dbo.Presidents
ADD id int not null identity(1,1);
GO

ALTER TABLE dbo.Presidents
ADD CONSTRAINT pk_id PRIMARY KEY(id);
GO






--5. Bring the data up to date by updating the last row. Use the output clause.
SELECT '------------------Question #5 UPDATED LAST ROW (OBAMA) Output------------------------';

UPDATE dbo.presidents
SET dateleftoffice = '1/20/2017',
	assassinatedAttempt = 'False',
	assassinated = 'False'
OUTPUT
	inserted.*
where id = 44;
GO






--6. Bring the data up to date by adding a new row. Use the output clause.
SELECT '------------------Question #6  INSERTED TRUMP AND BIDEN TO TABLE Output------------------------';

INSERT INTO dbo.Presidents
OUTPUT inserted.*
VALUES('Trump', 'Donald', 'John', '45', '6/14/1946',' ','Queens NYC', 'New York', 'Florida', 'Republican', '1/20/2017',
'1/20/2021', 'False', 'False', 'Christian');

INSERT INTO dbo.Presidents
OUTPUT inserted.*
VALUES('Biden', 'Joseph', 'Robinette', '46', '11/20/1942',' ','Scranton', 'Pennsylvania', 'Delaware', 'Democrat', '1/20/2021',
' ', ' ', ' ', 'Christian');







--7. How many presidents from each state belonged to the various political parties? Aggregate by party and state. Note that this will in effect be a pivot table.
SELECT '------------------Question #7 NUMBER OF PRESIDENTS BY RELIGION/PARTY Output------------------------';

SELECT party,Virginia,Massachusetts,Tennessee,[New York],
       Ohio,Louisiana,[New Hampshire],Pennsylvania,Illinois,
	   Indiana,[New Jersey],Iowa,Missouri,Texas,
	   California,Michigan,Georgia, Arkansas
FROM 
	(
		SELECT party,homeState,lname 
		FROM dbo.Presidents
	) as D
PIVOT
(  
	COUNT(lname) 
	FOR homeState IN (
					Virginia,Massachusetts,Tennessee,[New York],
					Ohio,Louisiana,[New Hampshire],Pennsylvania,Illinois,
					Indiana,[New Jersey],Iowa,Missouri,Texas,
					California,Michigan,Georgia, Arkansas)
) as state;






-- 8. Create a report showing the number of days each president was in office.
SELECT '------------------Question #8 NUMBER OF DAYS PRESIDENT IN OFFICE Output------------------------';
select lname, DATEDIFF (day, dateTookOffice, dateLeftOffice) as numberOfDays from dbo.Presidents where dateLeftOffice != ' ' order by numberOfDays desc;





--9. Create a report showing the age (in years) of each present when he took office.
SELECT '------------------Question #9 AGE PRESIDENT TOOK OFFICE Output------------------------';
select lname,fname, datediff(year, dob, datetookoffice) as yearsold from dbo.presidents
order by yearsold desc;




--10. See if there is any correlation between a president's party and reported religion, or lack of reported religion. Page 1,
SELECT '------------------Question #10 NUMBER OF PRESIDENTS BY PARTY/RELIGION Output------------------------';
SELECT party, Baptist, Christian, Congregationalist, [Deist/Episcopalian], [Disciples of Christ], [Dutch Reformed], Episcopalian,
Methodist, Presbyterian, [Presbyterian/Methodist], Quaker, [Roman Catholic],
Unitarian, No_Religion
FROM (select party,ISNULL(religion,'No_Religion') as religion,lname from dbo.Presidents) as R
 PIVOT(
    count(lname) for religion in (Baptist, Christian,Congregationalist, [Deist/Episcopalian], [Disciples of Christ], [Dutch Reformed], Episcopalian,
Methodist, Presbyterian, [Presbyterian/Methodist], Quaker, [Roman Catholic], Unitarian, No_Religion)
)
as religion;