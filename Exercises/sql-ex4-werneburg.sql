/*------------------------
-- TSQL Exercise 04
-- Name: Dakin T. Werneburg
-- File: sql-ex4-werneburg.sql
-- Date: 2/5/2021

use TSQLV4
go

/* 1. Use a derived table to build a query that returns the number of distinct products per year that each
customer ordered. Use internal aliasing. Use a variable to set the customer number. For example, if
the customer ID is 1234, the query should report the number of distinct products ordered by customer
1234 for the years 2014, 2015, and 2016.
*/

DECLARE @customer AS INT = 3;

SELECT prod.customer_number, 
       count(distinct prod.productid) num_products, 
	   prod.yeardate
FROM (
	SELECT 
		o.orderid, 
		o.custid AS customer_number, 
		year(o.orderdate) as yeardate,
		od.productid
	FROM Sales.Orders o 
		JOIN Sales.Orderdetails od 
		   on o.orderid = od.orderid
	WHERE year(orderdate) IN (2014,2015,2016)
) prod
WHERE prod.customer_number = @customer
group by prod.yeardate, 
         prod.customer_number;


/* 2. Use multiple common table expressions to build a query that returns the number of distinct products
per year that each country's customers ordered. Use external aliasing. Use a variable to set the country
name. For example, if the country name is France, the query should report the number of distinct
products ordered by French customers for the years 2014, 2015, and 2016.
*/

DECLARE @country AS nvarchar(15) = 'France';
WITH cte1(orderid, country, salesyear) AS 
(
  SELECT orderid, 
		shipcountry, 
		year(orderdate) 
  FROM sales.orders
  WHERE year(orderdate) IN (2014,2015,2016)
),
cte2(orderid, productid) AS
(
  SELECT orderid, 
         productid
  FROM sales.orderdetails
)

SELECT country,
       salesyear, 
	   COUNT(DISTINCT(productid)) AS num_prod
FROM cte1
   INNER JOIN cte2
     ON cte1.orderid = cte2.orderid
WHERE country = @country
GROUP BY country,salesyear;




/* 3. Create a view that shows, for each year, the total dollar amount spent by customers in each country
for all the years in the database.*/

DROP VIEW IF EXISTS Sales.YearlyByCountry;
GO
CREATE VIEW Sales.YearlyByCountry AS

SELECT O.shipcountry, 
       YEAR(O.orderdate) AS orderyear, 
	   FORMAT(SUM(OD.qty * OD.unitprice), 'c','en-au') AS yearly_sales
FROM Sales.Orders AS O 
   INNER JOIN Sales.OrderDetails AS OD 
      ON OD.orderid = O.orderid
GROUP BY YEAR(O.orderdate), 
         O.shipcountry;
GO
SELECT * FROM Sales.YearlyByCountry;


/* 4. Create an inline table valued function that accepts as a parameter a country name and returns a table
with the distinct products ordered by customers from that country. Products are to be identied by
both product ID and product name.
*/

DROP FUNCTION IF EXISTS sales.getprodcountry;
GO
CREATE FUNCTION sales.getprodcountry
(@country AS nvarchar(15)) RETURNS TABLE
AS
RETURN
SELECT DISTINCT o.shipcountry,
                p.productid, 
				p.productname
FROM sales.orders AS o 
   INNER JOIN sales.orderdetails AS od 
      ON od.orderid = o.orderid
   INNER JOIN production.products p
      ON od.productid = p.productid
WHERE o.shipcountry = @country;
GO

SELECT pc.shipcountry, 
       pc.productid, 
	   pc.productname
FROM sales.getprodcountry('Germany') as pc
ORDER BY pc.productid;



/* 5. Use the CROSS APPLY operator to create a query showing the top three products shipped to customers
in each country. Your report should contain the name of the country, the product id, the product name,
and the number of products shipped to customers in that country.*/

SELECT DISTINCT c.country, 
				T1.productid, 
				T1.productname, 
				T1.num_prod
FROM sales.customers c
CROSS APPLY (
	SELECT 
	    TOP(3)
		o.shipcountry, 
		od.productid,
		p.productname, 
		SUM(od.qty) num_prod 
	FROM sales.orders o 
	  INNER JOIN sales.orderdetails od 
	    on o.orderid=od.orderid 
	  INNER JOIN production.products p 
	    on od.productid=p.productid 
	WHERE c.country = o.shipcountry
	GROUP BY o.shipcountry, 
			 od.productid, 
			 p.productname 
	ORDER BY o.shipcountry,
	         num_prod desc
)T1
ORDER BY c.country, 
         T1.num_prod desc, 
		 T1.productid;


