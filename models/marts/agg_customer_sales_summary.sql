{{ config(materialized='table') }}

with final as (
    select
        f.customer_id,
        c.gender,
        c.age_group,
        c.location,
        f.product_category,
        f.gross_amount,
        f.net_amount,
        f.discount_amount_inr
    from {{ ref('fct_sales') }} f
    join {{ ref('dim_customers') }} c
        using (customer_id)
)

select
    gender,
    age_group,
    location,
    product_category,
    count(distinct customer_id) as unique_customers,
    count(*) as total_transactions,
    sum(gross_amount) as total_gross_sales,
    sum(net_amount) as total_net_sales,
    sum(discount_amount_inr) as total_discounts,
    round(sum(net_amount) / nullif(sum(gross_amount), 0), 3) as avg_discount_ratio
from final
group by
    gender,
    age_group,
    location,
    product_category
order by total_net_sales desc
