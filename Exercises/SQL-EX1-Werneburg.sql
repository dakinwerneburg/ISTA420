.echo on
.headers on

--Name:  Dakin Werneburg
--Assignment:  SQL Programming Exercise 01
--Date:  January 71, 2021
--File:  SQL-Ex1-Werneburg.sql


DROP TABLE IF EXISTS movies;

CREATE TABLE movies(                                                     
	movieId INT PRIMARY KEY,                                            
	releaseYear INT CHECK ( releaseYear > 1900 AND releaseYear < 2021),                        
	gross NUMERIC,
	genre VARCHAR CHECK (genre IN (
		'Comedy','Horror', 'Sci-Fi','Action','Drama',
		'Thriller','Fantasy','Romance','Western')),                      
	title VARCHAR
);


INSERT INTO movies VALUES (1,1985,388.8,'Sci-Fi','Back to the Future');
INSERT INTO movies VALUES (2,1988,139.8,'Action','Die Hard');
INSERT INTO movies VALUES (3,1999,235.5,'Comedy','American Pie');
INSERT INTO movies VALUES (4,2007,709.7,'Sci-Fi','Transformers');
INSERT INTO movies VALUES (5,1972,246,'Drama','Godfather');



SELECT * FROM movies;
SELECT * FROM movies where (releaseYear > 1980 AND releaseYear < 1990);