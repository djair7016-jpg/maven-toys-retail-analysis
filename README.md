Maven Toys Retail Analysis
End-to-end retail data analysis focused on evaluating sales performance, profitability, inventory management, and geographic trends for Maven Toys.

The project was developed using SQL, Python, Power BI, and Tableau, covering the full analytical workflow from data preparation and exploratory analysis to KPI development, dashboard creation, and business recommendations.

The main objective was to identify high-performing products and markets, detect low-performing areas, evaluate inventory coverage, and uncover opportunities to improve revenue, profitability, and stock management.
Business Problem
Maven Toys operates across multiple cities, product categories, and stores, generating sales and inventory data that can be used to evaluate overall business performance.

The main challenge was to transform this data into meaningful business insights that could help answer key questions related to sales, profitability, product performance, geographic performance, and inventory management.

The analysis focused on identifying:
- Which products and categories generate the highest revenue and profit.
- Which products show weaker profitability or sales performance.
- Which cities contribute the most and least to total revenue.
- How sales performance evolved over time.
- Which products have insufficient or excessive inventory coverage.
- Where inventory management could be improved to reduce the risk of stockouts or excess stock.
- Which business areas present the greatest opportunities for growth and optimization.
The ultimate goal was to provide a clear view of the company's commercial and inventory performance and support data-driven decisions related to sales strategy, product prioritization, and stock management.
Business Questions
The project was structured around the following business questions:
1. Which products generate the highest and lowest revenue?
2. Which products and categories are the most and least profitable?
3. Which cities generate the highest and lowest revenue?
4. How did total revenue evolve between 2022 and 2023?
5. What monthly trends or variations can be identified in sales performance?
6. Which products have the highest inventory value and stock levels?
7. Which products present low, medium, or high stock coverage based on their estimated months of stock?
8. Which products may be at risk of stockouts due to insufficient inventory coverage?
9. Which products may have excess inventory relative to their recent sales performance?
10. What opportunities exist to improve sales, profitability, and inventory allocation across products, categories, and locations?
These questions guided the analytical process and helped connect technical analysis with practical business decision-making.
Tools & Technologies
SQL
Used for data preparation, transformation, aggregation, and business analysis.

Key applications included:
- Data quality checks and validation
- Identification of duplicates and missing records
- Revenue, cost, and gross profit calculations
- Product and geographic rankings using window functions
- Monthly performance analysis
- Month-over-Month and Year-over-Year comparisons
- Inventory coverage analysis
- Use of CTEs, JOINs, RANK(), LAG(), and LEAD()
Python
Used for exploratory data analysis and independent validation of the processed data.

Main tasks included:
- Descriptive statistics
- Data distribution analysis
- Detection of potential outliers using the IQR method
- Validation of revenue and transaction-level results
- Exploratory visualizations
- Additional checks before developing the BI dashboards
Libraries included Pandas and Matplotlib.
Power BI
Used to create an interactive Business Intelligence solution focused on executive and operational analysis.

Main components included:
- Star-schema data modeling
- DAX measures for Revenue, COGS, Gross Profit, Average Ticket, MoM Growth, YoY Growth, and previous-year comparisons
- Executive KPI cards
- Time-series analysis
- Product, category, customer segment, and geographic analysis
- Inventory coverage monitoring
- Interactive slicers, filters, bookmarks, and navigation
Tableau
Used as an additional visualization and analytical layer to explore sales, profitability, geographic performance, and inventory.

The Tableau analysis included:
- Monthly revenue trends
- Revenue and gross profit by category
- Top products by revenue
- City performance
- Inventory value by product
- Product-level stock coverage
- Geographic analysis
- Interactive filters and dashboard actions
- QA worksheets used to validate calculations and data blending
Analytical Workflow
The project followed an end-to-end analytical workflow designed to transform raw retail data into structured business insights.
1. Data Preparation and Transformation — SQL
The first stage focused on preparing and validating the data before analysis.

Key tasks included:
- Reviewing data quality
- Checking for duplicates and missing values
- Validating data types
- Joining sales, product, store, and inventory information
- Creating analytical datasets for revenue, profitability, geographic performance, and inventory
- Building monthly and yearly performance calculations
- Applying window functions such as RANK(), LAG(), and LEAD()
2. Exploratory Data Analysis — Python
Python was used to validate the transformed datasets and explore patterns before dashboard development.

The analysis included:
- Descriptive statistics
- Distribution analysis
- Outlier detection using the IQR method
- Transaction-level validation
- Revenue and profitability checks
- Exploratory visualizations
- Comparison of aggregated results with SQL outputs
3. Business Intelligence Modeling — Power BI
Power BI was used to build the main Business Intelligence solution.

