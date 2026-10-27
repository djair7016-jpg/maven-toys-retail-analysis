-- ============================================================
-- MAVEN TOYS RETAIL ANALYSIS
-- End-to-End SQL Analysis
-- ============================================================

-- ============================================================
-- 1. DATA QUALITY & INITIAL VALIDATION
-- ============================================================

SELECT COUNT(*) AS total_registros FROM "sales.csv";
SELECT COUNT(*) AS total_registros FROM "products.csv";
SELECT COUNT(*) AS total_registros FROM "stores.csv";
SELECT COUNT(*) AS total_registros FROM "inventory.csv";
SELECT COUNT(*) AS total_registros FROM "calendar.csv";

SELECT
    COUNT(*) AS total_filas,
    COUNT(DISTINCT Sale_ID) AS ventas_unicas
FROM "sales.csv";

SELECT
    Sale_ID,
    COUNT(*) AS repeticiones
FROM "sales.csv"
GROUP BY Sale_ID
HAVING COUNT(*) > 1;

SELECT
    Product_ID,
    COUNT(*) AS repeticiones
FROM "products.csv"
GROUP BY Product_ID
HAVING COUNT(*) > 1;

SELECT
    Store_ID,
    COUNT(*) AS repeticiones
FROM "stores.csv"
GROUP BY Store_ID
HAVING COUNT(*) > 1;

SELECT
    Store_ID,
    Product_ID,
    COUNT(*) AS repeticiones
FROM "inventory.csv"
GROUP BY Store_ID, Product_ID
HAVING COUNT(*) > 1;

SELECT
    SUM(CASE WHEN Sale_ID IS NULL THEN 1 ELSE 0 END) AS null_sale_id,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN Store_ID IS NULL THEN 1 ELSE 0 END) AS null_store_id,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN Units IS NULL THEN 1 ELSE 0 END) AS null_units
FROM "sales.csv";

SELECT
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN Product_Name IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN Product_Category IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN Product_Cost IS NULL THEN 1 ELSE 0 END) AS null_cost,
    SUM(CASE WHEN Product_Price IS NULL THEN 1 ELSE 0 END) AS null_price
FROM "products.csv";

SELECT
    MIN(Units) AS unidades_minimas,
    MAX(Units) AS unidades_maximas,
    AVG(Units) AS promedio_unidades
FROM "sales.csv";

SELECT *
FROM "sales.csv"
WHERE Units <= 0;

SELECT DISTINCT
    s.Product_ID
FROM "sales.csv" AS s
LEFT JOIN "products.csv" AS p
    ON s.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;

SELECT DISTINCT
    s.Store_ID
FROM "sales.csv" AS s
LEFT JOIN "stores.csv" AS st
    ON s.Store_ID = st.Store_ID
WHERE st.Store_ID IS NULL;

SELECT DISTINCT
    i.Product_ID
FROM "inventory.csv" AS i
LEFT JOIN "products.csv" AS p
    ON i.Product_ID = p.Product_ID
WHERE p.Product_ID IS NULL;

SELECT DISTINCT
    i.Store_ID
FROM "inventory.csv" AS i
LEFT JOIN "stores.csv" AS st
    ON i.Store_ID = st.Store_ID
WHERE st.Store_ID IS NULL;


-- ============================================================
-- 2. DATA TYPE VALIDATION & PRODUCT CLEANING
-- ============================================================

SELECT
    Date,
    TYPEOF(Date) AS tipo_fecha
FROM "sales.csv"
LIMIT 5;

SELECT
    Product_Cost,
    TYPEOF(Product_Cost) AS tipo_cost,
    Product_Price,
    TYPEOF(Product_Price) AS tipo_price
FROM "products.csv"
LIMIT 5;

CREATE OR REPLACE VIEW products_clean AS
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    CAST(REPLACE(TRIM(Product_Cost), '$', '') AS DECIMAL(10,2)) AS Product_Cost,
    CAST(REPLACE(TRIM(Product_Price), '$', '') AS DECIMAL(10,2)) AS Product_Price
