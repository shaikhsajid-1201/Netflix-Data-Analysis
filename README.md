# 📊 Netflix Data Analysis Project

## Introduction

This project presents an exploratory data analysis (EDA) of Netflix content using SQL. By examining Netflix's extensive content library, we aim to uncover insights into content distribution, country-wise production, genre popularity, rating distribution, and other trends. This analysis provides valuable recommendations to enhance Netflix’s content strategy based on observed patterns and viewer preferences.

---

## Table of Contents
- [Project Overview](#project-overview)
- [Data](#data)
- [Analysis](#analysis)
- [Key Insights](#key-insights)
- [Recommendations](#recommendations)
- [Requirements](#requirements)
- [Usage](#usage)

---

## Project Overview

Netflix has a vast catalog of movies and TV shows across various genres and ratings. This project aims to analyze the distribution of content, understand genre popularity by country, evaluate the frequency of directors across genres, examine rating distributions, and identify trends in content additions over the years.

## Data

The analysis uses a cleaned version of Netflix’s content data, structured with the following key columns:
- `Type`: Whether the content is a Movie or TV Show
- `Title`: Title of the content
- `Director`: Director’s name
- `Country`: Country of origin
- `Date_Added`: Date when content was added to Netflix
- `Release_Year`: Year the content was originally released
- `Rating`: Audience rating (e.g., TV-MA, PG-13)
- `Duration`: Duration (minutes for Movies, seasons for TV Shows)
- `Genre`: Genres or categories associated with the content

## Analysis

Key analysis queries include:
1. **Content Type Distribution**: Movie vs. TV show count
2. **Top Countries by Content Production**: Which countries produce the most content
3. **Content Added Over Time**: Trends in content added yearly
4. **Top Directors**: Most frequent directors
5. **Yearly Releases**: Trends in annual releases by content type
6. **Genre Popularity**: Most common genres
7. **Rating Distribution**: Distribution of audience ratings
8. **Average Duration by Type**: Average movie length and TV show season count
9. **Most Active Year for New Content**: Peak year for content additions
10. **Oldest Content by Country**: Earliest content available by country

## Key Insights

- **Content Type**: The library is predominantly made up of movies, with TV shows being a smaller share.
- **Top-Producing Countries**: The U.S., India, and the UK rank among the top producers.
- **Genres**: Drama, Comedy, and Documentary are the most common genres.
- **Ratings**: The majority of content is rated for mature audiences (e.g., TV-MA).
- **Release Trends**: New content additions peaked in certain years, indicating high content production efforts.

## Recommendations

1. **Localize Genre Availability**: Tailor genre offerings to align with country-specific viewer interests.
2. **Engage Top Directors**: Partner with popular directors to attract genre-loyal viewers.
3. **Diversify Content Ratings**: Increase family-friendly content to attract broader demographics.
4. **Expand in Emerging Markets**: Increase production partnerships in high-growth regions.

## Requirements

- **SQL Database**: MySQL or similar
- **SQL Client**: Workbench, DBeaver, or a similar tool for executing queries
- **Data**: The `netflix_cleaned_tbl` table containing Netflix content data

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/username/netflix-data-analysis.git
    ```
2. Import the data into your SQL database.
3. Run the SQL queries in `netflix_data_analysis.sql` to generate insights.

---
