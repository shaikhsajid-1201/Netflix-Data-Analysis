-- NETFLIX DATA ANALYSIS

SELECT * 
FROM netflix_cleaned_tbl
LIMIT 5;

-- Total Content
SELECT COUNT(*) AS Total_content
FROM netflix_cleaned_tbl;

-- Content Type Distribution: 
-- What is the distribution of content types (Movies vs. TV Shows) on Netflix?
SELECT `type`, count(*) AS content_distribution
FROM netflix_cleaned_tbl
GROUP BY `type`;

-- Top 10 Countries by Content Production: 
-- Which countries produce the most content (both Movies and TV Shows) on Netflix?
SELECT country, COUNT(*) AS content_production
FROM netflix_cleaned_tbl
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

-- Content Added Over Time: 
-- How has the number of movies and TV shows added to Netflix changed over the years?
WITH Commulative_Total AS (
	SELECT YEAR(date_added) AS `year`, COUNT(*) AS total_content
	FROM netflix_cleaned_tbl
	GROUP BY `year`
	ORDER BY 1
)
SELECT `year`, total_content,
	SUM(total_content) OVER(ORDER BY `year`) AS total_content_over_year
FROM Commulative_Total;

-- Top Directors: Who are the top 5 most frequent directors on Netflix?
SELECT director, COUNT(*) AS total_content
FROM netflix_cleaned_tbl
GROUP BY director
HAVING director != 'Not Given'
ORDER BY total_content DESC
LIMIT 5;

-- Yearly Releases: What is the trend in the number of movies and TV shows released over the years?
WITH released_over_the_years AS (
	SELECT release_year, `type`, SUM(COUNT(*)) OVER(ORDER BY release_year) AS total_released
	FROM netflix_cleaned_tbl
	GROUP BY release_year, `type`
)
SELECT * FROM released_over_the_years;

-- Genre Popularity: What are the most common genres listed for Netflix content?
SELECT genre, COUNT(*) AS total_content
FROM netflix_cleaned_tbl
GROUP BY genre
ORDER BY 2 DESC;

-- Content per Country: Which countries have produced the most movies and TV shows in each genre?
WITH Content_per_country AS (
	SELECT country, genre, COUNT(*) AS total_content
	FROM netflix_cleaned_tbl
    WHERE country IS NOT NULL AND genre IS NOT NULL
	GROUP BY country, genre
),
Rankedcountries AS (
	SELECT country, genre, total_content,
		ROW_NUMBER() OVER(PARTITION BY genre ORDER BY total_content DESC) AS country_rank
	FROM Content_per_country
)
SELECT country, genre, total_content
FROM RankedCountries
WHERE country_rank = 1
ORDER BY genre, total_content DESC;


-- Rating Distribution: What is the distribution of ratings (e.g., TV-MA, PG-13, etc.) across Netflix content?
SELECT rating, COUNT(*) AS total_content
FROM netflix_cleaned_tbl
GROUP BY rating
ORDER BY 2 DESC;

-- Average Duration by Type: What is the average duration for movies and TV shows on Netflix?
WITH Average_duration AS (
	SELECT `type`, AVG(duration) AS avg_duration,
	CASE
		WHEN `type` = 'Movie' THEN 'min'
        WHEN `type` = 'TV Show' THEN 'season'
        END AS details
	FROM netflix_cleaned_tbl
	GROUP BY `type`
)
SELECT `type`, ROUND(avg_duration) AS avg_duration, details
FROM Average_duration;

-- Most Active Year for New Content: In which year was the highest number of content added to Netflix?
SELECT YEAR(date_added) AS `year`, COUNT(*) AS total_content
FROM netflix_cleaned_tbl
GROUP BY `year`
ORDER BY total_content DESC 
LIMIT 1;

-- Top 5 Genres by Country: What are the top 5 most common genres for each country?
WITH genrecount AS (
	SELECT Country, Genre, COUNT(*) AS genre_count
	FROM netflix_cleaned_tbl
	GROUP BY Country, Genre
), 
rankedgenre AS (
	SELECT country, genre, genre_count,
		ROW_NUMBER() OVER(PARTITION BY country ORDER BY genre_count DESC) AS genre_rank
	FROM genrecount
)
SELECT country, genre, genre_count
FROM rankedgenre
WHERE genre_rank <= 5
ORDER BY country, genre_count DESC;

-- Most Common Directors by Genre: Which directors are associated with specific genres? Are there any directors specialized in particular genres?
WITH directorgenrecount AS (
	SELECT director, genre, count(*) AS director_count
	FROM netflix_cleaned_tbl
	WHERE director <> 'Not Given' AND director IS NOT NULL
	GROUP BY director, genre
),
RankedDirector AS (
	SELECT director, genre, director_count,
		ROW_NUMBER() OVER(PARTITION BY genre ORDER BY director_count DESC) AS director_rank
	FROM directorgenrecount
)
SELECT Genre, Director, director_count
FROM RankedDirector
WHERE director_rank = 1
ORDER BY Genre, director_count DESC;

-- Oldest Content by Country: What are the oldest movies or TV shows from each country?
WITH oldest_content_per_country AS (
	SELECT country, MIN(release_year) AS oldest_year
	FROM netflix_cleaned_tbl
	GROUP BY country
)
SELECT n.country, n.title, n.type, n.release_year
FROM netflix_cleaned_tbl n
JOIN oldest_content_per_country o
	ON n.country = o.country AND o.oldest_year = n.release_year
ORDER BY n.country, n.release_year;

-- Country-wise Content Added by Year: How many movies or TV shows were added from each country per year?
WITH countryWise_content_added AS(
	SELECT country, year(date_added) as `year`, count(*) as total_content
	FROM netflix_cleaned_tbl
	GROUP BY country, year
	ORDER BY country
),
Rolling_Content AS (
	SELECT country, `year`, total_content,
		SUM(total_content) OVER(PARTITION BY country ORDER BY `year`) AS rollingContent_perYear
	FROM countryWise_content_added
)
SELECT country, `year`, total_content, rollingContent_perYear
FROM Rolling_Content;