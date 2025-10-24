{{ config(materialized='table') }}

with final as (

    select
        transaction_id,
        customer_id,
        product_category,
        purchase_date,
        purchase_method,
        discount_name,
        discount_amount_inr,
        gross_amount,
        net_amount,
        net_amount - gross_amount AS discount_diff,
        (gross_amount - net_amount) / gross_amount AS discount_rate
    from {{ ref('stg_retail_sales') }}
)

select * from final
