{{ config(materialized='table') }}

with ranked as (

    select
        customer_id,
        gender,
        age_group,
        location,
        purchase_date,
        row_number() over (partition by customer_id order by purchase_date desc) as rn
    from {{ ref('stg_retail_sales') }}
),

final as (
    select
        customer_id,
        gender,
        age_group,
        location
    from ranked
    where rn = 1
)

select * from final
