with source as (
    select * from {{ source('ecom_raw', 'olist_products') }}
),
renamed as (
    select
        product_id,
        product_category_name           as category_name,
        cast(product_weight_g as numeric)   as weight_g,
        cast(product_length_cm as numeric)  as length_cm,
        cast(product_height_cm as numeric)  as height_cm,
        cast(product_width_cm as numeric)   as width_cm
    from source
)
select * from renamed