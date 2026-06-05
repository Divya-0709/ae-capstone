with source as (
    select * from {{ source('ecom_raw', 'olist_reviews') }}
),

renamed as (
    select
        review_id,
        order_id,
        safe_cast(review_score as int64)        as review_score,
        review_comment_title                    as comment_title,
        review_comment_message                  as comment_message
    from source
)

select * from renamed