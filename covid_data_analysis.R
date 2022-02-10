rm(list = ls())
#install.packages("tidyverse")
#install.packages("stats")
library(stats)
library(tidyverse)
#install.packages("jsonlite")
library(jsonlite)
#install.packages("ggplot2")
library(ggplot2)
library(ggcorrplot)
#install.packages("ggthemes")
library(ggthemes)
#install.packages("dplyr")
library(dplyr)
#install.packages("gridExtra")
library(gridExtra)
#install.packages("grid")
library(grid)
#install.packages("knitr")
library(knitr)
#install.packages("kableExtra")
#install.packages("mongolite")
#install.packages("lubridate")
library(mongolite)
library(lubridate)
#install.packages("glmnet")
library(glmnet)

setwd("~/Desktop/")
data <- read.csv(file='covid.csv',check.names=F,stringsAsFactors = F)

##Using MongoDB with R

database <- data.table::fread("covid_data.csv")
names(database)

names(database) = gsub(" ", "", names(mongod))
names(database)

my_collection = mongo(collection = "database", db  = "Covid")
my_collection$insert(database)

my_collection$count()

## Checking the number of countries per continent

SA <- data%>%
  filter(continent == "South America")

unique(SA$location)

NorthA <- data%>%
  filter(continent == "North America")

unique(NorthA$location)

Asia <- data%>%
  filter(continent == "Asia")

unique(Asia$location)

Africa <- data%>%
  filter(continent == "Africa")

unique(Africa$location)

Europe <- data%>%
  filter(continent == "Europe")

unique(Europe$location)


## uploading clean data with top 50 countries per continent with highest mortality

data2 <- read.csv(file='covid_clean2.csv',check.names=F,stringsAsFactors = F)

data2[is.na(data2)] = 0  # removing NA values


SA <- data2%>%
  filter(continent == "South America")

unique(SA$location)

NorthA <- data2%>%
  filter(continent == "North America")

unique(NorthA$location)

Asia <- data2%>%
  filter(continent == "Asia")

unique(Asia$location)

Africa <- data2%>%
  filter(continent == "Africa")

unique(Africa$location)

Europe <- data2%>%
  filter(continent == "Europe")

##Correlations
corr_plot <- data2 %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot

##Asia
used_matrix <- as.matrix(Asia[,c("total_deaths","people_fully_vaccinated","diabetes_prevalence", "stringency_index")]) #convert data frame into numeric matrix
cor(used_matrix)

corr_plot <- Asia %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot


##Africa

used_matrix <- as.matrix(Africa[,c("total_deaths","people_fully_vaccinated","diabetes_prevalence", "stringency_index")]) #convert data frame into numeric matrix
cor(used_matrix)

corr_plot <- Africa %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot


## Europe

used_matrix <- as.matrix(Europe[,c("total_deaths","people_fully_vaccinated","diabetes_prevalence", "stringency_index")]) #convert data frame into numeric matrix
cor(used_matrix)

corr_plot <- Europe %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot


## North America

used_matrix <- as.matrix(NorthA[,c("total_deaths","people_fully_vaccinated","diabetes_prevalence", "stringency_index")]) #convert data frame into numeric matrix
cor(used_matrix)

corr_plot <- NorthA %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot


## South America

used_matrix <- as.matrix(SA[,c("total_deaths","people_fully_vaccinated","diabetes_prevalence", "stringency_index")]) #convert data frame into numeric matrix
cor(used_matrix)

corr_plot <- SA %>%
  select(total_deaths, people_fully_vaccinated, diabetes_prevalence, stringency_index) %>%
  cor() %>%
  ggcorrplot()

corr_plot

## Multivariate Regressions

#Europe
lm <- lm(Europe$total_deaths ~ Europe$diabetes_prevalence + Europe$people_fully_vaccinated_per_hundred +Europe$stringency_index, data = Europe)
summary (lm)


Russia <- Europe %>%
  filter(location == "Russia") %>%
  mutate(total_deaths = total_deaths/population *100)

#ridge regression
y <-Russia$total_deaths

x <- data.matrix(Russia[,c('diabetes_prevalence', 'people_fully_vaccinated_per_hundred', 'stringency_index')])

model <- glmnet(x, y, alpha = 0)

summary(model)

#perform k-fold cross-validation to find optimal lambda value
cv_model <- cv.glmnet(x, y, alpha = 0)

#find optimal lambda value that minimizes test MSE
best_lambda <- cv_model$lambda.min
best_lambda

[1] 10.04567

#produce plot of test MSE by lambda value
plot(cv_model) 
## regressions
lm <- lm(total_deaths ~ people_fully_vaccinated_per_hundred,Russia)
summary (lm)

yvals <- lm$coefficients['people_fully_vaccinated_per_hundred']*Russia$people_fully_vaccinated_per_hundred +
  lm$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(Russia, aes(x=people_fully_vaccinated_per_hundred, y=total_deaths))
plot3 + geom_point(size =0.5) + geom_line(aes(y=yvals), color = "red")

## AFrica
lm <- lm(Africa$total_deaths ~ Africa$diabetes_prevalence + Africa$people_fully_vaccinated_per_hundred +Africa$stringency_index, data = Africa)
summary (lm)

