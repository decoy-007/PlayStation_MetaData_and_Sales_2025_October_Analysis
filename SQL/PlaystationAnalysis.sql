

--================================================================
                    -- KPI Analysis
--================================================================
-- Overall KPI Summary
SELECT
COUNT(DISTINCT Name) AS Total_Games,
COUNT(DISTINCT Publisher) AS Total_Publishers,
COUNT(DISTINCT Developer) AS Total_Developers,
SUM(Total_Shipped) AS Total_Shipped,
SUM(Total_Sales) AS Total_Sales
FROM V_PSNMetadata_clean;

--Sales-to-Ship Ratio For physical games
SELECT
Publisher,
SUM(Total_Sales)/NULLIF(SUM(Total_Shipped),0) AS SellThroughRate
FROM V_PSNMetadata_clean
GROUP BY Publisher
ORDER BY SellThroughRate DESC;

-- Which publishers shipped a lot but sold little
SELECT
    Publisher,
    SUM(Total_Shipped) AS UnitsShipped,
    SUM(Total_Sales) AS UnitsSold,
    SUM(Total_Shipped)-SUM(Total_Sales) Unsold
FROM V_PSNMetadata_clean
GROUP BY Publisher
ORDER BY Unsold DESC;

--=====================================================================
                        -- Developer Analysis
--=====================================================================

--Top 10 develepers by Revenue
SELECT TOP 10
    Developer,
    SUM(Total_Sales) AS TotalSales
FROM V_PSNMetadata_clean
GROUP BY Developer
ORDER BY TotalSales DESC;

-- TOP 10 Developers in Japan
SELECT TOP 10
    Developer,
    SUM(Japan_Sales) Total_Revenue
FROM V_PSNMetadata_clean
Group by Developer
order by  Total_Revenue DESC;

---- TOP 10 Developers in NA
SELECT TOP 10
    Developer,
    SUM(NA_Sales) Total_Revenue
FROM V_PSNMetadata_clean
Group by Developer
order by  Total_Revenue DESC;

--TOP 10 Developers in PAL
SELECT TOP 10
    Developer,
    SUM(PAL_Sales) Total_Revenue
FROM V_PSNMetadata_clean
Group by Developer
order by  Total_Revenue DESC;


--=======================================================================
                -- Console Analysis
--========================================================================
--Revenue By Consoles 
WITH ConsoleRevenue AS(
SELECT
    Console,
    SUM(Total_Sales) Total_Revenue
From V_PSNMetadata_clean
Group by Console
)
SELECT*,
    SUM(Total_Revenue) OVER() AS Overall_Revenue,
    ROUND(Total_Revenue/SUM(Total_Revenue) OVER() * 100 ,2) AS MarketShare
FROM ConsoleRevenue
ORDER BY MarketShare DESC

--Regional Sales by Console
SELECT
    Console,
    SUM(Total_Sales) AS TotalSales,
    SUM(Total_Shipped) AS TotalShipped,
    SUM(NA_Sales) AS NorthAmerica,
    SUM(PAL_Sales) AS Europe,
    SUM(Japan_Sales) AS Japan
FROM V_PSNMetadata_clean
GROUP BY Console;

--===================================================================
                           -- Publisher Analysis
--===================================================================

--Top 10 publishers by Revenue
SELECT TOP 10
    Publisher,
    SUM(Total_Sales) AS TotalSales
FROM V_PSNMetadata_clean
GROUP BY Publisher
ORDER BY TotalSales DESC;


--Publishers with Most Games
SELECT
    Publisher,
    COUNT(*) NumberOfGames
FROM V_PSNMetadata_clean
GROUP BY Publisher
ORDER BY NumberOfGames DESC;

-- Publisher Rankings
SELECT
    Publisher,
    SUM(Total_Sales) Sales,
    RANK() OVER(ORDER BY SUM(Total_Sales) DESC) AS Ranking
FROM V_PSNMetadata_clean
GROUP BY Publisher;


--Total Shipped Units by Publisher
SELECT
    Publisher,
    SUM(Total_Shipped) Total_Shipped_Units
