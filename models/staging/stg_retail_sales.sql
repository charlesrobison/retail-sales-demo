{{ config(materialized='view') }}

with final AS (

SELECT
    CID AS customer_id,
    TID AS transaction_id,
    Gender AS gender,
    "Age Group" AS age_group,
    "Purchase Date" AS purchase_date,
    "Product Category" AS product_category,
    "Discount Availed" AS discount_availed,
    "Discount Name" AS discount_name,
    "Discount Amount (INR)" AS discount_amount_inr,
    "Gross Amount" AS gross_amount,
    "Net Amount" AS net_amount,
    "Purchase Method" AS purchase_method,
    Location AS location
FROM retail_sales
)

SELECT * FROM final
