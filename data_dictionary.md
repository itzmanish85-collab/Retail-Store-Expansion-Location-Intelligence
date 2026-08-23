# Data Dictionary

## stores.csv
- store_id: unique existing store identifier
- city: store city
- region: broad geographic region
- annual_revenue: yearly sales revenue
- operating_cost: yearly operating costs
- profit: revenue minus operating cost
- profit_margin_pct: profit as a percentage of revenue
- annual_footfall: estimated annual visitors
- annual_rent: estimated yearly rent
- competitor_count: estimated competitor count in market

## candidate_locations.csv
- candidate_id: unique candidate market identifier
- city: potential expansion city
- region: broad geographic region
- population: estimated market population used for the synthetic model
- competitor_count: competitor count proxy
- avg_annual_income: income proxy
- market_growth_rate: synthetic growth rate
- demand_index: demand proxy
- expected_annual_revenue: expected first-year revenue proxy
- estimated_annual_rent: estimated annual rent proxy
- opportunity_score: weighted expansion score
- recommendation: High/Medium/Low Priority
- rank: ranking by opportunity score

## monthly_store_sales.csv
- store_id: existing store identifier
- month: month
- revenue: monthly store revenue
