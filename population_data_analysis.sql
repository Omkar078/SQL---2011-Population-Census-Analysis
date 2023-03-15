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
SELECT State, ROUND(AVG(Growth)*100, 2) AS avg_growth FROM dbo.data1
GROUP BY State
ORDER BY AVG(Growth) DESC

--Average sex ration as per the state
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
HAVING ROUND(AVG(Literacy)*100, 0)>90
ORDER BY AVG(Literacy)*100 DESC