#libararies
require(ggplot2)
require(pROC) #to plot the ROC curves

heartdf <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data", header = FALSE, sep = ",", na.strings = '?')
names(heartdf) <- c("age", "sex", "cp", "trestbps", "chol", "fbs", "restecg",
                     "thalach", "exang", "oldpeak", "slope", "ca", "thal", "num")
attach(heartdf)


head(heartdf, 3)
dim(heartdf) # dimensions of the data set

#converting the NUM variable to binary class variable 
heartdf$num <- ifelse(heartdf$num > 0, "Disease", "noDisease")
table(heartdf$num)

#distribution of the target variable
ggplot(heartdf, aes(x = num)) +
  geom_bar(fill = "black")

#converting to factor variable
heartdf$sex <- ifelse(heartdf$sex == 0, "female", "male")
table(heartdf$sex)
table(sex = heartdf$sex, disease = heartdf$num)
ggplot(heartdf, aes(x = sex)) +
  geom_bar(fill = "purple") +
  facet_wrap(~num)

#heart disease and age
#making a box plot to unserstand the statistical distribution
by(heartdf$age, heartdf$num, summary)

ggplot(heartdf, aes(x = num, y = age)) +
  geom_boxplot()

cor.test(age, chol) #very low correlation

#confusion matrix of chest pain and heart disease
table(cp, num)

#confusuon matrix of exersice induced asthama and heart disease
table(exang, num)
cor.test(age, thalach)
ggplot(heartdf, aes(x = age, y = thalach)) +
  geom_point() +
  geom_smooth()

library(caret)
set.seed(20)
inTrainRows <- createDataPartition(heartdf$num, p = 0.7, list = FALSE)
trainData <- heartdf[inTrainRows,]
testData <- heartdf[-inTrainRows,]
nrow(trainData) / (nrow(testData) + nrow(trainData)) #checking whether really 70% -> OK

# for this to work add names to all levels (numbers not allowed)
feature.names = names(heartdf)
for (f in feature.names) {
  if (class(heartdf[[f]]) == "factor") {
    levels <- unique(c(heartdf[[f]]))
    heartdf[[f]] <- factor(heartdf[[f]],
                           labels = make.names(levels))
  }
}

#converting to factor variable with 2 levels
heartdf$num <- as.factor(heartdf$num)
levels(heartdf$num) <- c("Notdisease", "Disease")
table(heartdf$num)
set.seed(10)
inTrainRows <- createDataPartition(heartdf$num, p = 0.7, list = FALSE)
trainData2 <- heartdf[inTrainRows,]
testData2 <- heartdf[-inTrainRows,]

#cross validation
fitControl <- trainControl(method = "repeatedcv",
                           number = 10,
                           repeats = 10,
## Estimate class probabilities
                           classProbs = TRUE,
## Evaluate performance using
## the following function
                           summaryFunction = twoClassSummary)

svmModel <- train(num ~ ., data = na.omit(trainData2),
                  method = "svmRadial",
                  trControl = fitControl,
                  preProcess = c("center", "scale"),
                  tuneLength = 8,
                  metric = "ROC")

svmModel

#prediction on test data-class labels
svmPrediction <- predict(svmModel, testData2)

#probability of no heart disease-finding probabilities value
svmPredictionprob <- predict(svmModel, testData2, type = 'prob')[2]
svmPredictionprob
#generating a confusion matrix
ConfMatrixPrediction <- confusionMatrix(svmPrediction, na.omit(testData2)$num)
ConfMatrixPrediction$table

#ROC and AUC value
AUC <- roc(na.omit(testData2)$num, as.numeric(as.matrix((svmPredictionprob))))$auc
Accuracy <- ConfMatrixPrediction$overall['Accuracy']
svmPerformance <- cbind(AUC, Accuracy)

svmPerformance


auc_roc <- roc(na.omit(testData2)$num, as.numeric(as.matrix((svmPredictionprob))))
plot(auc_roc)
