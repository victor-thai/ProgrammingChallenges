-- question 1 - sum of impressions by date 
select date, sum(impressions) as sum_impressions 
from pmg_assessment.marketing_data
group by date
order by date;

-- question 2 - top 3 revenue-generating states in order of best to worst [3rd top revenue Ohio = 37577]
-- The third top revenue state is Ohio with a value of 37577.
select state, sum(revenue) as Total_revenue from pmg_assessment.website_revenue
group by state
order by Total_revenue desc
limit 3;

-- question 3 - show total cost, impressions, clicks, revenue in each campaign
select name, total_cost, total_impressions, total_clicks, total_revenue
from
(select pmg_assessment.marketing_data.campaign_id, 
	sum(cost) as total_cost, 
    sum(impressions) as total_impressions, 
    sum(clicks) as total_clicks, 
    sum(revenue) as total_revenue
from pmg_assessment.marketing_data
inner join pmg_assessment.website_revenue
on pmg_assessment.marketing_data.date = pmg_assessment.website_revenue.date
group by pmg_assessment.marketing_data.campaign_id)
as total_campaigns
left join pmg_assessment.campaign_info
on total_campaigns.campaign_id = pmg_assessment.campaign_info.id;

-- question 4 - number of conversions of Campaign5 by state
-- The state that generated the highest number of conversions for Campaign5 is the state of Georgia.
select state, count(conversions)
from
(select distinct pmg_assessment.marketing_data.date, pmg_assessment.marketing_data.campaign_id, conversions, name
from pmg_assessment.marketing_data
left join pmg_assessment.campaign_info
on pmg_assessment.marketing_data.campaign_id = pmg_assessment.campaign_info.id
left join pmg_assessment.website_revenue
on pmg_assessment.marketing_data.campaign_id = pmg_assessment.website_revenue.campaign_id)
as campaign_marketing
left join pmg_assessment.website_revenue
on pmg_assessment.website_revenue.campaign_id = campaign_marketing.campaign_id
where name = "Campaign5"
group by state;

-- question 5
-- Through analyzing all different campaigns, I conclude that Campaign1 stands as the most efficient. Campaign1 has the most reasonable total_cost to clicks and revenue ratio.  Although revenue for Campaign3 is highest at 65429, it also required the highest cost. Campaign1 on the other hand captured a relatively similar total_revenue with a smaller amount of upfront cost. Comparing clicks, Campaign1 reached a greater audience than Campaign3. Campaign2 had the lowest cost needed of 357, but only reached 13729 in revenue which at a 4.5x increase to a similar cost as Campaign1, only takes in 61000 in revenue. In regards to Campaign4, its cost of 438 in comparison to Campaign1 is a 3.5x decrease so when applying that to revenue, would take in around 70000 in revenue. In campaign4, it’s important to note that click count would only receive a click count of 15000. This drawback would be the clicks or in other words the reach that the campaign would be able to reach. Lastly, campaign5 has a total cost of 775 which is a 2x difference in cost than campaign1. For its revenue, campaign5 would only be able to take in 50000 which is far too less than the other campaigns. In conclusion, Campaign1 is the most efficient campaign. 

-- question 6 bonus 
-- honestly, i am not too sure how to add in a day of the week column, but my approach initially to this task would be to find a way to add in a day of week given the date. After approaching this lack of weekday entry issue in our tables, I would focus on the sum of clicks for each week day to determine which weekday would be best to run ads. Something to consider for this task is that cost would also be a factor so it would be helpful to choose a weekday that also has the minimal costs for that respective weekday. 
