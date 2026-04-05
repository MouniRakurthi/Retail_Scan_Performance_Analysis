use retail_db;
-- 1. Sales Performance Analysis (with Sales Channel)
-- Which products generate the highest revenue?
SELECT category, SUM(total_spent) AS Revenue
FROM retail_data
GROUP BY category
ORDER BY Revenue DESC;

-- Which products have the highest sales volume?
SELECT category , SUM(quantity) AS sales 
FROM retail_data 
GROUP BY category
ORDER BY sales DESC;

-- Which sales channel (Online vs In-store) generates the highest revenue and sales?
SELECT location , SUM(total_spent) AS Revenue, SUM(quantity) AS sales
FROM retail_data
WHERE location IN ("online", "In-store")
GROUP BY location 
ORDER BY Revenue DESC, sales DESC;

-- Which products perform best in each sales channel?
SELECT category, location, SUM(quantity) AS sales
FROM retail_data
GROUP BY category, location
ORDER BY sales DESC;
-- How does revenue change over time?
SELECT transaction_year AS years, SUM(total_spent) AS Revenue
FROM retail_data
GROUP BY years
ORDER BY Revenue DESC;
-- What is the contribution of top products to total revenue? (Pareto insight )_
SELECT category , SUM(total_spent) AS Product_Revenue,
(SUM(total_spent) * 100 / SUM(SUM(total_spent)) OVER()) AS contribution_percentage
FROM retail_data 
GROUP BY category
ORDER BY Product_Revenue DESC;

-- 2. Customer Purchasing Behavior
-- What is the total number of customers?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_data;

-- Who are the top customers by total spending?
SELECT customer_id, SUM(total_spent) AS spending
FROM retail_data 
GROUP BY customer_id
ORDER BY spending DESC;
-- Which customers purchase most frequently?
SELECT customer_id, COUNT(transaction_id) AS purchase_frequently
FROM retail_data 
GROUP BY customer_id
ORDER BY purchase_frequently DESC;

-- Do customers spend more in online or in-store purchases?
SELECT location,  AVG(total_spent) AS spending
FROM retail_data
GROUP BY location 
ORDER BY spending DESC;

-- Do a small number of customers contribute majority of revenue?
SELECT customer_id, SUM(total_spent) AS Revenue, (SUM(total_spent) * 100/SUM(SUM(total_spent)) OVER()) AS contribution_percentage
FROM retail_data
GROUP BY customer_id
ORDER BY Revenue DESC;

-- 3. Discount Analysis 
-- How does revenue compare between discounted and non-discounted transactions?
SELECT SUM(total_spent) AS Revenue, discount_applied
FROM retail_data 
GROUP BY discount_applied
ORDER BY Revenue DESC;

-- How many orders with and without discount with location ?
SELECT  discount_applied , location, COUNT(transaction_id) AS orders 
FROM retail_data
GROUP BY discount_applied, location
ORDER BY orders DESC;

-- Does discount increase quantity sold?
SELECT discount_applied, SUM(quantity) AS sales
FROM retail_data
GROUP BY discount_applied
ORDER BY sales DESC;

-- Which sales channel uses discounts more frequently?
SELECT discount_applied, COUNT(transaction_id) as frequent_purchase
FROM retail_data
GROUP BY discount_applied 
ORDER BY frequent_purchase DESC;

-- Do discounts perform better in online or in-store sales?
SELECT 
location,
discount_applied,
SUM(total_spent) AS revenue,
COUNT(transaction_id) AS orders,
AVG(total_spent) AS Avg_spent
FROM retail_data
GROUP BY location, discount_applied;

-- how discount usage changes over time ?
SELECT discount_applied, transaction_year AS Years,
COUNT(transaction_id) AS orders
FROM retail_data 
GROUP BY discount_applied, Years
ORDER BY orders DESC;

