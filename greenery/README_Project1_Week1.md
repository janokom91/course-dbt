Analytics Engineering - Using dbt

Project 1 - Week 1


--Question 1: "How many users do we have?"

select count(distinct user_id) as total_users
from dbt_alejandro_o.stg_users;

--R: 130

----------------------

--Question 2: "On average, how many orders do we receive per hour?"

with orders_per_hr as 
(
select date_trunc('hour',created_at) as hour_created,
count(distinct order_id) as total_orders
from dbt_alejandro_o.stg_orders
group by hour_created
)

select avg(total_orders) as avg_orders_per_hr
from orders_per_hr

--R: 7.5208333333333333 orders per hour on average

----------------------

--Question 3: "On average, how long does an order take from being placed to being delivered?"

select avg(delivered_at - created_at) as time_to_delivered
from dbt_alejandro_o.stg_orders
where order_status = 'delivered'

--R: 3 days & 21 hours & 24 min takes an order to be delivered on average

----------------------

--Question 4: "How many users have only made one purchase? Two purchases? Three+ purchases?"

with order_by_users as
(
select user_id,
count(distinct order_id) as total_orders
from dbt_alejandro_o.stg_orders
group by user_id
)

select total_orders,
count(distinct user_id) as total_users
from order_by_users
group by total_orders


--R: 1 order -> 25 users
--   2 orders -> 28 users
--   3 orders -> 34 users 
--   4 orders -> 20 users 
--   5+ orders -> 17 orders

----------------------

--Question 5: "On average, how many unique sessions do we have per hour?"

with session_per_hr as (
select date_trunc('hour',created_at) as hour_created,
count(distinct session_id) as unique_session
from dbt_alejandro_o.stg_events
group by hour_created
)

select avg(unique_session)
from session_per_hr

--R: 16.327 unique session per hour on average

----------------------
