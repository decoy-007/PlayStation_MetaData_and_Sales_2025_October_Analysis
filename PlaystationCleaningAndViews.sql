-- Creating a cleaned View from the main data source
  CREATE VIEW V_PSNMetadata_clean as
SELECT
    LEFT(CAST(Game As nvarchar), 3) Console,
    CAST(Name AS nvarchar) Name,
     CASE 
        WHEN Publisher LIKE 'Bandai%' THEN 'Bandai Namco'
        WHEN Publisher LIKE 'Namco%' THEN 'Bandai Namco'
        WHEN Publisher LIKE 'Konami%' THEN 'Konami'
        WHEN Publisher LIKE 'Sony%' THEN 'Sony Interactive Entertainment'
        WHEN Publisher LIKE 'Milestone%' THEN 'Milestone S.r.l'
        WHEN Publisher LIKE 'Idea Factory%' THEN 'Idea Factory'
        WHEN Publisher LIKE 'D3%' THEN 'D3Publisher'
        WHEN Publisher LIKE 'Capcom%' THEN 'Capcom'
        WHEN Publisher LIKE '2K%' THEN '2K Games'
        WHEN Publisher LIKE 'Aqua%' THEN 'Aqua Plus'
        WHEN Publisher LIKE 'Warner Bros%'THEN 'Warner Bros. Interactive'
        WHEN Publisher LIKE 'Gung%' THEN 'GungHo Online Entertainment'
        ELSE Publisher
      END Publisher, 
    Developer,
    CAST(Total_Shipped AS DECIMAL) Total_Shipped,
    CAST(Total_Sales AS decimal)AS  Total_Sales,
    CAST(NA_Sales AS decimal) AS NA_Sales,
    CAST(PAL_Sales AS decimal) AS  PAL_Sales,
    CAST(Japan_Sales AS decimal) AS  Japan_Sales
from PSNMetadata;

--Regional Sales by Console
CREATE VIEW V_ConsoleSales AS
SELECT
    Console,
    SUM(Total_Sales) AS TotalSales,
    SUM(Total_Shipped) AS TotalShipped,
    SUM(NA_Sales) AS NorthAmerica,
    SUM(PAL_Sales) AS Europe,
    SUM(Japan_Sales) AS Japan
FROM V_PSNMetadata_clean
GROUP BY Console;

--Publisher Sales View
CREATE VIEW V_PublisherSales
AS
SELECT
    Publisher,
    COUNT(*) AS GamesReleased,
    SUM(Total_Sales) AS TotalSales,
    SUM(Total_Shipped) AS TotalShipped
FROM V_PSNMetadata_clean
GROUP BY Publisher;

--Developer Sales View
CREATE VIEW V_DeveloperSales
AS
SELECT
    Developer,
    COUNT(*) AS Games,
    SUM(Total_Sales) AS TotalSales
FROM V_PSNMetadata_clean
GROUP BY Developer;

-- Game Sales View
CREATE VIEW V_GameSales
AS
SELECT
    Name,
    SUM(Total_Sales) AS TotalSales,
    SUM(Total_Shipped) AS TotalShipped
FROM V_PSNMetadata_clean
GROUP BY Name

-- Regional Sales view
CREATE VIEW V_RegionalSales
AS
SELECT
    Console,
    SUM(NA_Sales) AS NASales,
    SUM(PAL_Sales) AS PALSales,
    SUM(Japan_Sales) AS JapanSales
FROM V_PSNMetadata_clean
GROUP BY Console;

-- Game ranking view
CREATE VIEW V_GameRanking
AS
SELECT
    Name,
    SUM(Total_Sales) AS TotalSales,
    RANK() OVER
    (
        ORDER BY SUM(Total_Sales) DESC
    ) AS Ranking
FROM V_PSNMetadata_clean
GROUP BY Name;

-- Publisher by console Revenue View
CREATE VIEW V_PublisherConsoleSales
AS
SELECT
    Publisher,
    Console,
    SUM(Total_Sales) AS TotalSales
FROM V_PSNMetadata_clean
GROUP BY Publisher,Console;