------------------------*/
customer_number num_products    yeardate
--------------- ------------ -----------
              3            1        2014
              3           13        2015
              3            2        2016

(3 rows affected)

country           salesyear    num_prod
--------------- ----------- -----------
France                 2014          28
France                 2015          46
France                 2016          39

(3 rows affected)

shipcountry       orderyear yearly_sales
--------------- ----------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Argentina              2015 $1,816.60
Argentina              2016 $6,302.50
Austria                2014 $29,352.00
Austria                2015 $63,151.98
Austria                2016 $46,992.65
Belgium                2014 $6,438.80
Belgium                2015 $12,087.10
Belgium                2016 $16,609.08
Brazil                 2014 $23,849.30
Brazil                 2015 $44,550.51
Brazil                 2016 $46,568.67
Canada                 2014 $7,949.60
Canada                 2015 $34,970.10
Canada                 2016 $12,414.40
Denmark                2014 $3,011.80
Denmark                2015 $27,192.65
Denmark                2016 $4,577.80
Finland                2014 $3,210.80
Finland                2015 $14,280.65
Finland                2016 $2,287.00
France                 2014 $17,629.90
France                 2015 $47,905.80
France                 2016 $19,963.06
Germany                2014 $37,804.60
Germany                2015 $124,170.33
Germany                2016 $82,665.70
Ireland                2014 $10,562.00
Ireland                2015 $23,959.05
Ireland                2016 $22,796.34
Italy                  2014 $1,004.20
Italy                  2015 $8,448.95
Italy                  2016 $7,252.00
Mexico                 2014 $4,687.90
Mexico                 2015 $14,840.65
Mexico                 2016 $4,544.90
Norway                 2014 $1,058.40
Norway                 2015 $700.00
Norway                 2016 $3,976.75
Poland                 2014 $459.00
Poland                 2015 $1,207.85
Poland                 2016 $1,865.10
Portugal               2014 $2,482.00
Portugal               2015 $7,284.75
Portugal               2016 $2,701.90
Spain                  2014 $3,100.40
Spain                  2015 $8,053.05
Spain                  2016 $8,278.44
Sweden                 2014 $7,414.60
Sweden                 2015 $28,024.70
Sweden                 2016 $24,084.40
Switzerland            2014 $4,289.70
Switzerland            2015 $18,702.50
Switzerland            2016 $9,927.30
UK                     2014 $9,654.00
UK                     2015 $27,832.60
UK                     2016 $23,129.91
USA                    2014 $41,907.80
USA                    2015 $121,037.70
USA                    2016 $100,621.48
Venezuela              2014 $10,431.70
Venezuela              2015 $28,171.23
Venezuela              2016 $22,211.96

(62 rows affected)

shipcountry       productid productname
--------------- ----------- ----------------------------------------
Germany                   1 Product HHYDP
Germany                   2 Product RECZE
Germany                   3 Product IMEHJ
Germany                   4 Product KSBRM
Germany                   6 Product VAIIV
Germany                   7 Product HMLNI
Germany                   8 Product WVJFP
Germany                   9 Product AOZBW
Germany                  10 Product YHXGE
Germany                  11 Product QMVUN
Germany                  12 Product OSFNS
Germany                  13 Product POXFU
Germany                  14 Product PWCJB
Germany                  15 Product KSZOI
Germany                  16 Product PAFRH
Germany                  17 Product BLCAX
Germany                  18 Product CKEDC
Germany                  19 Product XKXDO
Germany                  20 Product QHFFP
Germany                  21 Product VJZZH
Germany                  22 Product CPHFY
Germany                  23 Product JLUDZ
Germany                  24 Product QOGNU
Germany                  25 Product LYLNI
Germany                  26 Product HLGZA
Germany                  27 Product SMIOH
Germany                  28 Product OFBNT
Germany                  29 Product VJXYN
Germany                  30 Product LYERX
Germany                  31 Product XWOXC
Germany                  32 Product NUNAW
Germany                  33 Product ASTMN
Germany                  34 Product SWNJY
Germany                  35 Product NEVTJ
Germany                  36 Product GMKIJ
Germany                  37 Product EVFFA
Germany                  38 Product QDOMO
Germany                  39 Product LSOFL
Germany                  40 Product YZIXQ
Germany                  41 Product TTEEX
Germany                  42 Product RJVNM
Germany                  43 Product ZZZHR
Germany                  44 Product VJIEO
Germany                  45 Product AQOKR
Germany                  46 Product CBRRL
Germany                  47 Product EZZPR
Germany                  49 Product FPYPN
Germany                  51 Product APITJ
Germany                  52 Product QSRXF
Germany                  53 Product BKGEA
Germany                  54 Product QAQRL
Germany                  55 Product YYWRT
Germany                  56 Product VKCMF
Germany                  57 Product OVLQI
Germany                  58 Product ACRVI
Germany                  59 Product UKXRI
Germany                  60 Product WHBYK
Germany                  61 Product XYZPE
Germany                  62 Product WUXYK
Germany                  63 Product ICKNK
Germany                  64 Product HCQDE
Germany                  65 Product XYWBZ
Germany                  67 Product XLXQF
Germany                  68 Product TBTBL
Germany                  69 Product COAXA
Germany                  70 Product TOONT
Germany                  71 Product MYMOI
Germany                  72 Product GEEOO
Germany                  73 Product WEUJZ
Germany                  74 Product BKAZJ
Germany                  75 Product BWRLG
Germany                  76 Product JYGFE
Germany                  77 Product LUNZZ

