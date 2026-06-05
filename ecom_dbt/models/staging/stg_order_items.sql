with source as (
    select * from {{ source('ecom_raw', 'olist_order_items') }}
),

renamed as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        cast(price as numeric)                          as item_price,
        cast(freight_value as numeric)                  as freight_value,
        cast(price as numeric)
          + cast(freight_value as numeric)              as total_item_value,
        timestamp(shipping_limit_date)                  as shipping_limit_at
    from source
)

select * from renamed