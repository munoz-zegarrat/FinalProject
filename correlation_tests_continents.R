# Libraries and Working Directory ----
library(stats)
#install.packages("ggcorrplot")
#install.packages("kableExtra")
library(kableExtra)
library(ggcorrplot)
library(ggplot2)
library(tidyverse)


# Downloading and cleaning the data

setwd("~/Desktop/")
covid_data <- read.csv(file = "owid-covid-data.csv")

covid_data[is.na(covid_data)] = 0  # removing NA values

##Per Continent Datasets

unique (covid_data$continent)

africa <- covid_data %>% 
  filter (continent == "Africa")

asia <- covid_data %>% 
  filter (continent== "Asia")

europe <- covid_data %>% 
  filter (continent == "Europe")

north_america <- covid_data %>% 
  filter (continent == "North America")

oceania <- covid_data %>%
  filter (location == "Oceania")

south_america <- covid_data %>% 
  filter (location == "South America")


##Africa

cor(africa$total_tests, africa$total_deaths)  ##0.8619983
cor(africa$new_tests, africa$total_deaths)  ##0.6830054
cor(africa$total_tests, africa$total_deaths) 
cor(africa$new_vaccinations, africa$total_deaths)  #0.2304838
cor(africa$new_vaccinations, africa$total_cases)   #0.2615599
cor(africa$new_vaccinations, africa$new_cases_per_million)  #0.01757191
cor(africa$new_vaccinations, africa$new_deaths) # 0.1582801


#correlation table  
africa %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
africa %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(africa, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(africa)

## linear regression
lm(new_deaths ~ new_vaccinations, africa)

summary(lm(new_deaths ~ new_vaccinations, africa))


model <- lm(new_deaths ~ new_vaccinations, africa)
yvals <- model$coefficients['new_vaccinations']*africa$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(africa, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, africa)
summary(lm(new_deaths ~ new_vaccinations + new_tests, africa))



##Asia

cor(asia$new_tests, asia$total_deaths)  ##NA
cor(asia$new_vaccinations, asia$total_deaths)  #0.876193
cor(asia$new_vaccinations, asia$total_cases)   #0.8917369
cor(asia$new_vaccinations, asia$new_cases)  #0.4892791
cor(asia$new_vaccinations, asia$new_deaths) # 0.60083

#correlation table  
asia%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
asia %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(asia, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(asia)

## linear regression
lm(new_deaths ~ new_vaccinations, asia)

summary(lm(new_deaths ~ new_vaccinations, asia))


model <- lm(new_deaths ~ new_vaccinations, asia)
yvals <- model$coefficients['new_vaccinations']*asia$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(asia, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, asia)
summary(lm(new_deaths ~ new_vaccinations + new_tests, asia))


asia %>%
  select(new_vaccinations, total_cases) %>%
  ggplot(aes( x = new_vaccinations, y = total_cases)) +
  geom_count() +
  labs (title = "Total Cases vs. New Vaccinations: Asia")


##Europe

cor(europe$new_tests, europe$total_deaths)  ##NA
cor(europe$new_vaccinations, europe$total_deaths)  #0.8259523
cor(europe$new_vaccinations, europe$total_cases)   #0.7977759
cor(europe$new_vaccinations, europe$new_cases)  #0.3370136
cor(europe$new_vaccinations, europe$new_deaths) #0.1371674

#correlation table  
europe%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
europe%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(europe, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(europe)

## linear regression
lm(new_deaths ~ new_vaccinations, europe)

summary(lm(new_deaths ~ new_vaccinations, europe))


model <- lm(new_deaths ~ new_vaccinations, europe)
yvals <- model$coefficients['new_vaccinations']*europe$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(europe, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, europe)
summary(lm(new_deaths ~ new_vaccinations + new_tests, europe))


#stats::cor(europe$new_vaccinations, europe$total_cases)

#europe %>%
#  select(new_vaccinations, total_cases) %>%
 # ggplot(aes( x = new_vaccinations, y = total_cases)) +
  #geom_count()

##Oceania

cor(oceania$new_tests, oceania$total_deaths)  ##NA
cor(oceania$new_vaccinations, oceania$total_deaths)  #0.6275218
cor(oceania$new_vaccinations, oceania$total_cases)   #0.5323914
cor(oceania$new_vaccinations, oceania$new_cases)  #0.2031988
cor(oceania$new_vaccinations, oceania$new_deaths) #0.7112072

#correlation table  
oceania%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
oceania%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(oceania, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(oceania)

## linear regression
lm(new_deaths ~ new_vaccinations, oceania)

summary(lm(new_deaths ~ new_vaccinations, oceania))


model <- lm(new_deaths ~ new_vaccinations, oceania)
yvals <- model$coefficients['new_vaccinations']*oceania$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(oceania, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, oceania)
summary(lm(new_deaths ~ new_vaccinations + new_tests, oceania))


stats::cor(oceania$new_vaccinations, oceania$total_cases)

oceania %>%
  select(new_vaccinations, total_cases) %>%
  ggplot(aes( x = new_vaccinations, y = total_cases)) +
  geom_count() +
  labs (title = "Total Cases vs. New Vaccinations: Oceania")

##north america
cor(north_america$new_tests, north_america$total_deaths)  ##NA
cor(north_america$new_vaccinations, north_america$total_deaths)  #0.7472083
cor(north_america$new_vaccinations, north_america$total_cases)   #0.7305433
cor(north_america$new_vaccinations, north_america$new_cases)  #0.1763652
cor(north_america$new_vaccinations, north_america$new_deaths) #0.1434836

#correlation table  
north_america%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
north_america%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(north_america, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(north_america)

## linear regression
lm(new_deaths ~ new_vaccinations, north_america)

summary(lm(new_deaths ~ new_vaccinations, north_america))


model <- lm(new_deaths ~ new_vaccinations, north_america)
yvals <- model$coefficients['new_vaccinations']*north_america$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(north_america, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, north_america)
summary(lm(new_deaths ~ new_vaccinations + new_tests, north_america))

stats::cor(north_america$new_vaccinations, north_america$total_cases)

north_america %>%
  select(new_vaccinations, total_cases) %>%
  ggplot(aes( x = new_vaccinations, y = total_cases)) +
  geom_count()

##south america

cor(south_america$new_tests, south_america$total_deaths)  ##NA
cor(south_america$new_vaccinations, south_america$total_deaths)  #0.8030482
cor(south_america$new_vaccinations, south_america$total_cases)   #0.8043843
cor(south_america$new_vaccinations, south_america$new_cases)  #0.1207158
cor(south_america$new_vaccinations, south_america$new_deaths) #0.0809147

#correlation table  
south_america%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
south_america%>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(south_america, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(south_america)

## linear regression
lm(new_deaths ~ new_vaccinations, south_america)

summary(lm(new_deaths ~ new_vaccinations, south_america))


model <- lm(new_deaths ~ new_vaccinations, south_america)
yvals <- model$coefficients['new_vaccinations']*south_america$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(south_america, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, south_america)
summary(lm(new_deaths ~ new_vaccinations + new_tests, south_america))

stats::cor(south_america$new_vaccinations, south_america$total_cases)

south_america %>%
  select(new_vaccinations, total_cases) %>%
  ggplot(aes( x = new_vaccinations, y = total_cases)) +
  geom_count()



var(covid_data$new_vaccinations)
