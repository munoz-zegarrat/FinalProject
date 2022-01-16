# FinalProject

Does COVID-19 Have a Favorite?
The COVID-19 pandemic became the first non-influenza pandemic to affect more than 200 countries as declared in March of 2020. It has caused a worldwide panic since it negatively affected the economy, employment, healthcare systems, and more. In December 2020, the first COVID vaccine became FDA approved and available to those of 16 years and older which helped contribute to a decrease in hospitalizations all around the world as well as a reduction in cases.
	The purpose of this analysis is to test the multiple hypotheses of whether certain races/backgrounds have a higher risk of being infected with COVID-19, whether we can see a pattern when it comes to rural/urban areas, having been vaccinated or not, as well as consider the different age groups and death rates in order to find the factors that contribute the most to a higher risk of infection. This data is worldwide so we’ll be looking at a few countries in each continent to develop a better grasp of the data we are using.
	In order to obtain a better visualization, we will also be developing a map in order to view the cities/places with the highest cases and taking that into consideration when evaluating the other factors mentioned above.
	The data that we’re using for this analysis is contributed by Our World in Data which gives us data about the cases, deaths, vaccinations, and as well as testing for 241 countries around the world.


## Questions we want to find answers to:

** Analyze the efficiency of the test by comparing the number of new covid cases to the number of test performed
** Analyze the efficiency of the test by comparing the number of new covid deaths to the number of test performed
** Analyze the efficiency of the test by comparing the number of new covid cases to the number of vaccinated persons.
** Analyze the impact of the different covid variants In order to verify if Omicron is indeed more mild than the other variants.

## Database

** Data we are using and why:

We are using the data from “Our World in Data”(OWID) which is a project of the Global Change Data Lab, a non-profit organization based in the United Kingdom (Registered Charity Number 1186433)( https://ourworldindata.org)
OWID have created a github in order to collect on a daily basis the data of the covid-19 for 241 locations (by country, continent…).

Link: https://github.com/owid/covid-19-data 


## Machine Learning Model:

As vaccination is the main factual solution for the covid-19, we will build a supervised machine learning model to see if the number of vaccinated people can help predict the number of new cases.

