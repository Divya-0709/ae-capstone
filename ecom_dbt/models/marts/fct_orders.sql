with orders as (
    select * from {{ ref('int_orders_enriched') }}
),

customers as (
    select * from {{ ref('int_customers_enriched') }}
),

reviews as (
    select
        order_id,
        avg(review_score)               as avg_review_score
    from {{ ref('stg_reviews') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    c.customer_segment,
    c.region,
    c.ltv_tier,
    c.state,
    o.status,
    o.purchase_date,
    o.item_count,
    o.order_value,
    o.total_paid,
    o.payment_type,
    o.installments,
    o.delivery_days,
    r.avg_review_score
from orders o
left join customers c using (customer_id)
left join reviews r using (order_id)