FROM V_PSNMetadata_clean
Group BY Publisher
ORDER BY Total_Shipped_Units DESC


--Japan Revenue from PS4 Games and publishers
WITH JapanSales AS (
Select
    Publisher,
    Console,
    SUM(Japan_Sales) Total_Japan_Sales
from V_PSNMetadata_clean
group by Publisher,
          console
)
SELECT*
FROM JapanSales
WHERE Total_Japan_Sales > 0 AND Console = 'PS4'
ORDER BY Total_Japan_Sales DESC;

----Japan Revenue from PS3 Games and publishers
WITH JapanSales AS (
Select
    Publisher,
    Console,
    SUM(Japan_Sales) Total_Japan_Sales
from V_PSNMetadata_clean
group by Publisher,
          console
)
SELECT*
FROM JapanSales
WHERE Total_Japan_Sales > 0 AND Console = 'PS3'
ORDER BY Total_Japan_Sales DESC;

--==============================================================================
                        -- Game Analysis
--==============================================================================
--Highest Selling Game Per Console
WITH HighestSelling AS
(
SELECT
    Console,
    Name,
    SUM(Total_Sales) TotalSales,
    ROW_NUMBER() OVER(PARTITION BY Console ORDER BY SUM(Total_Sales) DESC) rn
FROM V_PSNMetadata_clean
GROUP BY Console,Name
)
SELECT *
FROM HighestSelling
WHERE rn = 1;

--Total Revenue From Grand Theft auto 5 on ps3
with totalRev as(
SELECT
    Name As Name_Ps3,
    SUM(Japan_Sales) GTA_5_Jpn,
    SUM(PAL_Sales) GTA_5_Pal,
    SUM(NA_Sales) GTA_5_Na
FROM V_PSNMetadata_clean
WHERE NAME LIKE 'Grand Theft Auto V' and Console = 'PS3'
GROUP BY Name
)
select*,
    GTA_5_Jpn + GTA_5_Na + GTA_5_Pal TotalSales
from totalRev;


--Total Revenue From Grand Theft auto 5 on ps4
with totalRev as(
SELECT
    Name AS Name_Ps4,
    SUM(Japan_Sales) GTA_5_Jpn,
    SUM(PAL_Sales) GTA_5_Pal,
    SUM(NA_Sales) GTA_5_Na
FROM V_PSNMetadata_clean
WHERE NAME LIKE 'Grand Theft Auto V' and Console = 'PS4'
GROUP BY Name
)
select*,
GTA_5_Jpn + GTA_5_Na + GTA_5_Pal TotalSales
from totalRev;

--Total Revenue by Games PS3, PS4 and PS5 Combined from all countries
with totalRevenueByGame as(
SELECT
    Name,
    SUM(Japan_Sales) Jpn,
    SUM(PAL_Sales) Pal,
    SUM(NA_Sales) NA
FROM V_PSNMetadata_clean
Group by Name
),
total as(
  SELECT*,
  Jpn + Pal + NA TotalRevenue
  FROM totalRevenueByGame
)
SELECT*
FROM total
WHERE TotalRevenue > 0
Order by TotalRevenue DESC

-- Games selling much higher than average.
SELECT TOP 10
    Console,
    Name,
    Total_Sales
FROM V_PSNMetadata_clean
WHERE Total_Sales >
(
    SELECT AVG(Total_Sales)*3
    FROM V_PSNMetadata_clean
)
ORDER BY Total_Sales DESC;


--games that are much more popular in Japan.
SELECT TOP 20
    Name,
    Japan_Sales,
    NA_Sales,
    PAL_Sales
FROM V_PSNMetadata_clean
ORDER BY Japan_Sales DESC;

-- games that are much more popular in NA.
SELECT TOP 20
    Name,
    NA_Sales,
    Japan_Sales,
    PAL_Sales
FROM V_PSNMetadata_clean
ORDER BY NA_Sales DESC;

--games that are much more popular in PAL
SELECT TOP 20
    Name,
    PAL_Sales,
    NA_Sales,
    Japan_Sales
FROM V_PSNMetadata_clean
ORDER BY NA_Sales DESC;

