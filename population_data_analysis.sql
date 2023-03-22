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