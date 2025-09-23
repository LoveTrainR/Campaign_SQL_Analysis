with combined_data as (
select ad_date, spend, value
from facebook_ads_basic_daily
union all
select ad_date, spend, value
from google_ads_basic_daily)
select ad_date,
coalesce(ROUND(
case
	when SUM(spend) = 0 then 0
	else SUM(value)/SUM(spend)
end,2),0) as total_romi
from combined_data
group by ad_date
order by total_romi desc
limit 5;