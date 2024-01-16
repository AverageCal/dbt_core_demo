with sales_source as (

    select * from {{ source('sales_source','sales')}}

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

high_low as (

    select *,
        case
            when price > (select avg(price) FROM sales_source) then 'high' else 'low' end as high_low
    from clean_columns

),

final as (

    select * from high_low

)

select * from final