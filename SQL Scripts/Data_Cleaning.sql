-- DATA CLEANING

-- Creating Staging Table 
CREATE TABLE netflix_staging
LIKE netflix;

-- Inserting data into netflix_staging table
INSERT netflix_staging
SELECT * FROM netflix;

-- Checking staging table 
SELECT * FROM netflix_staging LIMIT 5;


-- Data cleaning 
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. NULL Values or Blank Values
-- 4. Remove any columns

-- Remove Duplicates
SELECT title
FROM netflix_staging
GROUP BY title
HAVING count(*) > 1;

SELECT * FROM netflix_staging
WHERE title = 'Love in a Puff';

SELECT * FROM netflix_staging
WHERE title = '15-Aug';

SELECT *,
	ROW_NUMBER() OVER(PARTITION BY title, director, country, release_year, rating, duration, listed_in) as row_num
FROM netflix_staging;

WITH duplicate_records AS 
(
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY title, director, country, release_year, rating, duration, listed_in) as row_num
	FROM netflix_staging
)
SELECT * FROM duplicate_records
WHERE row_num > 1;

-- Create table with row_num column 
CREATE TABLE netflix_staging2
LIKE netflix_staging;

-- Adding Row_num column in netflix_staging2
ALTER TABLE netflix_staging2
ADD COLUMN row_num INT;

DESC netflix_staging2;

INSERT netflix_staging2
SELECT *,
		ROW_NUMBER() OVER(PARTITION BY title, director, country, release_year, rating, duration, listed_in) as row_num
FROM netflix_staging;

SELECT * FROM netflix_staging2 LIMIT 5;

-- Removing Duplicate values
SELECT * FROM netflix_staging2 
WHERE row_num > 1;

DELETE FROM netflix_staging2
WHERE row_num > 1;

-- Standardize the Data
-- Stakeholder wants only one name in director column.

SELECT director, substring_index(director, ',', 1)
FROM netflix_staging2; 

UPDATE netflix_staging2
SET director = substring_index(director, ',', 1);

SELECT * FROM netflix_staging2;

-- Updating Date_added Column (Changing data type)
SELECT date_added, 
STR_TO_DATE(date_added, '%m/%d/%Y')
FROM netflix_staging2;

UPDATE netflix_staging2
SET date_added = STR_TO_DATE(date_added, '%m/%d/%Y');

ALTER TABLE netflix_staging2
MODIFY COLUMN date_added DATE;

SELECT * FROM netflix_staging2 LIMIT 5;

ALTER TABLE netflix_staging2
MODIFY COLUMN release_year INT;

ALTER TABLE netflix_staging2
RENAME COLUMN listed_in TO genre;

SELECT genre, substring_index(genre, ',', 1)
FROM netflix_staging2;

UPDATE netflix_staging2
SET genre = substring_index(genre, ',', 1);

-- Handling NULL or Blank values
-- There is no NULL or Blank values in this table.
SELECT * FROM netflix_staging2
ORDER BY 1;

-- Dropping unwanted columns
ALTER TABLE netflix_staging2
DROP COLUMN `index`, 
DROP COLUMN show_id, 
DROP COLUMN row_num;

-- Checking cleaned data 
SELECT * FROM netflix_staging2;

-- Changing Table name 
RENAME TABLE netflix_staging2 TO Netflix_Cleaned_tbl;
