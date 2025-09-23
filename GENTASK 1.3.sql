with combined_data as (select ad_date,
	coalesce(nullif(lower(substring(url_parameters from 'utm_campaign=([^&]+)')), 'nan'),'no data') as campaign,
	coalesce(value,0) as value
from facebook_ads_basic_daily
union all
select ad_date,
	coalesce(nullif(lower(substring(url_parameters from 'utm_campaign=([^&]+)')), 'nan'),'no data') as campaign,
	coalesce(value,0) as value
from google_ads_basic_daily),
weekly_value as (select campaign,
	date_trunc('week', ad_date)::date as week_start,
	SUM(value) as week_value
from combined_data
group by campaign, date_trunc('week', ad_date))
select campaign, week_start, week_value
from weekly_value
order by week_value desc
limit 1; 