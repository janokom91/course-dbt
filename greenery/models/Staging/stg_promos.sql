{{
  config(
    materialized='table'
  )
}}


SELECT promo_id,
discount as percentage_discount,
status as discount_status
FROM {{source('plants', 'promos')}}