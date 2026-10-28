
import matplotlib.pyplot as plt
import pandas as pd

df = pd.read_csv("customer_shopping_behavior.csv")
df.columns = df.columns.str.strip().str.lower().str.replace(' ','_').str.replace('-',"_")
df = df.rename(columns={'purchase_amount_(usd)' : 'purchase_amount'})
missing_rating = df[df["review_rating"].isnull()]


print("Number of Missing ratings", len(missing_rating))
print("\nMissing ratings by categoty:")
print(missing_rating["category"].value_counts())

print("\nPurchase amounts for missing ratings:")
print(missing_rating["purchase_amount"].describe())

print("Numberial Summery:")
print(df.describe())


# 1. Check whether customer IDs are unique
print("Duplicate customer IDs:", df["customer_id"].duplicated().sum())

# 2. Check for ratings outside the expected 1–5 range
invalid_ratings = df[
    df["review_rating"].notna()
    & ~df["review_rating"].between(1, 5)
]
print("Invalid ratings:", len(invalid_ratings))

# 3. Check missing values in every column
print("\nMissing values by column:")
print(df.isnull().sum())


# Sales performance by category
category_analysis = (
    df.groupby("category")
    .agg(
        total_sales=("purchase_amount", "sum"),
        average_purchase=("purchase_amount", "mean"),
        number_of_purchases=("purchase_amount", "count")
    )
    .sort_values("total_sales", ascending=False)
)

# Calculate each category's percentage of total sales
category_analysis["sales_share_pct"] = (
    category_analysis["total_sales"]
    / df["purchase_amount"].sum()
    * 100
).round(2)

print("SALES PERFORMANCE BY CATEGORY")
print(category_analysis.round(2))



# Plot total purchase amount by category
category_analysis["total_sales"].sort_values().plot(
    kind="barh",
    figsize=(9, 5),
    title="Total Purchase Amount by Category"
)

plt.xlabel("Total Purchase Amount")
plt.ylabel("Category")
plt.tight_layout()
plt.show()


# Regional performance analysis
region_analysis = (
    df.groupby("location")
    .agg(
        total_sales=("purchase_amount", "sum"),
        average_purchase=("purchase_amount", "mean"),
        number_of_purchases=("purchase_amount", "count")
    )
    .sort_values("total_sales", ascending=False)
)

region_analysis["sales_share_pct"] = (
    region_analysis["total_sales"]
    / df["purchase_amount"].sum()
    * 100
).round(2)

print("REGIONAL PERFORMANCE")
print(region_analysis.round(2))


# Select the top 10 locations
top_10_regions = region_analysis.head(10)

# Create a bar chart
top_10_regions["total_sales"].sort_values().plot(
    kind="barh",
    figsize=(10, 6),
    title="Top 10 Locations by Total Purchase Amount"
)

plt.xlabel("Total Purchase Amount")
plt.ylabel("Location")
plt.tight_layout()
plt.show()

# Purchase amount by location and category
location_category = df.pivot_table(
    index="location",
    columns="category",
    values="purchase_amount",
    aggfunc="sum",
    fill_value=0
)

# Show the top 10 locations by total purchase amount
top_locations = region_analysis.head(10).index

print(location_category.loc[top_locations].round(2))


# Compare category contributions across the top 10 locations
location_category.loc[top_locations].plot(
    kind="bar",
    stacked=True,
    figsize=(12, 6),
    title="Purchase Amount by Category Across Top 10 Locations"
)

plt.xlabel("Location")
plt.ylabel("Total Purchase Amount")
plt.xticks(rotation=45, ha="right")
plt.legend(title="Category")
plt.tight_layout()
plt.show()




# Average purchase amount by purchase frequency
frequency_analysis = (
    df.groupby("frequency_of_purchases")
    .agg(
        average_purchase_amount=("purchase_amount", "mean"),
        number_of_purchases=("purchase_amount", "count")
    )
    .sort_values("average_purchase_amount", ascending=False)
)

print("PURCHASE FREQUENCY ANALYSIS")
print(frequency_analysis.round(2))
