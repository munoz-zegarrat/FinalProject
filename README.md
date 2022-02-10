### FinalProject
## COVID-19 Vaccinations & Global Mortality Rates

# Scope of the Analysis
- What factors are exacerbating high mortality rates across the world? Which continents have been the most affected?
- In this study, I will look at the top 13-50 countries with the highest mortality rates across five continents (Africa, Asia, South and North America , and Europe), and analyze through regressions, visualizations and correlation analyzes the effects of some variables like the number of fully vaccinated people and the stringency index of countries.

# About the Data
- Source: Our World in Data - https://ourworldindata.org/coronavirus
- Description: Data on COVID-19 cases, deaths, hospitalizations, tests and other demographic factors for all countries. This data is updated daily by Our World in Data

# Important Links:
- Presentation Slides:  https://docs.google.com/presentation/d/19tO95s6eQeF7iPTg-51FxKZBQQrN8bqtwlwgJmoNm5s/edit#slide=id.g111b7f257b4_0_5
- Tableau Dashboard: https://public.tableau.com/app/profile/tiffany.munoz.zegarra/viz/COVID-19_16444601619820/COVID-19?publish=yes

# Results Summary
- Vaccination rates’ correlation with deaths are least correlated in Africa, moderately correlated in Asia, and highly correlated in North and South America. 
- Stringency measures, a composite of nine response indicators including school & workplace closures and travel bans in negatively correlated in South America, with weak positive correlation in all other continents. 
- With regards to testing, these seem to be moderately to low positively correlated with new cases and death across all sampled countries.
- People fully vaccinated, diabetes as a pre-existing condition, and stringency indexes explained up to 10% of the deaths according to the machine learning model in Europe and North America.
- On the country-level, the ML models were  a more fitted, particularly with the US and Russia. 
- While correlation does not reflect causation, we can infer that in high-level risks there seems to be other factors outside vaccines that have a stronger influence on total cases and deaths given the lower correlation values as opposed to low-risk sampled countries.


# Recommendations for Future Analysis
- Narrow the scope of countries/continents.
- Merge additional datasets to consider other independent variables that may be affecting the number of COVID cases and related deaths.
- Improved machine learning models to better fit continent-level data