(73 rows affected)

country           productid productname                                 num_prod
--------------- ----------- ---------------------------------------- -----------
Argentina                11 Product QMVUN                                     30
Argentina                20 Product QHFFP                                     20
Argentina                40 Product YZIXQ                                     20
Austria                  24 Product QOGNU                                    283
Austria                  64 Product HCQDE                                    224
Austria                  61 Product XYZPE                                    206
Belgium                  59 Product UKXRI                                     90
Belgium                  42 Product RJVNM                                     82
Belgium                  71 Product MYMOI                                     80
Brazil                   60 Product WHBYK                                    212
Brazil                   19 Product XKXDO                                    171
Brazil                   77 Product LUNZZ                                    150
Canada                   60 Product WHBYK                                    145
Canada                   62 Product WUXYK                                    132
Canada                   17 Product BLCAX                                    126
Denmark                  77 Product LUNZZ                                    101
Denmark                  68 Product TBTBL                                     96
Denmark                  40 Product YZIXQ                                     70
Finland                  71 Product MYMOI                                    100
Finland                  53 Product BKGEA                                     75
Finland                  56 Product VKCMF                                     50
France                   62 Product WUXYK                                    174
France                   18 Product CKEDC                                    154
France                    7 Product HMLNI                                    124
Germany                  60 Product WHBYK                                    405
Germany                  40 Product YZIXQ                                    345
Germany                  59 Product UKXRI                                    337
Ireland                  29 Product VJXYN                                    150
Ireland                  58 Product ACRVI                                    129
Ireland                  59 Product UKXRI                                    112
Italy                    72 Product GEEOO                                     70
Italy                    49 Product FPYPN                                     58
Italy                    24 Product QOGNU                                     50
Mexico                   11 Product QMVUN                                    101
Mexico                   33 Product ASTMN                                     68
Mexico                   44 Product VJIEO                                     51
Norway                   24 Product QOGNU                                     23
Norway                   77 Product LUNZZ                                     18
Norway                   16 Product PAFRH                                     15
Poland                   31 Product XWOXC                                     30
Poland                   75 Product BWRLG                                     30
Poland                   61 Product XYZPE                                     22
Portugal                 56 Product VKCMF                                     70
Portugal                 44 Product VJIEO                                     55
Portugal                 65 Product XYWBZ                                     55
Spain                    17 Product BLCAX                                     60
Spain                    65 Product XYWBZ                                     56
Spain                    75 Product BWRLG                                     50
Sweden                   47 Product EZZPR                                    121
Sweden                   41 Product TTEEX                                    112
Sweden                   75 Product BWRLG                                    107
Switzerland              69 Product COAXA                                     96
Switzerland              56 Product VKCMF                                     72
Switzerland              53 Product BKGEA                                     70
UK                       31 Product XWOXC                                    185
UK                       60 Product WHBYK                                    166
UK                        7 Product HMLNI                                    134
USA                      56 Product VKCMF                                    386
USA                      17 Product BLCAX                                    361
USA                      62 Product WUXYK                                    356
Venezuela                70 Product TOONT                                    137
Venezuela                59 Product UKXRI                                    135
Venezuela                75 Product BWRLG                                    116

(63 rows affected)


Completion time: 2021-02-05T15:25:09.4060186-05:00
