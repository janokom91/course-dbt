{{
    config(materialized='table')
}}


SELECT order_id, 
product_id,
quantity
FROM {{source('plants', 'order_items')}}