Repo_week4

Part 1. dbt Snapshots

SELECT 
    order_id, 
    tracking_id,
    shipping_service,
    estimated_delivery_at,
    order_status,
    dbt_valid_from, 
    dbt_valid_to 
FROM snapshots.snap_orders
WHERE 
order_id in ('914b8929-e04a-40f8-86ee-357f2be3a2a2', '05202733-0e17-4726-97c2-0520c024ab85','939767ac-357a-4bec-91f8-a7b25edd46c9')
order by order_id,dbt_valid_from;

order_id	tracking_id	shipping_service	estimated_delivery_at	order_status	dbt_valid_from	dbt_valid_to
05202733-0e17-4726-97c2-0520c024ab85	NULL	NULL	NULL	preparing	2022-04-05T04:42:06.898657Z	2022-04-05T05:03:02.159438Z
05202733-0e17-4726-97c2-0520c024ab85	8404ed05-0128-4aeb-8ed5-6e44908875c4	ups	2021-02-19T10:15:26Z	NULL	2022-04-05T05:03:02.159438Z	NULL
914b8929-e04a-40f8-86ee-357f2be3a2a2	NULL	NULL	NULL	preparing	2022-04-05T04:42:06.898657Z	2022-04-05T05:03:02.159438Z
914b8929-e04a-40f8-86ee-357f2be3a2a2	a807fe66-d8b1-4d38-b409-558fed8bd75f	ups	2021-02-19T10:15:26Z	NULL	2022-04-05T05:03:02.159438Z	NULL
939767ac-357a-4bec-91f8-a7b25edd46c9	NULL	NULL	NULL	preparing	2022-04-05T04:42:06.898657Z	2022-04-05T05:03:02.159438Z
939767ac-357a-4bec-91f8-a7b25edd46c9	0a1177bd-5a6d-421b-a13d-11617ef68143	ups	2021-02-19T10:15:26Z	NULL	2022-04-05T05:03:02.159438Z	NULL

Part 2. Modeling challenge
CODE:
with funnel as (
select session_id,
count(distinct CASE WHEN is_page_view   = 1 THEN is_page_view ELSE NULL END) as session_started,
count(distinct CASE WHEN is_add_to_cart = 1 THEN is_add_to_cart ELSE NULL END) as add_to_cart,
count(distinct CASE WHEN is_checkout    = 1 THEN is_checkout ELSE NULL END) as checkout
from dbt_alejandro_o.fact_products
group by session_id
)

select sum (session_started), sum (add_to_cart),sum (checkout) 
from funnel

Session_started	addtocart	checkouts
578	467	361
100%	81%	77%

* How are our users moving through the product funnel?
R = important drop of 23% of users from session started to checkouts. A lot.
* Which steps in the funnel have largest drop off points?
R =f From session started to addtocart we see 19% perceptual points dropped (I think due to not every user has the intention to buy something any time he started a session) 


Part 3: Reflection questions -- please answer 3A or 3B, or both!

3A. dbt next steps for you
* if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization? - If we want transparency, scalability, reliable data and validations (all in) we definitly should use dbt
* if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course? - We don’t use dbt yet, but is a fact that we will
* if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step? - Documentation and code optimization

3B. Setting up for production / scheduled dbt run of your project
N/A