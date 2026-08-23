import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

stores = pd.read_csv("data/stores.csv")
candidates = pd.read_csv("data/candidate_locations.csv")
monthly = pd.read_csv("data/monthly_store_sales.csv")

print("Shape:", stores.shape)
print("\nMissing values:\n", stores.isna().sum())
print("\nDuplicate rows:", stores.duplicated().sum())
print("\nTop stores by revenue:\n", stores.nlargest(10, "annual_revenue")[["store_id","city","annual_revenue","profit_margin_pct"]])

# 1. Revenue distribution
plt.figure(figsize=(9,5))
sns.histplot(stores["annual_revenue"], kde=True)
plt.title("Annual Revenue Distribution")
plt.tight_layout()
plt.show()

# 2. Revenue vs footfall
plt.figure(figsize=(9,5))
sns.scatterplot(data=stores, x="annual_footfall", y="annual_revenue", hue="region")
plt.title("Revenue vs Annual Footfall")
plt.tight_layout()
plt.show()

# 3. Correlation
num_cols=["annual_revenue","operating_cost","profit","profit_margin_pct","annual_footfall","annual_rent","competitor_count"]
plt.figure(figsize=(10,7))
sns.heatmap(stores[num_cols].corr(), annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Store KPI Correlation Matrix")
plt.tight_layout()
plt.show()

# 4. Candidate ranking
top = candidates.head(10)
print("\nTop 10 candidate locations:\n", top[["rank","city","opportunity_score","recommendation"]])

# 5. Monthly trend
monthly["month"]=pd.to_datetime(monthly["month"])
trend=monthly.groupby("month",as_index=False)["revenue"].sum()
plt.figure(figsize=(10,5))
sns.lineplot(data=trend,x="month",y="revenue",marker="o")
plt.title("Monthly Revenue Trend")
plt.tight_layout()
plt.show()
