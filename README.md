# Customer Shopping Behavior Analysis

![Customer Shopping Behavior Dashboard](./image/dashboard.png)

## Project Overview

This project analyzes customer shopping behavior to identify purchasing patterns, compare product categories, explore seasonal trends, and understand differences between customer groups.

The project uses Excel, MySQL, Python, and Power BI to move from data quality checks to business analysis and interactive visualization.

## Business Objectives

- Analyze total and average purchase amounts.
- Identify the product categories contributing the most to total purchase amount.
- Compare purchasing patterns across seasons, genders, and locations.
- Explore differences between subscribers and non-subscribers.
- Present key metrics and findings through an interactive Power BI dashboard.

## Dataset

- **Records:** 3,900
- **Columns:** 18
- **Subject:** Customer shopping behavior

The dataset includes customer demographics, product categories, purchase amounts, locations, seasons, review ratings, subscription status, shipping types, payment methods, and purchase frequency.

## Tools Used

- **Microsoft Excel:** Initial data inspection, cleaning checks, and exploratory analysis.
- **MySQL:** SQL queries, aggregations, grouping, filtering, and business analysis.
- **Python:** Pandas-based data quality checks, summaries, and exploratory analysis.
- **Power BI:** KPI cards, charts, slicers, and interactive dashboard design.

## Data Quality Checks

The analysis included checks for missing values, duplicate records, unique customer IDs, and consistency between columns.

Key findings:

- 37 missing values were found in `review_rating`, representing approximately 0.95% of the dataset.
- No full-row duplicates were identified.
- `customer_id` was unique in the dataset.
- `discount_applied` and `promo_code_used` contained identical values across the dataset and were flagged as potentially redundant fields.
- Missing review ratings were not replaced with invented values.

## Key Findings

### Overall Metrics

|Metric| Result  |
|------|--------:|
| Total purchase amount| 233,081 |
| Total purchases| 3,900   |
| Average purchase amount| 59.76   |
| Average review rating| 3.75    |

The average review rating is calculated from non-missing ratings. The currency unit for purchase amounts was not verified.

### Purchase Amount by Category

|  Category | Total purchase amount |
|-----------|----------------------:|
| Clothing    |        104,264        |
| Accessories |        74,200         |
| Footwear    |        36,093         |
| Outerwear   |        18,524         |

Clothing had the highest total purchase amount, while Outerwear had the lowest.

### Purchase Amount by Season

| Season | Total purchase amount |
|--------|----------------------:|
| Fall   |         60,018        |
| Spring |         58,679        |
| Winter |         58,607        |
| Summer |         55,777        |

Fall recorded the highest total purchase amount, while Summer recorded the lowest. The differences are descriptive and do not establish that season caused the purchasing patterns.

### Subscription Comparison

| Subscription status | Average purchase amount |
|---------------------|------------------------:|
|          No         | 59.87                   |
|          Yes        | 59.49                   |

Average purchase amounts were similar between subscribers and non-subscribers. This comparison alone does not establish whether subscription status affects spending.

## Power BI Dashboard

The dashboard includes four KPI cards:

- Total Purchase Amount
- Total Purchases
- Average Purchase Amount
- Average Review Rating

It also includes four charts:

- Purchase Amount by Category
- Purchase Amount by Gender
- Purchase Amount by Season
- Top 5 Locations by Purchase Amount

Interactive slicers allow users to filter the report by category, season, and gender.

## Project Workflow

1. Inspected the dataset and checked data quality in Excel.
2. Used MySQL to query and aggregate customer shopping data.
3. Used Python and Pandas for data quality checks and exploratory analysis.
4. Built an interactive Power BI dashboard to communicate the findings.

## Limitations

- The dataset describes observed shopping records; it does not establish causal relationships.
- Missing review ratings may affect rating-based analysis.
- Identical discount and promo-code fields may limit the ability to compare their separate effects.
- The currency unit was not verified.
- The dataset's patterns may not represent all customers or retailers.

## Conclusion

This project demonstrates an end-to-end data analysis workflow, from data quality checks and SQL analysis to Python exploration and Power BI visualization. It highlights differences in purchase amounts across product categories, seasons, and subscription groups while documenting data quality considerations and analytical limitations.

## Skills Demonstrated

Excel · SQL · MySQL · Python · Pandas · Exploratory Data Analysis · Data Cleaning · Data Visualization · Power BI · DAX · Business Reporting
