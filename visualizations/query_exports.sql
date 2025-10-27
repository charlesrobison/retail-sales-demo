copy (select * from fct_sales) to 'exports/fct_sales.csv' (header, delimiter ',');

copy (select * from agg_customer_sales_summary) to 'exports/agg_customer_sales_summary.csv' (header, delimiter ',');

copy (select * from dim_customers) to 'exports/dim_customers.csv' (header, delimiter ',');

.open exports/retail_demo.sqlite
CREATE TABLE agg_customer_sales_summary AS SELECT * FROM read_csv_auto('exports/agg_customer_sales_summary.csv');

CREATE TABLE fct_sales AS SELECT * FROM read_csv_auto('exports/fct_sales.csv');

CREATE TABLE dim_customers AS SELECT * FROM read_csv_auto('exports/dim_customers.csv');

SELECT
    c.location,
    COUNT(DISTINCT f.customer_id) AS active_customers,
    ROUND(AVG(f.net_amount), 2) AS avg_purchase,
    SUM(f.net_amount) AS total_revenue
FROM fct_sales f
JOIN dim_customers c USING (customer_id)
GROUP BY 1
ORDER BY total_revenue DESC;

SELECT
    strftime('%Y-%m', purchase_date) AS month,
    SUM(net_amount) AS net_sales,
    SUM(discount_amount_inr) AS discounts
FROM fct_sales
GROUP BY 1
ORDER BY 1;

SELECT
    location,
    SUM(total_net_sales) AS total_sales,
    SUM(unique_customers) AS customers,
    SUM(total_net_sales)/SUM(unique_customers) as sales_per_customer
FROM agg_customer_sales_summary
GROUP BY 1
ORDER BY total_sales DESC;

SELECT
    product_category,
    SUM(total_net_sales) AS net_sales,
    SUM(total_discounts) AS discounts,
    SUM(total_discounts)/SUM(total_net_sales)*100 AS ratio
FROM agg_customer_sales_summary
GROUP BY 1
ORDER BY net_sales DESC;

SELECT
    gender,
    age_group,
    SUM(unique_customers) AS customers,
    SUM(total_net_sales) AS total_sales
FROM agg_customer_sales_summary
GROUP BY 1, 2
ORDER BY total_sales DESC;

SELECT 
  cast(c.customer_id as varchar) as cust_id,
  SUM(f.net_amount) AS total_spent
FROM fct_sales f
JOIN dim_customers c ON f.customer_id = c.customer_id
GROUP BY 1
ORDER BY total_spent DESC
LIMIT 10;
