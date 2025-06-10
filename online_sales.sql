SELECT * FROM online_sales.`online sales data`;

-- Monthly Revenue & Order Volume
SELECT 
    EXTRACT(YEAR FROM `Date`) AS Year, 
    EXTRACT(MONTH FROM `Date`) AS Month,
    SUM(`Total Revenue`) AS Total_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume
FROM online_sales.`online sales data`
GROUP BY Year, Month
ORDER BY Year DESC, Month DESC;

-- Region-Wise Sales Analysis
SELECT 
    Region,
    EXTRACT(YEAR FROM `Date`) AS Year, 
    EXTRACT(MONTH FROM `Date`) AS Month,
    SUM(`Total Revenue`) AS Total_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Volume
FROM online_sales.`online sales data`
GROUP BY Region, Year, Month
ORDER BY Year DESC, Month DESC, Total_Revenue DESC;

-- Top Performing Categories Each Month
SELECT 
    EXTRACT(YEAR FROM `Date`) AS Year, 
    EXTRACT(MONTH FROM `Date`) AS Month,
    `Product Category`,
    SUM(`Total Revenue`) AS Total_Revenue
FROM online_sales.`online sales data`
GROUP BY Year, Month, `Product Category`
ORDER BY Year DESC, Month DESC, Total_Revenue DESC
LIMIT 10;

-- Payment Method Preferences Over Time
SELECT 
    EXTRACT(YEAR FROM `Date`) AS Year, 
    EXTRACT(MONTH FROM `Date`) AS Month,
    `Payment Method`,
    COUNT(DISTINCT `Transaction ID`) AS Transaction_Count,
    SUM(`Total Revenue`) AS Total_Revenue
FROM online_sales.`online sales data`
GROUP BY Year, Month, `Payment Method`
ORDER BY Year DESC, Month DESC, Total_Revenue DESC;

-- Yearly Revenue Growth
SELECT 
    EXTRACT(YEAR FROM `Date`) AS Year,
    SUM(`Total Revenue`) AS Total_Revenue,
    LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM `Date`)) AS Previous_Year_Revenue,
    ROUND(((SUM(`Total Revenue`) - LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM `Date`))) / 
    LAG(SUM(`Total Revenue`)) OVER (ORDER BY EXTRACT(YEAR FROM `Date`)) * 100), 2) AS Growth_Percentage
FROM online_sales.`online sales data`
GROUP BY Year
ORDER BY Year DESC;

-- Finding Peak Sales Months
SELECT 
    EXTRACT(YEAR FROM `Date`) AS Year, 
    EXTRACT(MONTH FROM `Date`) AS Month,
    SUM(`Total Revenue`) AS Monthly_Revenue
FROM online_sales.`online sales data`
GROUP BY Year, Month
ORDER BY Monthly_Revenue DESC
LIMIT 5;

-- Highest Revenue-Generating Products
SELECT 
    `Product Name`,
    SUM(`Total Revenue`) AS Total_Revenue,
    COUNT(DISTINCT `Transaction ID`) AS Order_Count
FROM online_sales.`online sales data`
GROUP BY `Product Name`
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Most Sold Product Categories
SELECT 
    `Product Category`,
    SUM(`Units Sold`) AS Total_Units_Sold,
    SUM(`Total Revenue`) AS Total_Revenue
FROM online_sales.`online sales data`
GROUP BY `Product Category`
ORDER BY Total_Units_sold DESC
LIMIT 10;
