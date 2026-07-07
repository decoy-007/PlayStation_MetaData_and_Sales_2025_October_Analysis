#  PlayStation Game Sales Analysis (PS3, PS4 & PS5)

##  Project Overview

This project explores PlayStation game sales across the PS3, PS4, and PS5 platforms using SQL Server and Power BI. The objective was to clean and transform raw sales data, perform exploratory data analysis, and build an interactive dashboard that provides insights into game performance, publisher success, regional sales, and console market share.

The project demonstrates the complete data analysis workflow, from data preparation and SQL querying to data visualization and business intelligence reporting.

---

##  Objectives

- Clean and standardize PlayStation sales data using SQL Server
- Analyze sales performance across PS3, PS4, and PS5
- Compare regional sales (North America, PAL, and Japan)
- Identify the highest-selling games, publishers, and developers
- Build an interactive Power BI dashboard for business insights

---

##  Tools & Technologies

- SQL Server
- SQL Server Management Studio (SSMS)
- Power BI
- DAX
- Git & GitHub

---

##  Dataset

The dataset contains PlayStation game metadata including:

- Console
- Game Name
- Publisher
- Developer
- Total Units Shipped
- Total Sales
- North America Sales
- PAL Sales
- Japan Sales

---

##  Data Cleaning

The raw dataset was cleaned using SQL by:

- Creating a reusable SQL View
- Standardizing publisher names
- Converting numeric columns from text to decimal values
- Removing inconsistencies in publisher naming
- Creating a simplified Console field (PS3, PS4, PS5)

---

##  SQL Analysis

The project includes several business-focused SQL analyses, including:

- Total Revenue by Console
- Console Market Share
- Top Selling Games
- Top Publishers
- Top Developers
- Revenue by Region
- Highest Selling Game per Console
- Publisher Performance
- Units Shipped vs Total Sales
- Sell-through Analysis
- Ranking Games using Window Functions
- Common Table Expressions (CTEs)
- Aggregate Functions
- Views for Power BI Reporting

---

##  Power BI Dashboard

The interactive dashboard includes:

### Executive KPIs

- Total Revenue
- Total Publishers
- Total Games
- Total Units Shipped

### Visualizations

- Console Market Share
- Top 10 Selling Games
- Revenue by Region
- Interactive Console Slicer
- Dynamic Regional Analysis
- Publisher Performance
- Console Sales Comparison

---

##  Key Insights

- PS3 generated the highest overall sales among the three consoles.
- Grand Theft Auto V is the highest-selling title across PlayStation consoles.
- North America contributed the largest share of total sales.
- Activision, Rockstar Games, and Sony are among the top-performing publishers.
- Console performance varies significantly across different regions.

---

##  Project Structure

```
PlayStation-Game-Sales-Analysis
│
├── Dataset/
│   └── PlayStation Sales Dataset.csv
│
├── SQL/
│   ├── Data Cleaning.sql
│   ├── Views.sql
│   └── Analysis.sql
│  
│
├── Images/
│   └── Dashboard Screenshot.png
│
└── README.md
```

---


##  Skills Demonstrated

### SQL

- Data Cleaning
- Data Transformation
- Views
- Common Table Expressions (CTEs)
- Window Functions
- Aggregate Functions
- Ranking Functions
- CASE Statements
- GROUP BY
- ORDER BY
- Business Analysis Queries

### Power BI

- Data Modeling
- DAX Measures
- Interactive Dashboards
- KPI Cards
- Slicers
- Bar Charts
- Donut Charts
- Stacked Column Charts
- Dynamic Filtering

---


##  Author

**Thabiso Kgole**

