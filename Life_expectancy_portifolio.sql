SELECT *
FROM PORTIFOLIO..LifeExpectancy
-- Data Cleaning 
-- Renaming columns 

sp_rename 'PORTIFOLIO..LifeExpectancy.F1', 'Continent', 'COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.F2', 'Country', 'COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.F3', 'Year','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at birth (years)', 'LE_at_birth_both','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at birth (years)1', 'LE_at_birth_male','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at birth (years)2', 'LE_at_birth_female','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at age 60 (years)', 'LE_at_60_both','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at age 60 (years)1', 'LE_at_60_male','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Life expectancy at age 60 (years)2', 'LE_at_60_female','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at birth (years)', 'Healthy_LE_at_birth_both','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at birth (years)1', 'Healthy_LE_at_birth_male','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at birth (years)2', 'Healthy_LE_at_birth_female','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at age 60 (years)', 'Healthy_LE_at_60_both','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at age 60 (years)1', 'Healthy_LE_at_60_male','COLUMN'
GO
sp_rename 'PORTIFOLIO..LifeExpectancy.Healthy life expectancy (HALE) at age 60 (years)2', 'Healthy_LE_at_60_female','COLUMN'
GO 

-- Deleting a single row after renaming a column

DELETE FROM PORTIFOLIO..LifeExpectancy
WHERE 'Year' is Null 


-- cleaning data where there is empty entry

SELECT DISTINCT(Year)
FROM PORTIFOLIO..LifeExpectancy

-- Checking the entire row
SELECT *
FROM PORTIFOLIO..LifeExpectancy
WHERE Year = 1920


-- Deleting the 5th row with empty entry

DELETE FROM PORTIFOLIO..LifeExpectancy
WHERE Year = 1920

-- Global Numbers
-- Loooking at Average life expectancy trend in 5 years span globally
SELECT 
	Year,
	ROUND(AVG(LE_at_birth_both),2) AS Average_Life_Expectancy_at_Birth,
	ROUND(AVG(LE_at_60_both),2) AS Average_Life_Expectancy_at_60,
	ROUND(AVG(Healthy_LE_at_birth_both),2) AS Average_Healthy_Life_Expectancy_at_Birth, 
	ROUND(AVG(Healthy_LE_at_60_both),2) AS Average_Healthy_Life_Expectancy_at_60
FROM PORTIFOLIO..LifeExpectancy
GROUP BY Year


-- Looking at Average Life Expectancy Group by Continent 

SELECT
	Continent,
	ROUND(AVG(LE_at_birth_both),2) AS Average_Life_Expectancy_at_Birth,
	ROUND(AVG(Healthy_LE_at_birth_both),2) AS Average_Healthy_Life_Expectancy_at_Birth
FROM PORTIFOLIO..LifeExpectancy
GROUP BY Continent

-- Looking at Average Life Expectancy trends in continents with a 5 year span 

SELECT
	Continent,
	Year,
	ROUND(AVG(LE_at_birth_both),2) AS Average_Life_Expectancy_at_Birth,
	ROUND(AVG(Healthy_LE_at_birth_both),2) AS Average_Healthy_Life_Expectancy_at_Birth  
FROM PORTIFOLIO..LifeExpectancy
GROUP BY Continent, Year
Order BY Year


-- Looking at Life Expectancy in Continents Male Vs Female 

SELECT
	Continent,
	ROUND(AVG(LE_at_birth_male),2) AS Average_Male_Life_Expectancy_at_Birth,
	ROUND(AVG(LE_at_birth_female),2) AS Average_Female_Life_Expectancy_at_Birth,
	ROUND(AVG(Healthy_LE_at_birth_male),2) AS Average_Male_Healthy_Life_Expectancy_at_Birth, 
	ROUND(AVG(Healthy_LE_at_birth_female),2) AS Average_Female_Healthy_Life_Expectancy_at_Birth
FROM PORTIFOLIO..LifeExpectancy
WHERE Year = 2019
GROUP BY Continent



--Country Context

-- Looking at Life Expectancy trend among countries

SELECT
	Country,
	Year,
	LE_at_birth_both AS Life_Expectancy_at_Birth,
	LE_at_60_both AS Life_Expectancy_at_60,
	Healthy_LE_at_birth_both AS Healthy_Life_Expectancy_at_Birth , 
	Healthy_LE_at_60_both AS Healthy_Life_Expectancy_at_60
FROM PORTIFOLIO..LifeExpectancy
WHERE Year = 2019

-- Showing life expectancy through out countries based on gender difference

SELECT
	Country,
	Year,
	LE_at_birth_male AS Male_Life_Expectancy_at_Birth,
	LE_at_birth_female AS Female_Life_Expectancy_at_Birth	
FROM PORTIFOLIO..LifeExpectancy
WHERE Year = 2019

-- Looking at life expectancy in countries through out the years

SELECT
	Country,
	Year,
	LE_at_birth_both AS Life_Expectancy_at_Birth,
	Healthy_LE_at_birth_both AS Healthy_Life_Expectancy_at_Birth 
FROM PORTIFOLIO..LifeExpectancy
ORDER BY Year

-- Showign countries with lowest life expectancy

SELECT
	Country,
	Year,
	LE_at_birth_both AS Life_Expectancy_at_Birth,
	Healthy_LE_at_birth_both AS Healthy_Life_Expectancy_at_Birth 
FROM PORTIFOLIO..LifeExpectancy
WHERE
	Year = '2019' AND
	LE_at_birth_both < 60 AND
	Healthy_LE_at_birth_both < 55
ORDER BY Country


-- Showign countries with highest life expectancy

SELECT
	Country,
	Year,
	LE_at_birth_both AS Life_Expectancy_at_Birth,
	Healthy_LE_at_birth_both AS Healthy_Life_Expectancy_at_Birth 
FROM PORTIFOLIO..LifeExpectancy
WHERE
	Year = '2019' AND
	LE_at_birth_both > 80 AND
	Healthy_LE_at_birth_both > 70
Order BY Country

-- Looking at the diference in life expectancy in 20 years

SELECT
	Country,
	SUM(CASE WHEN Year = 2000 THEN LE_at_birth_both ELSE 0 END) AS Life_Expectancy_2000,
	SUM(CASE WHEN Year = 2019 THEN LE_at_birth_both ELSE 0 END) AS Life_Expectancy_2019
				 
FROM PORTIFOLIO..LifeExpectancy
GROUP BY Country

-- Looking at percentarge change in life expectancy from 2000 to 2019

SELECT
	Country,
	
	ROUND(100*(SUM(CASE WHEN Year = 2019 THEN LE_at_birth_both ELSE 0 END) - SUM(CASE WHEN Year = 2000 THEN LE_at_birth_both ELSE 0 END))/SUM(CASE WHEN Year = 2000 THEN LE_at_birth_both ELSE 0 END),2) AS Percentage_change_in_Life_Expectancy
				 
FROM PORTIFOLIO..LifeExpectancy
GROUP BY Country




