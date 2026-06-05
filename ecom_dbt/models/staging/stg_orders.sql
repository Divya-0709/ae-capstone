with source as (
    select * from {{ source('ecom_raw', 'olist_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        order_status                                    as status,
        timestamp(order_purchase_timestamp)             as purchased_at,
        timestamp(order_approved_at)                    as approved_at,
        timestamp(order_delivered_carrier_date)         as shipped_at,
        timestamp(order_delivered_customer_date)        as delivered_at,
        timestamp(order_estimated_delivery_date)        as estimated_delivery_at,
        date(order_purchase_timestamp)                  as purchase_date
    from source
)

select * from renamed