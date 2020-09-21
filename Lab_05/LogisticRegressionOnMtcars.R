#Loading the data
library(caTools)
write.csv(mtcars, file = "mtcars.csv")
myData <- read.csv("mtcars.csv", header = T)

#Splitting the data into training and testing
split <- sample.split(myData, SplitRatio = 0.8)
split
train <- subset(myData, split == "TRUE")
test <- subset(myData, split == "FALSE")


#Train the model using entire data
myModel <- glm(am ~ wt + disp, data = myData, family = "binomial")
summary(myModel)
ggplot(myData, aes(x = wt + disp, y = am)) + geom_point() +
  stat_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE)

newData = data.frame(disp = 120, wt = 2.8)
predict(myModel, newData, type = "response")

#Train the model using training data
myModel <- glm(am ~ wt + disp, data = train, family = "binomial")
summary(myModel)

#Running the test data through the model

res <- predict(myModel, test, type = "response")
res
res <- predict(myModel, train, type = "response")
res


