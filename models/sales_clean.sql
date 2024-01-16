{{ config(materialized='table') }}

with sales_source as (

    select * from {{ source('sales_source','sales') }}
),

clean_columns as (

    select 
        id as order_id,
        purch_date as purchase_date,
        concat(fnme,' ',lname) as full_name,
        prdt as product,
        qty as quantity,
        price
    from sales_source
),

final as (

    select * from clean_columns
)

select * from final