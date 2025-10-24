copy (select * from fct_sales) to 'exports/fct_sales.csv' (header, delimiter ',');

copy (select * from agg_customer_sales_summary) to 'exports/agg_customer_sales_summary.csv' (header, delimiter ',');

copy (select * from dim_customers) to 'exports/dim_customers.csv' (header, delimiter ',');

.open exports/retail_demo.sqlite
CREATE TABLE agg_customer_sales_summary AS SELECT * FROM read_csv_auto('exports/agg_customer_sales_summary.csv');

CREATE TABLE fct_sales AS SELECT * FROM read_csv_auto('exports/fct_sales.csv');

CREATE TABLE dim_customers AS SELECT * FROM read_csv_auto('exports/dim_customers.csv');
