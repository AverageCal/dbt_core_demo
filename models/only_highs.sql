{{ config(materialized='view')}}

with high_low_ref as (

    select * from {{ ref('high_low_view') }}

),

pick_highs as (

    select * from high_low_ref
    where high_low = 'high'
    order by price desc
),

final as (

    select * from pick_highs

)

select * from final