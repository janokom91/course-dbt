Analytics Engineering - Using dbt

Project 2 - Week 2

-- What is our user repeat rate?
-- Repeat Rate = Users who purchased 2 or more times / users who purchased

with orders_users as 
(
select user_id, count(order_id) as tot_orders
from dbt_alejandro_o.stg_orders
group by user_id
) 
select cast(sum(case when tot_orders >1 then 1 else 0 end) as decimal) / count(tot_orders) as repeat_rate
from orders_users

-- R: 0.7983 --> 79.83%

-- What are good indicators of a user who will likely purchase again? 
-- R: I would look at the total of amount spent by user (more amount spent, the more likely to comeback), also the usage of promos or not 
(I guess users that first purchase without promo are more likely to return. Of course, there must be validation using some functions. 

-- What about indicators of users who are likely NOT to purchase again? 
-- R: Days since last purchase (the more the days, the more decrease the chance to purchase again). Users that waited to long for recieving their order.

-- If you had more data, what features would you want to look into to answer this question?
-- R: Segmentations, variation models, linear regressions, LTV model, and others.

-- Explain the marts models you added. Why did you organize the models in the way you did?
-- R: First of all, there are the three folder types(the ones that were suggested). Within the first one, the "Core" folder you'll find dim_users, 
dim_products and fact_orders. The both dim files will describe all about users and products in each. Dim_users is a join between stg_users & stg_address.
And dim_products has everything on stg_products.The fact_orders model is a join between stg_orders, stg_order_items and stg_promos. Then, within marketing 
and product folders I create one fact table in each of them. (as well as it's yml file.

<img width="1161" alt="Pasted Graphic 1" src="https://user-images.githubusercontent.com/100712644/159192145-70b3e5aa-66b5-41a1-b515-395f7373b5a6.png">


-- What assumptions are you making about each model? (i.e. why are you adding each test?)
-- R: Im assuming, in almost all the "stg" tables that there is a possibility of having null values. And secondly, im assuming that some discounts may be 
loaded as negative numbers and that could be a super problem.
-- Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
-- R: No, every key on every table is not_null and all the discounts are positive values.
-- Apply these changes to your github repo
