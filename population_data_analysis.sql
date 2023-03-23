SELECT * FROM dbo.data1;

SELECT * FROM dbo.data2;

-- counting rows in each table
SELECT COUNT(*) FROM dbo.data1
SELECT COUNT(*) FROM dbo.data2

--Data for Maharashtra & Bihar
SELECT * FROM dbo.data1 WHERE State IN ('Maharashtra', 'Bihar')
SELECT * FROM dbo.data2 WHERE State IN ('Maharashtra', 'Bihar')

--Population of India
SELECT SUM(Population) AS Total_Population FROM dbo.data2

--Average Growth of Country
SELECT AVG(Growth)*100 AS average_growth FROM dbo.data1

--Average Growth of State
SELECT State, ROUND(AVG(Growth)*100, 0) AS avg_growth FROM dbo.data1
GROUP BY State
ORDER BY AVG(Growth) DESC

--Average sex ratio as per the state
SELECT State, ROUND(AVG(Sex_Ratio)*100, 0) AS avg_sex_ratio FROM dbo.data1
GROUP BY State
ORDER BY AVG(Sex_Ratio) DESC

-- Average Literacy Rate
SELECT State, ROUND(AVG(Literacy)*100, 0) AS avg_literacy_rate FROM dbo.data1
GROUP BY State
ORDER BY AVG(Literacy)*100 DESC

--Find out States with literacy rate greater than 90
SELECT State, ROUND(AVG(Literacy)*100, 0) AS avg_literacy_rate FROM dbo.data1
GROUP BY State 
HAVING ROUND(AVG(Literacy)*100, 0)>9000
ORDER BY AVG(Literacy)*100 DESC

--Top 3 states showing highest Growth rate
SELECT TOP 3 State, ROUND(AVG(Growth)*100, 0) AS top_3_states FROM dbo.data1
GROUP BY State
ORDER BY AVG(Growth) DESC

--Top 3 states with highest sex ratio
SELECT top 3 State, ROUND(AVG(Sex_Ratio)*100, 0) AS avg_sex_ratio FROM dbo.data1
GROUP BY State
ORDER BY AVG(Sex_Ratio) DESC

-- top 3 states with highest literacy rate
SELECT top 3 State, ROUND(AVG(Literacy)*100, 0) AS avg_literacy_rate FROM dbo.data1
GROUP BY State 
ORDER BY AVG(Literacy)*100 DESC

--top and bottom 3 states (growth rate)

CREATE TABLE #top_3_states
(
State nvarchar(255),
Growth float
)
INSERT INTO #top_3_states
SELECT TOP 3 State, ROUND(AVG(Growth)*100, 0) AS top_3_states FROM dbo.data1
GROUP BY State
ORDER BY AVG(Growth) DESC

SELECT TOP 3 State * FROM #top_3_states ORDER BY #top_3_states.Growth DESC

CREATE TABLE #bottom_3_states
(
State nvarchar(255),
Growth float
)
INSERT INTO #bottom_3_states
SELECT TOP 3 State, ROUND(AVG(Growth)*100, 0) AS top_3_states FROM dbo.data1
GROUP BY State
ORDER BY AVG(Growth) ASC

SELECT TOP 3 State * FROM #bottom_3_states ORDER BY #bottom_3_states.Growth ASC

SELECT * FROM (
SELECT TOP 3  * FROM #top_3_states ORDER BY #top_3_states.Growth DESC ) a
UNION
SELECT * FROM(
SELECT TOP 3  * FROM #bottom_3_states ORDER BY #bottom_3_states.Growth ASC) b

--Literacy rate of state starting with letter M
SELECT State, District, ROUND(Literacy, 0) FROM dbo.data1 where State LIKE 'M%'

-- Number of Males and Females according to districts

SELECT * FROM population.dbo.data1;
SELECT * FROM population.dbo.data2;

SELECT c.District, c.State, ROUND(c.Population * c.Sex_ratio / 1000,0) AS females, 
ROUND(c.Population - (c.Population * c.Sex_ratio / 1000),0) AS males
FROM
(SELECT a.District, a.State, a.Sex_ratio as Sex_ratio, b.Population
FROM population.dbo.data1 a
INNER JOIN 
population.dbo.data2 b
ON a.District = b.District)c

--Number of males and females as per States

SELECT d.State, sum(d.males) AS total_males, sum(d.females) AS total_females
FROM
(SELECT c.District, c.State, ROUND(c.Population * c.Sex_ratio / 1000,0) AS females, 
ROUND(c.Population - (c.Population * c.Sex_ratio / 1000),0) AS males
FROM
(SELECT a.District, a.State, a.Sex_ratio as Sex_ratio, b.Population
FROM population.dbo.data1 a
INNER JOIN 
population.dbo.data2 b
ON a.District = b.District)c)d
GROUP BY d.State
