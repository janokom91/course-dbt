{{
  config(
    materialized='table'
  )
}}

SELECT 
users.user_id,
users.created_at, 
users.updated_at, 
users.address_id,
orders.shipping_cost,
orders.order_total,
orders.tracking_id,
orders.shipping_service,
orders.estimated_delivery_at,
orders.delivered_at
FROM {{ ref('stg_users') }} users
LEFT JOIN {{ ref('stg_orders') }} orders 
ON users.user_id = orders.user_id