This stage included:
- Data modeling using a star-schema approach
- Creation of DAX measures
- Development of key business KPIs
- Time-intelligence calculations
- Interactive filtering and navigation
- Executive and detailed dashboard views
- Inventory monitoring and commercial performance analysis
4. Data Visualization and Validation — Tableau
Tableau was used as an additional analytical and visualization layer.

The Tableau workflow included:
- Sales and profitability analysis
- Product and city rankings
- Geographic visualization
- Inventory value analysis
- Stock coverage analysis
- Interactive dashboard filters
- Data blending between sales and inventory sources
- QA worksheets to validate stock coverage and blended calculations
5. Business Interpretation
The final stage focused on translating analytical results into business insights.

The analysis was used to:
- Identify the strongest products and markets
- Detect underperforming areas
- Evaluate inventory risks
- Identify products with low or excessive stock coverage
- Compare commercial performance with inventory allocation
- Develop recommendations related to sales, profitability, and stock management
Workflow Summary
Raw Data → SQL → Python → Power BI → Tableau → Business Insights
Key KPIs
KPI	Result	Business Meaning
Total Revenue	$14.44M	Total sales generated during the analyzed period
Total COGS	$10.43M	Total cost associated with the products sold
Gross Profit	$4.01M	Profit generated before operating expenses
Gross Margin	27.79%	Percentage of revenue retained after covering product costs
Inventory Value	$300.21K	Total monetary value of inventory across stores
Total Stock On Hand	29,742 units	Total product units currently held in inventory
Average Months of Stock	0.86 months	Estimated average inventory coverage based on recent sales velocity


Inventory Coverage Classification
Products were classified according to estimated Months of Stock:
- Low Coverage: less than 0.5 months
- Medium Coverage: between 0.5 and 1.0 months
- High Coverage: more than 1.0 month
The analysis identified:
- 14 products with Low Coverage
- 8 products with Medium Coverage
- 13 products with High Coverage
Key Insights
1. Revenue is concentrated in a small group of products
Lego Bricks was the highest-revenue product, generating approximately $2.39M, followed by:
- Colorbuds — $1.56M
- Magic Sand — $0.97M
- Action Figure — $0.93M
- Rubik's Cube — $0.91M
This concentration indicates that a relatively small group of products plays a major role in overall commercial performance.
2. Toys is the largest category by revenue
The Toys category generated approximately $5.09M, making it the strongest category by total revenue.

However, revenue alone did not fully explain profitability. For example, Electronics generated lower revenue than Toys but produced approximately $1.00M in Gross Profit, showing the importance of evaluating both sales volume and margins.
3. Geographic performance varies significantly across cities
Ciudad de México was the strongest market, generating approximately $1.65M in revenue, followed by:
- Guadalajara — $1.32M
- Monterrey — $1.26M
- Hermosillo — $0.90M
- Guanajuato — $0.87M
This suggests that commercial activity is concentrated in several high-performing urban markets.
4. Inventory is not equally aligned with product demand
The company holds approximately $300.21K in inventory value across 29,742 units of stock.

When inventory was compared with recent sales velocity, the average coverage was approximately 0.86 months, indicating that stock availability differs considerably by product.
5. Several products present potential stockout risk
Products such as Dino Egg, Playfoam, Barrel O' Slime, Hot Wheels 5-Pack, and Splash Balls showed some of the lowest Months of Stock values.

These products may require closer replenishment monitoring if recent sales velocity continues.
6. Some products hold comparatively high inventory coverage
Several products maintain inventory coverage above one month, with some substantially exceeding that level.

This may indicate opportunities to review purchasing frequency, demand forecasts, and stock allocation to reduce unnecessary capital tied up in inventory.
7. Sales and inventory should be analyzed together
High-revenue products with low stock coverage may represent stockout risks, while products with higher stock coverage but weaker demand may represent excess inventory.

Combining sales performance with inventory coverage provides a stronger basis for replenishment and product-prioritization decisions.
Business Recommendations
1. Prioritize replenishment for low-coverage products
Products classified as Low Coverage should be monitored closely, especially those with strong recent sales performance.

Recommended actions:
- Review replenishment frequency
- Increase monitoring of fast-moving products
- Establish minimum stock thresholds
- Prioritize products that combine high demand with low coverage
2. Review products with high inventory coverage
Products with coverage above one month should be evaluated to determine whether current inventory levels are aligned with demand.

Recommended actions:
- Reduce purchasing frequency for slower-moving products
- Reallocate inventory between stores when possible
- Review demand forecasts
- Consider promotional strategies for products with excess coverage
3. Protect high-revenue products
Products such as Lego Bricks, Colorbuds, Magic Sand, Action Figure, and Rubik's Cube should receive greater attention in areas such as:
- Inventory availability
- Pricing strategy
- Store allocation
- Promotional planning
- Sales performance monitoring
4. Evaluate profitability alongside revenue
Management should monitor Revenue, Gross Profit, and Gross Margin together when evaluating performance.

