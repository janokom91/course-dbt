{{
  config(
    materialized='table'
  )
}}


SELECT user_id, 
first_name as user_firstname,
last_name as user_lastname,
email, 
phone_number as phone_num,
created_at, 
updated_at, 
address_id
FROM {{source('plants', 'users')}}
