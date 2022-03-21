{{
  config(
    materialized='table'
  )
}}

SELECT
orders.order_id,
orders.address_id, 
orders.user_id, 
orders.promo_id, 
orders.created_at, 
orders.order_cost,
orders.shipping_cost,
orders.order_total,
orders.tracking_id,
orders.shipping_service,
orders.estimated_delivery_at,
orders.delivered_at,
orderit.product_id,
orderit.quantity,
promos.percentage_discount,
promos.discount_status
FROM {{ ref('stg_orders') }} orders
LEFT JOIN {{ ref('stg_order_items') }} orderit 
ON orders.order_id = orderit.order_id
LEFT JOIN {{ ref('stg_promos') }} promos 
ON orders.promo_id = promos.promo_id