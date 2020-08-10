# Create a sample of 50 numbers which are normally distributed.
normalVector <- 1:1000
observations <- sample(normalVector, 50);
y <- runif(observations, min=2, max=49)    # define the range between 2 and 49
x <- rnorm(observations, mean=25, sd=3)    # provide our own mean and standard deviation

hist(x, main = "Normal DIstribution")
hist(y, main = "Uniform DIstribution")

# Create a sequence of numbers between -10 and 10 increment by 0.1.
x <- seq(-10, 10, by = .1)

# Choose the mean as 2.5 and standard deviation as 0.5.
y <- dnorm(x, mean = 2.5, sd = 0.5) # Gives height of the probability distribution
plot(x, y, main = "Height of Probability Dist")
y <- pnorm(x, mean = 2.5, sd = 0.5) # Gives the probability of a normally distributed random number to be less that the value of a given number. It is also called "Cumulative Distribution Function"
plot(x, y, main = "Cumulative Distribution")
y <- qnorm(x, mean = 2.5, sd = 0.5) # Gives a number whose cumulative value matches the probability value
plot(x, y, main = "Cumulative = Probability")

