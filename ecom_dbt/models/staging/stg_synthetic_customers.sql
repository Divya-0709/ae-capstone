with source as (
    select * from {{ source('ecom_raw', 'synthetic_customers') }}
),

renamed as (
    select
        cast(`customer_id ` as string)      as customer_id,
        `customer_segment `                 as customer_segment,
        `region `                           as region,
        cast(`signup_date ` as date)        as signup_date,
        `ltv_tier `                         as ltv_tier
    from source
)

select * from renamed