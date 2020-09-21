#install.packages("ggplot2")
library(ggplot2)
library(dplyr)

mtcars <- mutate(mtcars, cyl = factor(cyl, ordered = TRUE, levels = c(4, 6, 8)))

my_histogram <- ggplot(mtcars, aes(x = mpg)) + geom_histogram(binwidth = 5)

my_histogram + xlab('Miles per Gallon') + ylab('Number of Cars') + theme_minimal()

my_boxplot <- ggplot(mtcars, aes(x = cyl, y = mpg)) + geom_boxplot() + xlab('Cylinders') + ylab('Miles per Gallon')
my_boxplot + coord_flip()

my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
my_scatplot + xlab('Weight (x 1000lbs)') + ylab('Miles per Gallon')

my_barplot <- ggplot(data = mtcars, aes(x = mpg, y = cyl)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal()
my_barplot + coord_flip()


ggplot(data = mtcars, aes(x = mpg, fill = cyl)) +
  geom_density(alpha = 0.4)

p + geom_vline(data = mtcars, aes(xintercept = mpg.mean, color = cyl),
             linetype = "dashed")