setwd("~/Desktop/")
#install.packages("tidyverse")
library(tidyverse)
#install.packages("jsonlite")
library(jsonlite)
#install.packages("ggplot2")
library(ggplot2)
library(ggcorrplot)
#install.packages("knitr")
library(knitr)
#install.packages("kableExtra")
library(kableExtra)

## Reading in data
data <- read.csv(file='owid-covid-data.csv',check.names=F,stringsAsFactors = F)
unique(data$location)

##Cleaning the data
country1 <- c("Cyprus", "Dominican Republic", "Jordan", "Gambia", "Palestine", "Oman")
clean_data <- data %>%
  filter(location == country1)

clean_data[is.na(clean_data)] = 0  # removing NA values

corr_plot <- clean_data %>%
  select(total_tests, total_vaccinations, total_cases, total_deaths) %>%
  cor() %>%
  ggcorrplot()

corr_plot

used_matrix <- as.matrix(clean_data[,c("total_tests","total_vaccinations","total_cases", "total_deaths")]) #convert data frame into numeric matrix
cor(used_matrix)

## Simple Correlation Totals

cor(clean_data$new_tests, clean_data$total_deaths)
cor(clean_data$new_tests, clean_data$total_deaths)
cor()
cor(clean_data$new_vaccinations, clean_data$total_deaths)
cor(clean_data$new_vaccinations, clean_data$total_cases)
cor(clean_data$new_vaccinations, clean_data$new_cases)
cor(clean_data$new_vaccinations, clean_data$new_deaths)

## Simple Correlations and Correlation Matrices by Country: 

####Cyprus

Cyprus <- clean_data %>%
  filter(location == "Cyprus")
