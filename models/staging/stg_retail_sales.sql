{{ config(materialized='view') }}

with final as (

    select
        CID as customer_id,
        TID as transaction_id,
        Gender as gender,
        "Age Group" as age_group,
        "Purchase Date" as purchase_date,
        "Product Category" as product_category,
        "Discount Availed" as discount_availed,
        "Discount Name" as discount_name,
        "Discount Amount (INR)" as discount_amount_inr,
        "Gross Amount" as gross_amount,
        "Net Amount" as net_amount,
        "Purchase Method" as purchase_method,
        Location as location
    from retail_sales
    )

select * from final
