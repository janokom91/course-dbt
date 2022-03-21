{{
  config(
    materialized='table'
  )
}}

SELECT 
users.user_id,
users.email,
events.event_id,
events.session_id,
events.event_type,
events.page_url,
events.created_at,
events.order_id,
events.product_id
FROM {{ ref('stg_users') }} users
LEFT JOIN {{ ref('stg_events') }} events 
ON users.user_id = events.user_id