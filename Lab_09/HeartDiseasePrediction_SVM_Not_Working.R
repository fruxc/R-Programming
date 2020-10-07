## Loading libs
library('caret')
library('dplyr')
library('e1071')
library('kernlab')

## Loading dataset
heart_df  <- read.csv("E:/SPIT/R_Practicals/Lab_09/heart.csv", sep=',', header = FALSE)
str(heart_df)
head(heart_df)
dim(heart_df)

# Splitting the data into training and testing part. to train and test the variables in dataset.
set.seed(2)
intrain <- createDataPartition(y=heart_df$V14, p=0.7, list=F)

training <- heart_df[intrain,]
testing <- heart_df[-intrain,]

dim(training)
dim(testing)

# To check the Null Values in dataset
anyNA(heart_df)

## Summary
summary(heart_df)

# Factorizing column
training["V14"] = factor(training[["V14"]])


## Train control method
trctrl <- trainControl(method = "repeatedcv", number=10, repeats = 3)

## Train on Linear Support Vector Machine
svm_linear <- train(V14~. , data=training, method = "svmLinear",
                    trControl = trctrl,
                    preProcess = c("center", "scale"),  
                    tuneLength=10)
svm_linear

## Prediction on test data set
test_pred <- predict(svm_linear, newdata= testing)   # first parameter is our train model
test_pred
summary(test_pred)

## Confusion matrix
confusionMatrix(test_pred, testing$V14) 

# To improve the performance we are going to used grid search. 
grid <- expand.grid(C = c(0.01, 0.05, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2,5))
svmgrid <- train(V14 ~., data = training, method = "svmLinear",
                 trControl=trctrl,
                 preProcess = c("center", "scale"),
                 tuneGrid = grid,
                 tuneLength = 10)
svmgrid

# Plot the graph for the SVM Linear Grid variable
plot(svmgrid) 

## prediction classifier against test data
test_pred <- predict(svmgrid, newdata= testing)
test_pred
summary(test_pred)

## confusion matrix
confusionMatrix(test_pred, testing$V14) 
