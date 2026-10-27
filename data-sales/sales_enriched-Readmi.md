# Data

This folder contains the processed datasets used throughout the Maven Toys retail analysis project.

## Included Files

- `tableau_inventory_enriched.csv` — Processed inventory dataset used for inventory value, stock levels, and stock coverage analysis.
- `tableau_sales_enriched_sample.csv` — Representative sample of the processed sales dataset used for sales, profitability, product, geographic, and time-series analysis.

## Full Sales Dataset

The complete `tableau_sales_enriched.csv` file is not included in this repository because its size exceeds the practical upload limit for the GitHub web interface.

A representative sample is provided instead so reviewers can inspect the dataset structure, column names, and analytical fields used in the project.

## Data Processing

The processed datasets were created from the original retail data through the analytical workflow documented in this repository.

Key transformations included:

- Data quality and integrity checks
- Product cost and price cleaning
- Sales and product joins
- Revenue, COGS, and Gross Profit calculations
- Geographic enrichment
- Inventory Value calculations
- Recent sales velocity calculations
- Months of Stock and stock coverage analysis

The complete SQL workflow is available in:

`../sql/maven_toys_analysis.sql`

Additional exploratory analysis and validation are available in the Python notebook included in the repository.

## Note

The sample dataset is intended for portfolio review and structural inspection. The complete analysis, KPIs, dashboards, and business conclusions were developed using the full processed dataset.
