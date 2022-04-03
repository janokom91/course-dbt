Repo_week3

PART 1: Create new models to answer the first two questions (answer questions in README file)

* What is our overall conversion rate?

62.46%

Code:
with purchase_sessions as (
select count(distinct session_id) as sessions
from dbt_alejandro_o.stg_events
where event_type = 'checkout'
),

total_sessions as (
select count(distinct session_id)
as sessions
from dbt_alejandro_o.stg_events
)

select
round(((purchase_sessions.sessions::numeric / total_sessions.sessions::numeric) * 100), 2) as conversion_rate
from purchase_sessions, total_sessions;


* What is our conversion rate by product?

product_name	conversion_rate
String of pearls	60.94
Arrow Head	55.56
Cactus	54.55
ZZ Plant	53.97
Bamboo	53.73
Rubber Plant	51.85
Monstera	51.02
Calathea Makoyana	50.94
Fiddle Leaf Fig	50
Majesty Palm	49.25
Aloe Vera	49.23
Devil's Ivy	48.89
Philodendron	48.39
Jade Plant	47.83
Spider Plant	47.46
Pilea Peperomioides	47.46
Dragon Tree	46.77
Money Tree	46.43
Orchid	45.33
Bird of Paradise	45
Ficus	42.65
Birds Nest Fern	42.31
Pink Anthurium	41.89
Boston Fern	41.27
Alocasia Polly	41.18
Peace Lily	40.91
Ponytail Palm	40
Snake Plant	39.73
Angel Wings Begonia	39.34
Pothos	34.43


select
product_name,
round(count(distinct 
case 
when is_checkout = 1 then session_id
else null
end)::numeric / count(distinct session_id) * 100, 2) AS conversion_rate
from dbt_alejandro_o.fact_products
group by product_name
order by conversion_rate desc

Why might certain products be converting at higher/lower rates than others?
R= I might say it has to be with a lot of things such as the popularity of some items versus others, the need for some items than others, the price of the items, and for sure maybe there is something about the UX at Greenery’s internet page that is not working well.

PART 2: Create a macro to simplify part of a model(s).
R= I already created a macro named col_values that help a lot in create a flag (1,0) based on the status that each event has reached (event_type) and it is part of my staging model of fact_products

Part 3: Add a post hook to your project to apply grants to the role “reporting”.
R= I added a hook on-run-end  that GRANT USAGE to reporting as was explained in the video. Thanks!

Part 4: Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project.
I successfully installed two but I just used from dot-utils (already installed the function “group_by” :) in one of my marts models
  - package: calogica/dbt_expectations    version: 0.5.4
  - package: dbt-labs/codegen    version: 0.6.0

PART 5: Show your DAG 
(it is attached)

￼



