with facebook_data as 
(select 'Facebook' as platform, ad_date, spend, impressions, clicks, reach, leads, value
from facebook_ads_basic_daily),
google_data as 
(select 'Google' as platform, ad_date, spend, impressions, clicks, reach, leads, value
from google_ads_basic_daily),
combined_data as
(select*
from facebook_data
union all
select*
from google_data)
select ad_date, platform,
ROUND(AVG(spend),2)as avg_spend,
ROUND(MAX(spend),2)as max_spend,
ROUND(MIN(spend),2)as min_spend,
ROUND(AVG(impressions),2)as avg_impressions,
ROUND(MAX(impressions),2)as max_impressions,
ROUND(MIN(impressions),2)as min_impressions,
ROUND(AVG(reach),2)as avg_reach,
ROUND(MAX(reach),2)as max_reach,
ROUND(MIN(reach),2)as min_reach,
ROUND(AVG(clicks),2)as avg_clicks,
ROUND(MAX(clicks),2)as max_clicks,
ROUND(MIN(clicks),2)as min_clicks,
ROUND(AVG(leads),2)as avg_leads,
ROUND(MAX(leads),2)as max_leads,
ROUND(MIN(leads),2)as min_leads,
ROUND(AVG(value),2)as avg_value,
ROUND(MAX(value),2)as max_value,
ROUND(MIN(value),2)as min_value
from combined_data
group by ad_date,platform
order by ad_date, platform;
