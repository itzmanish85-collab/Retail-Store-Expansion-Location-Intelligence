# Power BI Dashboard Specification

## Page 1 — Executive Overview
Cards:
- Total Revenue
- Total Profit
- Average Profit Margin
- Store Count
- Average Annual Footfall

Visuals:
- Monthly Revenue Trend
- Revenue by Region
- Top 10 Stores by Revenue

## Page 2 — Existing Store Performance
Visuals:
- Scatter: Footfall vs Revenue
- Bar: Profit by City
- Bar: Profit Margin by Store
- Matrix: Region → City → Store

Slicers:
- Region
- City

## Page 3 — Market & Competition
Visuals:
- Bubble/scatter: Competitor Count vs Expected Revenue
- Bar: Candidate Opportunity Score
- Bar: Market Growth Rate by Candidate City
- Table: Candidate city, demand, competition, expected revenue

## Page 4 — Expansion Recommendation
Main table:
Rank | City | Opportunity Score | Expected Revenue | Rent | Competition | Recommendation

Use conditional formatting on Opportunity Score.

## Suggested DAX measures

Total Revenue =
SUM(stores[annual_revenue])

Total Profit =
SUM(stores[profit])

Average Margin =
AVERAGE(stores[profit_margin_pct])

Store Count =
DISTINCTCOUNT(stores[store_id])

Expected Revenue =
SUM(candidate_locations[expected_annual_revenue])

High Priority Markets =
CALCULATE(
    DISTINCTCOUNT(candidate_locations[city]),
    candidate_locations[recommendation] = "High Priority"
)

## Dashboard story
Start with current performance → identify market gaps → compare candidate markets → finish with ranked expansion recommendations.