FROM "products.csv";

SELECT
    Product_Cost,
    TYPEOF(Product_Cost) AS tipo_cost,
    Product_Price,
    TYPEOF(Product_Price) AS tipo_price
FROM products_clean
LIMIT 5;


-- ============================================================
-- 3. ENRICHED SALES DATASET
-- ============================================================

CREATE OR REPLACE VIEW sales_enriched AS
SELECT
    s.Sale_ID,
    s.Date,
    s.Store_ID,
    s.Product_ID,
    p.Product_Name,
    p.Product_Category,
    s.Units,
    p.Product_Cost,
    p.Product_Price,
    s.Units * p.Product_Price AS Revenue,
    s.Units * p.Product_Cost AS COGS,
    s.Units * (p.Product_Price - p.Product_Cost) AS Gross_Profit
FROM "sales.csv" AS s
INNER JOIN products_clean AS p
    ON s.Product_ID = p.Product_ID;

SELECT COUNT(*) AS total_rows
FROM sales_enriched;

SELECT
    SUM(Revenue) AS Total_Revenue,
    SUM(COGS) AS Total_COGS,
    SUM(Gross_Profit) AS Total_Gross_Profit
FROM sales_enriched;


-- ============================================================
-- 4. PRODUCT PERFORMANCE
-- ============================================================

CREATE OR REPLACE VIEW product_performance AS
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    SUM(Units) AS Units_Sold,
    SUM(Revenue) AS Revenue,
    SUM(COGS) AS COGS,
    SUM(Gross_Profit) AS Gross_Profit,
    ROUND(
        SUM(Gross_Profit) / NULLIF(SUM(Revenue), 0) * 100,
        2
    ) AS Gross_Margin_Pct
FROM sales_enriched
GROUP BY
    Product_ID,
    Product_Name,
    Product_Category;

SELECT
    Product_Name,
    Product_Category,
    Revenue,
    Gross_Profit,
    Gross_Margin_Pct,
    RANK() OVER (ORDER BY Revenue DESC) AS Revenue_Rank,
    RANK() OVER (ORDER BY Gross_Profit DESC) AS Profit_Rank,
    RANK() OVER (ORDER BY Gross_Margin_Pct DESC) AS Margin_Rank
FROM product_performance
ORDER BY Revenue_Rank;

SELECT
    Product_Name,
    Revenue
FROM product_performance
ORDER BY Revenue DESC
LIMIT 1;

SELECT
    Product_Name,
    Gross_Margin_Pct
FROM product_performance
ORDER BY Gross_Margin_Pct ASC
LIMIT 1;


-- ============================================================
-- 5. GEOGRAPHIC PERFORMANCE
-- ============================================================

CREATE OR REPLACE VIEW city_performance AS
SELECT
    st.Store_City,
    COUNT(DISTINCT st.Store_ID) AS Store_Count,
    SUM(se.Revenue) AS Revenue,
    SUM(se.Gross_Profit) AS Gross_Profit,
    SUM(se.Revenue) / COUNT(DISTINCT st.Store_ID) AS Revenue_Per_Store,
    ROUND(
        SUM(se.Revenue) / SUM(SUM(se.Revenue)) OVER () * 100,
        2
    ) AS Revenue_Share_Pct
FROM sales_enriched AS se
INNER JOIN "stores.csv" AS st
    ON se.Store_ID = st.Store_ID
GROUP BY st.Store_City;

SELECT
    Store_City,
    Store_Count,
    Revenue,
    Revenue_Per_Store,
    Revenue_Share_Pct,
    RANK() OVER (ORDER BY Revenue DESC) AS Revenue_Rank,
    RANK() OVER (ORDER BY Revenue_Per_Store DESC) AS Efficiency_Rank
FROM city_performance
ORDER BY Revenue_Rank;

