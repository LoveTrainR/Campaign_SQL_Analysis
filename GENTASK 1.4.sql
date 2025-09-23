with combined_data as (select ad_date,
coalesce(nullif(lower(substring(url_parameters from 'utm_campaign=([^&]+)')), 'nan'),'no data') as campaign,
coalesce(reach, 0) as reach
from facebook_ads_basic_daily
union all
select ad_date,
coalesce(nullif(lower(substring(url_parameters from 'utm_campaign=([^&]+)')), 'nan'),'no data') as campaign,
coalesce(reach, 0) as reach
from google_ads_basic_daily),
monthly_reach as ( select campaign,
date_trunc('month', ad_date)::date as month_start,SUM(reach) as total_reach
from combined_data
group by campaign, date_trunc('month', ad_date)),
monthly_growth as (select campaign,month_start,total_reach,
coalesce(abs(total_reach - lag(total_reach) over (partition by campaign order by month_start)),0) as diff
from monthly_reach)
select campaign, month_start, diff as growth
from monthly_growth
order by diff desc
limit 1;