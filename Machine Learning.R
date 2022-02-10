rm(list = ls())
#install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)
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
#install.packages("kernlab")
library(kernlab)
#install.packages("ISLR")
library(ISLR)
library(randomForest)

iris

setwd("~/Desktop/")
data <- read.csv(file='small_data.csv',check.names=F,stringsAsFactors = F)

data1 <- data %>%
  select(total_cases, total_deaths, total_vaccinations, total_tests, continent)

data1[is.na(data1)] = 0 

data1 <- data1 %>%
  mutate(total_cases = total_cases/100000) %>%
  mutate(total_vaccinations = total_vaccinations/100000) %>%
  mutate(total_tests = total_tests/100000) %>%
  mutate(total_deaths = total_deaths/100000)

data1 <- data1 %>%
  mutate(total_cases = as.numeric(total_cases)) %>%
  mutate(total_vaccinations = as.numeric(total_vaccinations)) %>%
  mutate(total_tests = as.numeric(total_tests)) %>%
  mutate(total_deaths = as.numeric(total_deaths)) %>%
  mutate(continent = as.factor(continent)) 


## Validation Data
# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(data1$continent, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- data1[-validation_index,]
# use the remaining 80% of data to training and testing the models
data1 <- data1[validation_index,]

#total_vaccinations <- lapply(data1$total_vaccinations, as.numeric)
#str(total_vaccinations)


#total_deaths <- lapply(data1$total_deaths, as.numeric)
#str(total_deaths)

#total_cases <- lapply(data1$total_cases, as.numeric)
#str(total_cases)

#new <- data.frame(total_cases, total_vaccinations, total_deaths, total_tests, location)
###Summarizing and Viewing the Data
dim(data1)

sapply(data1, class)
head(data1)
levels(data1$continent)


# summarize the class distribution
percentage <- prop.table(table(data1$continent)) * 100
cbind(freq=table(data1$continent), percentage=percentage)

##summmary
summary(data1)


##Visualize dataset
# split input and output
x <- data1[,1:4]
y <- data1[,5]

# boxplot for each attribute on one image
par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main=names(data1)[i])
}



# barplot for class breakdown
plot(y)


# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")

# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")

# density plots for each attribute by class value
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)


## Evaluate algorithms

# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

#linear algorithms
set.seed(7)
fit.lda <- train(continent~., data=data1, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(continent~., data=data1, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(continent~., data=data1, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(continent~., data=data1, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(continent~., data=data1, method="rf", metric=metric, trControl=control)


# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)

#compare accuracy of models
dotplot(results)

# summarize Best Model
print(fit.lda)


## Make predictions
# estimate skill of LDA on the validation dataset
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$continent)