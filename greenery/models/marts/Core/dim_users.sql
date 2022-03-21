{{
  config(
    materialized='table'
  )
}}


SELECT
users.user_id, 
CONCAT(users.user_firstname,' ', users.user_lastname) as user_name,
users.email, 
users.phone_num,
users.address_id,
addresses.address,
addresses.zipcode,
addresses.state,
addresses.country
FROM {{ ref('stg_users') }} users
LEFT JOIN {{ ref('stg_addresses') }} addresses
ON users.address_id = addresses.address_id