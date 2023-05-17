-- Taking a look at our datasets, to make sure everthing uploaded correctly

SELECT *
FROM `portfolioproject-386322.Covid19.covid_deaths`

SELECT *
FROM `portfolioproject-386322.Covid19.covid_vaccinations`

-- EXPLORING THE DEATHS TABLE

-- Selecting the data we will be using. Noticed there are subtotals of contients in the loaction column, in this case the conctient column is null, so will be adding a WHERE clause to exclude

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
  ORDER BY location

-- Looking at total cases, in relations to popultion, by calculating the percentage that contracted covid

SELECT location, date, population, total_cases, (total_cases/population)*100 AS contraction_percentage
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
ORDER BY 1,2

-- Compairing total cases to total deaths by location

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
ORDER BY 1,2

-- Looking at the highest infection rate per polulation

SELECT location, population, date, MAX(total_cases) AS highest_infection_count, MAX(total_cases/population)*100 AS contraction_percentage
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
GROUP BY location, population, date
ORDER BY contraction_percentage DESC

-- Looking at the highest death count per poplulation

SELECT location, MAX(total_deaths) AS total_death_count
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
GROUP BY location
ORDER BY total_death_count DESC

-- Looking at the death count by continent

SELECT continent, SUM(new_deaths) AS total_death_continent
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
GROUP BY continent
ORDER BY total_death_continent DESC

-- Looking at the collective case and death count in the world, by day

SELECT date, SUM(new_cases) AS global_cases, SUM(new_deaths) AS global_deaths
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null
GROUP BY date
ORDER BY date

-- Calculating the collective cases and deaths count

SELECT SUM(new_cases) AS global_totalcases, SUM(new_deaths) AS global_totaldeaths, SUM(new_deaths)/SUM(new_cases)*100 AS global_deathpercentage
FROM `portfolioproject-386322.Covid19.covid_deaths`
WHERE continent is not null



-- JOINING THE DEATHS AND VACCINATION TABLES

-- Looking at vaccinations count compaired to population

SELECT d.date, d.location, d.population, v.new_vaccinations 
FROM `portfolioproject-386322.Covid19.covid_deaths` d
JOIN `portfolioproject-386322.Covid19.covid_vaccinations` v
  ON d.location = v.location
  AND d.date = v.date
WHERE d.continent is not null
ORDER BY d.date DESC