SELECT
    Store_City,
    Store_Count,
    Revenue,
    Revenue_Per_Store,
    Revenue_Share_Pct
FROM city_performance
ORDER BY Revenue ASC
LIMIT 5;

WITH city_rank AS (
    SELECT
        Store_City,
        Revenue,
        Revenue_Share_Pct,
        RANK() OVER (ORDER BY Revenue DESC) AS Revenue_Rank
    FROM city_performance
)
SELECT
    ROUND(SUM(Revenue_Share_Pct), 2) AS Top_5_Revenue_Share_Pct
FROM city_rank
WHERE Revenue_Rank <= 5;


-- ============================================================
-- 6. MONTHLY PERFORMANCE
-- ============================================================

CREATE OR REPLACE VIEW monthly_performance AS
SELECT
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    CAST(DATE_TRUNC('month', Date) AS DATE) AS Month_Start,
    SUM(Revenue) AS Revenue,
    SUM(Gross_Profit) AS Gross_Profit,
    SUM(Units) AS Units_Sold
FROM sales_enriched
GROUP BY
    YEAR(Date),
    MONTH(Date),
    CAST(DATE_TRUNC('month', Date) AS DATE)
ORDER BY Month_Start;

SELECT
    COUNT(*) AS Total_Months,
    MIN(Month_Start) AS First_Month,
    MAX(Month_Start) AS Last_Month
FROM monthly_performance;


-- ============================================================
-- 7. MONTH-OVER-MONTH & YEAR-OVER-YEAR GROWTH
-- ============================================================

