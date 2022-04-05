{{
  config(
    materialized='table'
  )
}}

select
events.session_id,
events.user_id,
COALESCE(events.product_id, orderit.product_id) AS product_id,
prod.product_name,
prod.product_price,
prod.inventory,
{{col_values(ref('stg_events'),'event_type')}}
FROM {{ ref('stg_events') }} events
LEFT JOIN {{ ref('stg_order_items') }} orderit 
ON events.order_id = orderit.order_id
LEFT JOIN {{ ref('stg_products') }} prod 
ON COALESCE(events.product_id, orderit.product_id) = prod.product_id
{{ dbt_utils.group_by(n=6) }}