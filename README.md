# Customer Shopping Behavior Analysis

## 📌 Overview

This project analyzes customer shopping behavior to identify purchasing patterns, category performance, customer segments, and business insights. It combines Python, SQL, and Power BI to transform raw data into meaningful information that supports data-driven decision-making.

The project demonstrates the end-to-end data analytics workflow, from loading and cleaning data to querying, visualization, reporting, and presentation.

## 🎯 Objectives

- Understand customer purchasing behavior.
- Clean and validate the dataset.
- Perform Exploratory Data Analysis (EDA) using Python.
- Analyze customer and product trends using SQL.
- Build an interactive Power BI dashboard.
- Communicate findings through a report and presentation.

## 📊 Dataset

The dataset contains customer shopping information, including:

- Customer demographics, such as age and gender
- Products and product categories
- Purchase amounts and locations
- Seasons, sizes, and colors
- Review ratings and subscription status
- Shipping types, payment methods, and purchase frequency

**Dataset size:** 3,900 records and 18 columns.

## 🛠️ Tools & Technologies

- **Python:** Data loading, cleaning, EDA, and visualization
- **Pandas:** Data manipulation and analysis
- **Matplotlib:** Data visualization
- **SQL:** Data querying, aggregation, joins, and customer segmentation
- **MySQL:** Database management and SQL analysis
- **Power BI:** Interactive dashboards and KPI visualization
- **Microsoft Excel:** Data inspection and preliminary analysis
- **Gamma:** Presentation creation
- **GitHub:** Project version control and portfolio sharing

## 🔄 Project Workflow

### 1. Data Loading
- Imported the dataset into Python using Pandas.
- Loaded the data into the SQL database for querying and analysis.

### 2. Data Cleaning
- Checked for missing values and duplicate records.
- Investigated missing review ratings.
- Validated data types and values.
- Standardized column names for consistency.

### 3. Exploratory Data Analysis (EDA)
- Examined dataset structure and summary statistics.
- Analyzed purchase amounts and customer demographics.
- Compared sales across categories and locations.
- Explored purchasing frequency and customer behavior.

### 4. SQL Analysis
- Used aggregate functions such as `SUM()`, `AVG()`, and `COUNT()`.
- Applied filtering, grouping, sorting, and conditional logic.
- Analyzed category and seasonal performance.
- Segmented customers based on previous purchase history.

### 5. Power BI Dashboard
- Created KPI cards to summarize business performance.
- Visualized purchase amounts by category, gender, and season.
- Added slicers for interactive filtering.
- Compared location-level performance.

### 6. Reporting & Presentation
- Summarized key findings and business observations.
- Prepared a project report.
- Used Gamma to organize findings into a presentation.

## 📈 Dashboard

The Power BI dashboard provides an interactive view of customer shopping behavior.

**Key KPIs include:**
- Total Purchase Amount
- Total Purchases
- Average Purchase Amount
- Average Review Rating

### Dashboard Preview

 ![Customer Shopping Behavior Dashboard](./image/dashboard.png)
**Interactive report:** `Customer_Shopping_Analysis.pbix`

Open the `.pbix` file using Power BI Desktop to explore the report.

## 🔍 Key Results

- **Total purchase amount:** 233,081
- **Total purchases:** 3,900
- **Average purchase amount:** 59.76
- **Average review rating:** 3.75

### Category Performance

| Category | Total Purchase Amount | Share of Total |
|---|---:|---:|
| Clothing | 104,264 | 44.73% |
| Accessories | 74,200 | 31.83% |
| Footwear | 36,093 | 15.49% |
| Outerwear | 18,524 | 7.95% |

Clothing contributed the largest share of the total purchase amount, followed by Accessories. These findings help highlight the categories contributing most to overall purchasing activity.

## 💡 Business Value

This analysis helps demonstrate how customer data can be used to:

- Identify high-performing product categories.
- Understand customer purchasing patterns.
- Compare performance across locations and seasons.
- Monitor key performance indicators.
- Support evidence-based business decisions.

## ▶️ How to Run

### Prerequisites

Install Python, the required Python libraries, a supported SQL database, and Power BI Desktop.

### 1. Clone the Repository

```bash
git clone <your-github-repository-url>
cd Customer-Shopping-Behavior-Analysis
```

### 2. Install Python Libraries

```bash
pip install pandas matplotlib
```

Install any additional libraries imported by your Python script.

### 3. Run the Python Analysis

```bash
python Analyze.py
```

Ensure the CSV file path in the script matches the location of your dataset.

### 4. Run the SQL Queries

- Create or select your database.
- Import the dataset into the appropriate table.
- Open `SQL.sql` in your SQL client.
- Execute the queries using the correct database connection and syntax.

The current project uses MySQL. PostgreSQL and SQL Server may require syntax or connection adjustments.

### 5. Open the Power BI Dashboard

Open `Customer_Shopping_Analysis.pbix` in Power BI Desktop. If prompted, configure the appropriate data source connection.

## 📁 Project Structure

```text
Customer-Shopping-Behavior-Analysis/
├── data/
│   └── customer_shopping_behavior.csv
├── image/
│   └── dashboard.png
├── Analyze.py
├── SQL.sql
├── Customer_Shopping_Analysis.pbix
└── README.md
```

Adjust the filenames and folder structure above to match the actual repository.

## 👨‍💻 Author

**Piyush**

Aspiring Data Analyst | Python | SQL | Power BI | Excel

This project demonstrates practical skills in data cleaning, exploratory analysis, SQL querying, dashboard development, and business insight communication.