WITH monthly_lag AS (
    SELECT
        Month_Start,
        Revenue,
        LAG(Revenue) OVER (ORDER BY Month_Start) AS Previous_Month_Revenue
    FROM monthly_performance
)
SELECT
    Month_Start,
    Revenue,
    Previous_Month_Revenue,
    ROUND(
        (Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS MoM_Growth_Pct
FROM monthly_lag
ORDER BY Month_Start;

CREATE OR REPLACE VIEW monthly_growth AS
WITH growth_base AS (
    SELECT
        Month_Start,
        Revenue,
        LAG(Revenue) OVER (ORDER BY Month_Start) AS Previous_Month_Revenue,
        LAG(Revenue, 12) OVER (ORDER BY Month_Start) AS Previous_Year_Revenue
    FROM monthly_performance
)
SELECT
    Month_Start,
    Revenue,
    Previous_Month_Revenue,
    Previous_Year_Revenue,
    ROUND(
        (Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS MoM_Growth_Pct,
    ROUND(
        (Revenue - Previous_Year_Revenue)
        / NULLIF(Previous_Year_Revenue, 0) * 100,
        2
    ) AS YoY_Growth_Pct
FROM growth_base;

SELECT
    Month_Start,
    Revenue,
    Previous_Year_Revenue,
    YoY_Growth_Pct
FROM monthly_growth
WHERE YEAR(Month_Start) = 2023
ORDER BY YoY_Growth_Pct DESC;

SELECT
    Month_Start,
    Revenue,
    Previous_Year_Revenue,
    YoY_Growth_Pct
FROM monthly_growth
WHERE YEAR(Month_Start) = 2023
ORDER BY YoY_Growth_Pct ASC;


-- ============================================================
-- 8. YTD COMPARISON: 2022 VS 2023
-- ============================================================

WITH ytd_revenue AS (
    SELECT
        Year,
        SUM(Revenue) AS YTD_Revenue
    FROM monthly_performance
    WHERE Month <= 9
    GROUP BY Year
),
comparison AS (
    SELECT
        MAX(CASE WHEN Year = 2022 THEN YTD_Revenue END) AS Revenue_YTD_2022,
        MAX(CASE WHEN Year = 2023 THEN YTD_Revenue END) AS Revenue_YTD_2023
    FROM ytd_revenue
)
SELECT
    Revenue_YTD_2022,
    Revenue_YTD_2023,
    ROUND(
        (Revenue_YTD_2023 - Revenue_YTD_2022)
        / NULLIF(Revenue_YTD_2022, 0) * 100,
        2
    ) AS YoY_YTD_Growth_Pct
FROM comparison;


-- ============================================================
-- 9. INVENTORY ENRICHMENT
-- ============================================================

CREATE OR REPLACE VIEW inventory_enriched AS
SELECT
    i.Store_ID,
    i.Product_ID,
    p.Product_Name,
    p.Product_Category,
    i.Stock_On_Hand,
    p.Product_Cost,
    p.Product_Price,
    i.Stock_On_Hand * p.Product_Cost AS Inventory_Value
FROM "inventory.csv" AS i
INNER JOIN products_clean AS p
    ON i.Product_ID = p.Product_ID;

SELECT
    SUM(Inventory_Value) AS Total_Inventory_Value
FROM inventory_enriched;


-- ============================================================
-- 10. PRODUCT INVENTORY
-- ============================================================

CREATE OR REPLACE VIEW product_inventory AS
SELECT
    Product_ID,
    Product_Name,
    Product_Category,
    SUM(Stock_On_Hand) AS Total_Stock,
    SUM(Inventory_Value) AS Inventory_Value
FROM inventory_enriched
GROUP BY
    Product_ID,
    Product_Name,
    Product_Category;


-- ============================================================
-- 11. RECENT SALES VELOCITY
-- ============================================================

CREATE OR REPLACE VIEW recent_product_sales AS
SELECT
    Product_ID,
    Product_Name,
    SUM(Units) AS Units_Sold_Last_3M,
    ROUND(SUM(Units) / 3.0, 2) AS Avg_Monthly_Units
FROM sales_enriched
WHERE Date >= DATE '2023-07-01'
  AND Date <= DATE '2023-09-30'
GROUP BY
    Product_ID,
    Product_Name;


-- ============================================================
-- 12. INVENTORY COVERAGE ANALYSIS
-- ============================================================

CREATE OR REPLACE VIEW inventory_analysis AS
SELECT
    i.Product_ID,
    i.Product_Name,
    i.Product_Category,
    i.Total_Stock,
    i.Inventory_Value,
    s.Units_Sold_Last_3M,
    s.Avg_Monthly_Units,
    ROUND(
        i.Total_Stock / NULLIF(s.Avg_Monthly_Units, 0),
        2
    ) AS Months_Of_Stock
FROM product_inventory AS i
LEFT JOIN recent_product_sales AS s
    ON i.Product_ID = s.Product_ID;

SELECT
    ROUND(MIN(Months_Of_Stock), 2) AS Min_Months_Stock,
    ROUND(AVG(Months_Of_Stock), 2) AS Avg_Months_Stock,
    ROUND(MAX(Months_Of_Stock), 2) AS Max_Months_Stock
FROM inventory_analysis;

SELECT
    Product_Name,
    Total_Stock,
    Avg_Monthly_Units,
    Months_Of_Stock,
    Inventory_Value,
    CASE
        WHEN Months_Of_Stock < 0.5 THEN 'Low Stock Coverage'
        WHEN Months_Of_Stock <= 1 THEN 'Medium Stock Coverage'
        ELSE 'High Stock Coverage'
    END AS Stock_Coverage_Status
FROM inventory_analysis
ORDER BY Months_Of_Stock ASC;

WITH coverage AS (
    SELECT
        CASE
            WHEN Months_Of_Stock < 0.5 THEN 'Low Stock Coverage'
            WHEN Months_Of_Stock <= 1 THEN 'Medium Stock Coverage'
            ELSE 'High Stock Coverage'
        END AS Stock_Coverage_Status
    FROM inventory_analysis
)
SELECT
    Stock_Coverage_Status,
    COUNT(*) AS Product_Count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS Product_Share_Pct
FROM coverage
GROUP BY Stock_Coverage_Status
ORDER BY Product_Count DESC;

-- ============================================================
-- END OF ANALYSIS
-- ============================================================