This can help prevent commercial decisions from being based only on sales volume.
5. Strengthen high-performing geographic markets
Markets such as Ciudad de México, Guadalajara, and Monterrey generate a substantial share of company revenue.

Potential actions include:
- Ensuring sufficient stock availability
- Prioritizing high-performing products in these locations
- Evaluating whether successful commercial strategies can be replicated elsewhere
6. Investigate lower-performing cities
Cities with weaker revenue contribution should be analyzed further before reducing investment.

Additional analysis could consider:
- Store maturity
- Product assortment
- Customer demand
- Inventory availability
- Local promotions
- Store size and operating conditions
7. Integrate sales and inventory monitoring
A recurring monitoring process should combine:
- Revenue
- Gross Profit
- Sales growth
- Inventory Value
- Stock On Hand
- Months of Stock
This would allow the business to identify commercial opportunities and inventory risks more quickly.
Dashboards
The project includes interactive dashboards developed in both Power BI and Tableau.
Power BI — Executive Overview
<p align="center">
  <img src="images/powerbi_executive_overview.png" width="900">
</p>

The Power BI Executive Overview provides a consolidated view of business performance, including Revenue, Gross Profit, Gross Margin, Year-over-Year Growth, Inventory Value, monthly sales trends, product categories, top products, and geographic performance.

Additional Power BI views provide more detailed analysis of inventory, stock coverage, product prioritization, and operational performance.
Tableau — Sales & Profitability Overview
<p align="center">
  <img src="images/tableau_sales_profitability.png" width="900">
</p>

The Tableau Sales & Profitability Overview provides an interactive analysis of monthly revenue trends, category-level revenue and gross profit, top-performing products, and city performance.

Additional Tableau worksheets and dashboards explore inventory value, stock coverage, geographic analysis, and QA validations used during the analytical process.
The complete interactive analysis is available in the Power BI and Tableau project files included in this repository.

Project Structure
maven-toys-retail-analysis/
│
├── README.md
│
├── data/
│   ├── README.md
│   └── processed/
│       ├── tableau_inventory_enriched.csv
│       └── tableau_sales_enriched_sample.csv
│
├── sql/
│   └── maven_toys_analysis.sql
│
├── python/
│   └── maven_toys_analysis.ipynb
│
├── power-bi/
│   └── maven_toys_powerbi.pbix
│
├── tableau/
│   └── maven_toys_tableau.twb
│
└── images/
    ├── powerbi_executive_overview.png
    └── tableau_sales_profitability.png
Repository Contents
- data/ — Processed datasets used throughout the analysis. The full enriched sales dataset is omitted due to file-size limitations; a representative sample is included instead.
- sql/ — SQL workflow used for data validation, cleaning, transformations, KPI calculations, rankings, time-series analysis, and inventory coverage.
- python/ — Exploratory Data Analysis, validation, descriptive statistics, and outlier analysis.
- power-bi/ — Power BI report containing executive and inventory-focused dashboards.
- tableau/ — Tableau workbook containing sales, profitability, inventory, stock coverage, geographic analysis, and QA worksheets.
- images/ — Dashboard previews used in this README.
Skills Demonstrated
Data Analysis
- Data cleaning and validation
- Exploratory Data Analysis
- Descriptive statistics
- Outlier detection
- Business KPI development
- Trend analysis
- Product and geographic performance analysis
- Inventory and stock coverage analysis
SQL
- Data transformation and aggregation
- CTEs
- JOIN operations
- Window functions
- RANK()
- LAG() and LEAD()
- Month-over-Month analysis
- Year-over-Year analysis
- Product and geographic rankings
Python
- Pandas
- Matplotlib
- Data validation
- Descriptive analysis
- IQR-based outlier detection
- Exploratory visualizations
Power BI
- Data modeling
- Star schema
- DAX measures
- Time intelligence
- KPI development
- Interactive dashboards
- Slicers and filters
- Bookmarks and navigation
- Inventory analysis
Tableau
- Interactive dashboards
- Data blending
- Calculated fields
- Geographic analysis
- Ranking analysis
- Inventory visualization
- Dashboard actions and filters
- QA and validation worksheets
Business Intelligence
- Translating raw data into actionable insights
- Connecting commercial performance with inventory management
- Identifying business risks and opportunities
- Developing data-driven recommendations
- Communicating findings through executive dashboards
Author
David Sandoval

Junior Data Analyst / Business Intelligence Analyst focused on developing practical skills in SQL, Python, Power BI, Tableau, data visualization, and business analytics.

This project was developed as an independent end-to-end portfolio project to strengthen analytical thinking, Business Intelligence development, and the ability to transform business data into actionable insights.
