with olist_customers as (
    select * from {{ ref('stg_customers') }}
),

synthetic as (
    select * from {{ ref('stg_synthetic_customers') }}
)

select
    o.customer_id,
    o.customer_unique_id,
    o.city,
    o.state,
    o.zip_code,
    s.customer_segment,
    s.region,
    s.signup_date,
    s.ltv_tier
from olist_customers o
left join synthetic s using (customer_id)