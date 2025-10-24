{{ config(materialized='table') }}

with final as (

    select distinct
        product_category
    from {{ ref('stg_retail_sales') }}
)

select * from final