SAfrica <- Africa %>%
  filter(location == "South Africa") %>%
  mutate(total_deaths = total_deaths/population *100)

#ridge regression
y <-SAfrica$total_deaths

x <- data.matrix(SAfrica[,c('diabetes_prevalence', 'people_fully_vaccinated_per_hundred', 'stringency_index')])

model <- glmnet(x, y, alpha = 0)

summary(model)

#perform k-fold cross-validation to find optimal lambda value
cv_model <- cv.glmnet(x, y, alpha = 0)

#find optimal lambda value that minimizes test MSE
best_lambda <- cv_model$lambda.min
best_lambda

[1] 10.04567

#produce plot of test MSE by lambda value
plot(cv_model) 

lm <- lm(total_deaths ~ people_fully_vaccinated_per_hundred,SAfrica)
summary (lm)

yvals <- lm$coefficients['people_fully_vaccinated_per_hundred']*SAfrica$people_fully_vaccinated_per_hundred +
  lm$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(SAfrica, aes(x=people_fully_vaccinated_per_hundred, y=total_deaths))
plot3 + geom_point(size =0.5) + geom_line(aes(y=yvals), color = "red")

## Asia

lm <- lm(Asia$total_deaths ~ Asia$diabetes_prevalence + Asia$people_fully_vaccinated_per_hundred +Asia$stringency_index, data = Asia)
summary (lm)

India <- Asia %>%
  filter(location == "India") %>%
  mutate(total_deaths = total_deaths/population *100)

#ridge regression
y <-India$total_deaths

x <- data.matrix(India[,c('diabetes_prevalence', 'people_fully_vaccinated_per_hundred', 'stringency_index')])

model <- glmnet(x, y, alpha = 0)

summary(model)

#perform k-fold cross-validation to find optimal lambda value
cv_model <- cv.glmnet(x, y, alpha = 0)

#find optimal lambda value that minimizes test MSE
best_lambda <- cv_model$lambda.min
best_lambda

[1] 10.04567

#produce plot of test MSE by lambda value
plot(cv_model) 

lm <- lm(total_deaths ~ people_fully_vaccinated_per_hundred,India)
summary (lm)

yvals <- lm$coefficients['people_fully_vaccinated_per_hundred']*India$people_fully_vaccinated_per_hundred +
  lm$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(India, aes(x=people_fully_vaccinated_per_hundred, y=total_deaths))
plot3 + geom_point(size =0.5) + geom_line(aes(y=yvals), color = "red")


##NOrth America

lm <- lm(NorthA$total_deaths ~ NorthA$diabetes_prevalence + NorthA$people_fully_vaccinated_per_hundred +NorthA$stringency_index, data = NorthA)
summary (lm)

USA <- NorthA %>%
  filter(location == "United States") %>%
  mutate(total_deaths = total_deaths/population *100)

#ridge regression
y <-USA$total_deaths

x <- data.matrix(USA[,c('diabetes_prevalence', 'people_fully_vaccinated_per_hundred', 'stringency_index')])

model <- glmnet(x, y, alpha = 0)

summary(model)

#perform k-fold cross-validation to find optimal lambda value
cv_model <- cv.glmnet(x, y, alpha = 0)

#find optimal lambda value that minimizes test MSE
best_lambda <- cv_model$lambda.min
best_lambda

[1] 10.04567

#produce plot of test MSE by lambda value
plot(cv_model) 

lm <- lm(total_deaths ~ people_fully_vaccinated_per_hundred,USA)
summary (lm)

yvals <- lm$coefficients['people_fully_vaccinated_per_hundred']*USA$people_fully_vaccinated_per_hundred +
  lm$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(USA, aes(x=people_fully_vaccinated_per_hundred, y=total_deaths))
plot3 + geom_point(size =0.5) + geom_line(aes(y=yvals), color = "red")


## South America

lm <- lm(SA$total_deaths ~ SA$diabetes_prevalence + SA$people_fully_vaccinated_per_hundred +SA$stringency_index, data = SA)
summary (lm)

brazil <- SA %>%
  filter(location == "Brazil") %>%
  mutate(total_deaths = total_deaths/population *100)

#ridge regression
y <-brazil$total_deaths

x <- data.matrix(brazil[,c('diabetes_prevalence', 'people_fully_vaccinated_per_hundred', 'stringency_index')])

model <- glmnet(x, y, alpha = 0)

summary(model)

#perform k-fold cross-validation to find optimal lambda value
cv_model <- cv.glmnet(x, y, alpha = 0)

#find optimal lambda value that minimizes test MSE
best_lambda <- cv_model$lambda.min
best_lambda

[1] 10.04567

#produce plot of test MSE by lambda value
plot(cv_model) 

lm <- lm(total_deaths ~ people_fully_vaccinated_per_hundred,brazil)
summary (lm)

yvals <- lm$coefficients['people_fully_vaccinated_per_hundred']*brazil$people_fully_vaccinated_per_hundred +
  lm$coefficients['(Intercept)'] #determine y-axis values from linear model

plot3 <- ggplot(brazil, aes(x=people_fully_vaccinated_per_hundred, y=total_deaths))
plot3 + geom_point(size =0.5) + geom_line(aes(y=yvals), color = "red")