cor(Cyprus$total_vaccinations, Cyprus$total_deaths)
cor(Cyprus$new_tests, Cyprus$new_cases)  ##0.8588347  ~~~
cor(Cyprus$total_tests, Cyprus$total_cases)
cor(Cyprus$total_tests, Cyprus$total_deaths)
cor(Cyprus$new_vaccinations, Cyprus$total_deaths)  #0.172534 
cor(Cyprus$new_vaccinations, Cyprus$total_cases)   #0.15667
cor(Cyprus$new_vaccinations, Cyprus$new_cases)  #-0.009565621  ~~~
cor(Cyprus$new_vaccinations, Cyprus$new_deaths)# 0.07692827
cor(Cyprus$total_vaccinations, Cyprus$total_cases)
#correlation table  
Cyprus %>%
  select(new_vaccinations, total_vaccinations, new_tests, total_tests, new_cases, new_deaths, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
Cyprus %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot

plot <- ggplot(Cyprus, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(Cyprus)

## linear regression
lm(total_deaths ~ new_vaccinations, Cyprus)

summary(lm(total_deaths ~ new_vaccinations, Cyprus))


model <- lm(new_deaths ~ new_vaccinations, Cyprus)
yvals <- model$coefficients['new_vaccinations']*Cyprus$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(Cyprus, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, Cyprus)
summary(lm(new_deaths ~ new_vaccinations + new_tests, Cyprus))



####Dominican Republic

DR <- clean_data %>%
  filter(location == "Dominican Republic")
cor(DR$total_vaccinations, DR$total_deaths)
cor(DR$new_tests, DR$total_deaths)  ##-0.3526708 ~~~
cor(DR$total_tests, DR$total_cases)
cor(DR$total_tests, DR$total_deaths)
cor(DR$new_vaccinations, DR$total_deaths)  #0.4134829 ~~~
cor(DR$new_vaccinations, DR$total_cases)   #0.3921272 ~~
cor(DR$new_vaccinations, DR$new_cases)  #0.05828214  ~~~
cor(DR$new_vaccinations, DR$new_deaths) #-0.1454495  ~~~
cor(DR$total_vaccinations, DR$total_cases)
#correlation table  
DR %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
DR %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot
plot <- ggplot(DR, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(DR)

## linear regression
lm(total_deaths ~ new_vaccinations, clean_data)

summary(lm(total_deaths ~ new_vaccinations, clean_data))


model <- lm(new_deaths ~ new_vaccinations, DR)
yvals <- model$coefficients['new_vaccinations']*DR$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(DR, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red") 

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, DR)
summary(lm(new_deaths ~ new_vaccinations + new_tests, DR))

#Summary Statistics
summary <- DR %>%
  summarize(mean = mean(total_cases),
            median = median(total_cases),
            sd = sd(total_cases),
            var = var(total_cases),
            n = n(),
            max = max (total_cases),
            min = min (total_cases),
            p95 = quantile(total_cases, p=.95),
            p05 = quantile(total_cases, p=.05))

kable(summary) %>%
  kable_styling()


####Jersey

jersey <- clean_data %>% filter(location == "Jordan")
cor(jersey$total_vaccinations, jersey$total_deaths)
cor(jersey$total_tests, jersey$total_deaths)
cor(jersey$total_tests, jersey$total_cases)
cor(jersey$new_tests, jersey$total_deaths)  ##0.246661
cor(jersey$new_vaccinations, jersey$total_deaths)  #0.4278447 ~~~
cor(jersey$new_vaccinations, jersey$total_cases)   #0.4081917 ~~
cor(jersey$new_vaccinations, jersey$new_cases)  #-0.077544322  ~~~
cor(jersey$new_vaccinations, jersey$new_deaths) #-0.09371803  ~~~
cor(jersey$total_vaccinations, jersey$total_cases)
#correlation table  
jersey %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
jersey %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot
plot <- ggplot(jersey, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(jersey)

## linear regression
lm(new_deaths ~ new_vaccinations, jersey)

summary(lm(new_deaths ~ new_vaccinations, jersey))


model <- lm(new_deaths ~ new_vaccinations, jersey)
yvals <- model$coefficients['new_vaccinations']*jersey$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(jersey, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(total_deaths ~ new_vaccinations + new_tests, jersey)
summary(lm(total_deaths ~ new_vaccinations + new_tests, jersey))



####Gambia



gambia <- clean_data %>% filter(location == "Gambia")
cor(gambia$total_vaccinations, gambia$total_deaths)
cor(gambia$total_tests, gambia$total_deaths)
cor(gambia$total_tests, gambia$total_cases)
cor(gambia$new_tests, gambia$total_deaths)  ##0.246661
cor(gambia$new_vaccinations, gambia$total_deaths)  #0.4278447 ~~~
cor(gambia$new_vaccinations, gambia$total_cases)   #0.4081917 ~~
cor(gambia$new_vaccinations, gambia$new_cases)  #-0.077544322  ~~~
cor(gambia$new_vaccinations, gambia$new_deaths) #-0.09371803  ~~~
cor(gambia$total_vaccinations, gambia$total_cases)
#correlation table  
gambia %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
gambia %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot
plot <- ggplot(gambia, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(gambia)

## linear regression
lm(total_deaths ~ new_vaccinations, gambia)

summary(lm(total_deaths ~ new_vaccinations, gambia))


model <- lm(new_deaths ~ new_vaccinations, gambia)
yvals <- model$coefficients['new_vaccinations']*gambia$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(gambia, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, gambia)
summary(lm(new_deaths ~ new_vaccinations + new_tests, gambia))


####Palestine

palestine <- clean_data %>% filter(location == "Palestine")
cor(palestine$total_vaccinations, palestine$total_deaths)
cor(palestine$new_tests, palestine$total_deaths)
cor(palestine$new_tests, palestine$total_cases)
cor(palestine$new_tests, palestine$total_deaths)  ##0.4527794 ~~
cor(palestine$new_vaccinations, palestine$total_deaths)  #0.3124883 ~~~
cor(palestine$new_vaccinations, palestine$total_cases)   #0.3107783 ~~
cor(palestine$new_vaccinations, palestine$new_cases)  #-0.4345  ~~~
cor(palestine$new_vaccinations, palestine$new_deaths) #0.05616979  ~~~
cor(palestine$total_vaccinations, palestine$total_cases)
#correlation table  
palestine %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
palestine %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot
plot <- ggplot(palestine, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(palestine)

## linear regression
lm(total_deaths ~ new_vaccinations, palestine)

summary(lm(total_deaths ~ new_vaccinations, palestine))


model <- lm(new_deaths ~ new_vaccinations, palestine)
yvals <- model$coefficients['new_vaccinations']*palestine$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(palestine, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, palestine)
summary(lm(new_deaths ~ new_vaccinations + new_tests, palestine))

    
####Oman

oman <- clean_data %>% filter(location == "Oman")
cor(oman$total_vaccinations, oman$total_deaths)
cor(oman$new_tests, oman$total_deaths)
cor(oman$new_tests, oman$total_cases)
cor(oman$new_tests, oman$total_deaths)  ##-0.3495639 ~~
cor(oman$new_vaccinations, oman$total_deaths)  #-0.04667731 ~~~
cor(oman$new_vaccinations, oman$total_cases)   #-0.04429738 ~~
cor(oman$new_vaccinations, oman$new_cases)  #-0.09481398  ~~~
cor(oman$new_vaccinations, oman$new_deaths) #-0.05540772  ~~~
cor(oman$total_vaccinations, oman$total_cases)
#correlation table  
oman %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor()

#correlation plot matrix   
oman %>%
  select(new_vaccinations, new_tests, new_cases, new_deaths, hosp_patients, total_deaths, total_cases) %>%
  cor() %>%
  ggcorrplot()

# Plot
plot <- ggplot(oman, aes(x=new_vaccinations, y= new_deaths))
plot + geom_point()
plot1 <- ggplot(oman)

## linear regression
lm(total_deaths ~ new_vaccinations, oman)

summary(lm(total_deaths ~ new_vaccinations, oman))


model <- lm(new_deaths ~ new_vaccinations, oman)
yvals <- model$coefficients['new_vaccinations']*oman$new_vaccinations +
  model$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(oman, aes(x=new_vaccinations, y=new_deaths))
plot3 + geom_point() + geom_line(aes(y=yvals), color = "red")

## multiple linear regression
lm(new_deaths ~ new_vaccinations + new_tests, oman)
summary(lm(new_deaths ~ new_vaccinations + new_tests, oman)) # R-squared: 0.003961, p-val: 0.8007




#Summary Statistics of Sample Countries
summary <- clean_data %>%
  group_by(location) %>%
  summarize(mean = mean(total_cases),
            median = median(total_cases),
            sd = sd(total_cases),
            var = var(total_cases),
            n = n(),
            max = max (total_cases),
            min = min (total_cases),
            p95 = quantile(total_cases, p=.95),
            p05 = quantile(total_cases, p=.05))

kable(summary) %>%
  kable_styling()

##Quality Test of Normality

ggplot (clean_data, aes(x = new_vaccinations)) + geom_density()

ggplot (clean_data, aes(x = new_deaths)) + geom_density()
ggplot (clean_data, aes(x = new_cases)) + geom_density()

ggplot (clean_data, aes(x = total_cases)) + geom_density()

## Quantitative Case for Normality

shapiro.test(clean_data$new_tests)



mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot

