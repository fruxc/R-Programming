v <- 1:1000 #data set for speed of cars
speed <- sample(v, 500)
min(speed) #Min
max(speed) #Max
sum(speed) #Sum
range(speed) #speed between range
mean(speed) #Mean
median(speed) #Median
var(speed) #Variance
sd(speed) #Standard deviation
head(scale(speed, scale = FALSE), 5) #To calculate the mean and standard deviation of the entire vector and head returns first 5 rows
quantile(speed) #Tells you how much of your data lies below a certain value
summary(speed) #Summary of entire object with results of various model fitting functions
