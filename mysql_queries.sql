-- Retail Store Expansion & Location Intelligence
CREATE DATABASE IF NOT EXISTS retail_expansion;
USE retail_expansion;

CREATE TABLE stores (
  store_id VARCHAR(10) PRIMARY KEY,
  city VARCHAR(50),
  region VARCHAR(30),
  annual_revenue DECIMAL(15,2),
  operating_cost DECIMAL(15,2),
  profit DECIMAL(15,2),
  profit_margin_pct DECIMAL(6,2),
  annual_footfall INT,
  annual_rent DECIMAL(15,2),
  competitor_count INT
);

CREATE TABLE candidate_locations (
  candidate_id VARCHAR(10) PRIMARY KEY,
  city VARCHAR(50),
  region VARCHAR(30),
  population INT,
  competitor_count INT,
  avg_annual_income DECIMAL(12,2),
  market_growth_rate DECIMAL(6,4),
  demand_index DECIMAL(8,2),
  expected_annual_revenue DECIMAL(15,2),
  estimated_annual_rent DECIMAL(15,2),
  market_size_index DECIMAL(15,2),
  raw_score DECIMAL(10,2),
  demand_score DECIMAL(8,2),
  growth_score DECIMAL(8,2),
  income_score DECIMAL(8,2),
  competition_score DECIMAL(8,2),
  cost_score DECIMAL(8,2),
  opportunity_score DECIMAL(8,2),
  recommendation VARCHAR(30),
  rank_no INT
);

CREATE TABLE monthly_store_sales (
  store_id VARCHAR(10),
  month DATE,
  revenue DECIMAL(15,2),
  FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

-- 1. Top stores
SELECT store_id, city, annual_revenue, profit_margin_pct
FROM stores
ORDER BY annual_revenue DESC
LIMIT 10;

-- 2. Regional performance
SELECT region,
       SUM(annual_revenue) AS revenue,
       SUM(profit) AS profit,
       AVG(profit_margin_pct) AS avg_margin
FROM stores
GROUP BY region
ORDER BY revenue DESC;

-- 3. High-profit stores
SELECT *
FROM stores
WHERE profit_margin_pct >= 25
ORDER BY profit DESC;

-- 4. Revenue per footfall
SELECT store_id, city,
       annual_revenue / NULLIF(annual_footfall,0) AS revenue_per_visitor
FROM stores
ORDER BY revenue_per_visitor DESC;

-- 5. Candidate locations ranked by opportunity
SELECT rank_no, city, opportunity_score, recommendation
FROM candidate_locations
ORDER BY opportunity_score DESC
LIMIT 10;

-- 6. High opportunity / low competition
SELECT city, opportunity_score, competitor_count, expected_annual_revenue
FROM candidate_locations
WHERE competition_score >= 60
  AND opportunity_score >= 65
ORDER BY opportunity_score DESC;

-- 7. Revenue concentration
WITH ranked AS (
  SELECT city, annual_revenue,
         SUM(annual_revenue) OVER() AS total_revenue
  FROM stores
)
SELECT city, annual_revenue,
       ROUND(annual_revenue/total_revenue*100,2) AS revenue_share_pct
FROM ranked
ORDER BY annual_revenue DESC;

-- 8. Store rank within region
SELECT store_id, city, region, annual_revenue,
       DENSE_RANK() OVER(PARTITION BY region ORDER BY annual_revenue DESC) AS regional_rank
FROM stores;

-- 9. Monthly trend
SELECT DATE_FORMAT(month,'%Y-%m') AS month,
       SUM(revenue) AS total_revenue
FROM monthly_store_sales
GROUP BY DATE_FORMAT(month,'%Y-%m')
ORDER BY month;

-- 10. Candidate ROI proxy
SELECT city,
       opportunity_score,
       expected_annual_revenue,
       estimated_annual_rent,
       ROUND((expected_annual_revenue-estimated_annual_rent)/
             NULLIF(expected_annual_revenue,0)*100,2) AS revenue_after_rent_pct
FROM candidate_locations
ORDER BY opportunity_score DESC;
