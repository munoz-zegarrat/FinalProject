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
library(kableExtra)

setwd("~/Desktop/")
data <- read.csv(file='covid-data.csv',check.names=F,stringsAsFactors = F)

unique(data$continent)

##Cleaning the data
continents <- c("Asia", "Europe", "Africa", "North America", "South America")
clean_data <- data %>%
  filter(continent == continents)

clean_data[is.na(clean_data)] = 0  # removing NA values

countries <- c("India", "Indonesia", "Iran", "Turkey", "Philippines", "Russia", "United Kingdom", "Italy", "France", "Germany", "South Africa", "Tunisia", "Egypt", "Morocco", "Ethiopia", "United States", "Mexico", "Canada", "Guatemala", "Honduras", "Brazil", "Peru", "Colombia", "Argentina", "Chile")
clean_data2 <- clean_data %>%
  filter(location == countries)

unique(clean_data2$location)

Asia <- clean_data %>%
  filter (continent == "Asia")

Europe <- clean_data %>%
  filter (continent == "Europe")

Africa <- clean_data %>%
  filter (continent == "Africa")

North_America <- clean_data %>%
  filter (continent == "North America")

South_America <- clean_data %>%
  filter (continent == "South America")

clean_data2$total_tests
clean_data2$total_vaccinations

plot <- clean_data2 %>% 
  ggplot(aes (x = total_tests, y = total_vaccinations)) + geom_point() +
  labs (x = "Total Vaccinations", y = "Total Tests", title = "COVID-19 Vaccinations and Tests in Countries with Highest Mortality", color = "Region:", caption = "Source: Our World in Data, Johns Hopkins University") +
  theme_hc (base_size = 10) + scale_colour_hc() +
  geom_point(alpha = 0.7, data = Africa,
             aes(x = total_tests, y = total_vaccinations, colour = "Africa"), show.legend = TRUE) +
  geom_point(alpha = 0.7, data = Asia,
             aes(x = total_tests, y = total_vaccinations, colour = "Asia"), show.legend = TRUE) +
  geom_point(alpha = 0.7, data = Europe,
             aes(x = total_tests, y = total_vaccinations, colour = "Europe"), show.legend = TRUE) +
  geom_point(alpha = 0.7, data = North_America,
             aes(x = total_tests, y = total_vaccinations, colour = "North America"), show.legend = TRUE) +
  geom_point(alpha = 0.7, data = South_America,
             aes(x = total_tests, y = total_vaccinations, colour = "South America"), show.legend = TRUE) +
  scale_fill_manual (name = "Category", values = colors) +
  labs (caption = "Source: Our World in Data.")
  
  

(plot)
