with source as (
    select * from {{ source('ecom_raw', 'olist_payments') }}
),

renamed as (
    select
        order_id,
        payment_sequential,
        payment_type,
        cast(payment_installments as int64)     as payment_installments,
        cast(payment_value as numeric)          as payment_value
    from source
)

select * from renamed