##install.packages("e1071")
library(e1071)  # for skewness function
scatter.smooth(x=cars$speed, y=cars$dist, main="Dist ~ Speed")  # Scatter plot

par(mfrow=c(1, 2))  # divide graph area in 2 columns

boxplot(cars$speed, main="Speed", sub=paste("Outlier rows: ", boxplot.stats(cars$speed)$out))  # box plot for 'speed'

boxplot(cars$dist, main="Distance", sub=paste("Outlier rows: ", boxplot.stats(cars$dist)$out))  # box plot for 'distance'

plot(density(cars$speed), main="Density Plot: Speed", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$speed), 2)))  # density plot for 'speed'

polygon(density(cars$speed), col="light blue")

plot(density(cars$dist), main="Density Plot: Distance", ylab="Frequency", sub=paste("Skewness:", round(e1071::skewness(cars$dist), 2)))  # density plot for 'dist'

polygon(density(cars$dist), col="light blue")

cor(cars$speed, cars$dist)  # calculate correlation between speed and distance 

linearModel <- lm(dist ~ speed, data=cars)  # build linear regression model on full data
print(linearModel)

summary(linearModel)  # model summary

# capture model summary as an object
modelSummary <- summary(linearModel)  

# model coefficients
modelCoeffs <- modelSummary$coefficients  

# get beta estimate for speed
beta.estimate <- modelCoeffs["speed", "Estimate"]

# get std.error for speed  
std.error <- modelCoeffs["speed", "Std. Error"]  

# calculate t statistic
t_value <- beta.estimate/std.error  

# calculate p Value
p_value <- 2*pt(-abs(t_value), df=nrow(cars)-ncol(cars))  

# f statistic
f_statistic <- linearModel$fstatistic[1]  

# parameters for model p-value calculate
f <- summary(linearModel)$fstatistic

AIC(linearModel)
BIC(linearModel)  


# Create Training and Test data -
set.seed(100)  # setting seed to reproduce results of random sampling
trainingRowIndex <- sample(1:nrow(cars), 0.8*nrow(cars))  # row indices for training data
trainingData <- cars[trainingRowIndex, ]  # model training data
testData  <- cars[-trainingRowIndex, ]   # test data

# Build the model on training data
lmMod <- lm(dist ~ speed, data=trainingData)  # build the model
distPred <- predict(lmMod, testData)  # predict distance

summary (lmMod)  # model summary
AIC (lmMod)  # Calculate akaike information criterion


actuals_preds <- data.frame(cbind(actuals=testData$dist, predicteds=distPred))  # make actuals_predicteds dataframe.
correlation_accuracy <- cor(actuals_preds)  # 82.7%
head(actuals_preds)

# Min-Max Accuracy Calculation
min_max_accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))  
# => 38.00%, min_max accuracy

# MAPE Calculation
mape <- mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals)  
# => 69.95%, mean absolute percentage deviation

DMwR::regr.eval(actuals_preds$actuals, actuals_preds$predicteds)


library(DAAG)
cvResults <- suppressWarnings(CVlm(cars, form.lm=dist ~ speed, m=5, dots=FALSE, seed=29, legend.pos="topleft",  printit=FALSE, main="Small symbols are predicted values while bigger ones are actuals."));  # performs the CV
attr(cvResults, 'ms')  
