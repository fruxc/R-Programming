#new
#if you are having difficulties while installing please run rstudio as administrator
#install.packages("dplyr") uncomment this to install

library("dplyr")
library("datasets")
data(mtcars)
summary(mtcars)
head(mtcars)

#To select the following columns and (-) to hide the column
s <- select(mtcars, hp, mpg, cyl, - am)
head(s)

#To select columns with numeric indexes
s2 <- select(mtcars, c(3:5))
head(s2)

#To filter automatic and manual transmission cars 1 is for automatic and 0 for manual
f <- filter(mtcars, am == 1)
head(f)

#To filter cars with 6 or more cylinders and automatic transmission
f2 <- filter(mtcars, cyl >= 6, am == 1)
head(f2)

#filter with selected elements
f3 <- filter(s, cyl == 8)
print(f3)

#To create a column "More Power" which stores TRUE if given condition is TRUE
newCol <- mutate(mtcars, MorePower = (hp >= 200))
head(newCol)

#To check how many cars satisfy condition
table(newCol$MorePower)

#To arrange miles per gallon in ascending order
arr <- arrange(newCol, mpg)
head(arr)

#To arrange miles per gallon in descending order
arr2 <- arrange(newCol, desc(mpg))
head(arr2)

#To arrange cars in ascending  order by miles per gallon
head(mtcars[order(mtcars$mpg),])

#To arrange cars in descending  order by miles per gallon
head(mtcars[order(mtcars$mpg, decreasing = TRUE),])

#To arrange cars in order with cylinder, v shape and miles per gallon
mtcars[with(mtcars, order(cyl, vs, mpg)),]

# summarize to find out (mean, median, mode, etc.)
summarised <- summarise(arr, Mean.HorsePower = mean(hp))
head(summarised)

#To find mean horse power by cylinder, we use grouping as follows
gp1 <- group_by(mtcars, cyl)
grouped <- summarise(gp1, Mean.HorsePower = mean(hp))
head(grouped)

#Pipe operator
#To get rows with the following conditions 
mtcars %>% filter(am == 1, hp > 200)

#To find mean miles per gallon by automatic transmission
mtcars %>% group_by(gear) %>% summarise(Mean.MPG = mean(mpg))
