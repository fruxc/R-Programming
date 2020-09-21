#loading the data and libraries
library(e1071)
library(caTools)

data(iris)

#splitting the data for training and testing purpose

split <- sample.split(iris, SplitRatio = 0.7)
train <- subset(iris, split = TRUE)
test <- subset(iris, split = FALSE)

#creating naive bayes model

myModel <- naiveBayes(train[, 1:4], train[, 5])

table(predict(myModel, test[, -5]), test[, 5], dnn = list('Predicted', 'Actual')) #returns the confusion matrix

myModel$apriori
