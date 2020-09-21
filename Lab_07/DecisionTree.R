path <- ("E:/SPIT/R_Practicals/Lab_07/titanic.csv") #Path of data set

titanic <- read.csv(path) #importing the data set into titanic variable

head(titanic) #printing head of the data set
tail(titanic) #printing tail of the data set

shuffle_index <- sample(1:nrow(titanic)) #creating shuffling index to shuffle rows depending on the 
head(shuffle_index)

titanic <- titanic[shuffle_index,] #shuffling the data set based on shuffle index
head(titanic)


titanic[, c("age", "fare")] <- as.double(as.character(unlist(titanic[, c("age", "fare")])))

require(dplyr) # alternatively, this also loads %>%
# Drop variables
clean_titanic <- titanic %>%
  select(-c(home.dest, cabin, name, x, ticket)) %>%
#Convert to factor level
mutate(pclass = factor(pclass, levels = c(1, 2, 3), labels = c('Upper', 'Middle', 'Lower')),
         survived = factor(survived, levels = c(0, 1), labels = c('No', 'Yes'))) %>%
  na.omit()
glimpse(clean_titanic)

create_train_test <- function(data, size, train) {
  n_row = nrow(data)
  total_row = size * n_row
  train_sample <- 1:total_row
  if (train == TRUE) {
    return(data[train_sample,])
  } else {
    return(data[-train_sample,])
  }
}

data_train <- create_train_test(clean_titanic, 0.8, train = TRUE)
data_test <- create_train_test(clean_titanic, 0.8, train = FALSE)
dim(data_train)
dim(data_test)


prop.table(table(data_train$survived))


prop.table(table(data_test$survived))




require(rpart)
require(rpart.plot)

fit <- rpart(survived ~ ., data = data_train, method = 'class')
rpart.plot(fit, extra = 106)

predict_unseen <- predict(fit, data_test, type = 'class')
predict(fit, data_test, type = 'class') # Predict the class (0/1) of the test set

table_mat <- table(data_test$survived, predict_unseen)
table_mat

accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)

print(paste('Accuracy for test', accuracy_Test))

rpart.control(minsplit = 20, minbucket = round(20 / 3), maxdepth = 30)

accuracy_tune <- function(fit) {
  predict_unseen <- predict(fit, data_test, type = 'class')
  table_mat <- table(data_test$survived, predict_unseen)
  accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
  accuracy_Test
}

control <- rpart.control(minsplit = 4, minbucket = round(5 / 3), maxdepth = 3, cp = 0)
tune_fit <- rpart(survived ~ ., data = data_train, method = 'class', control = control)
accuracy_tune(tune_fit)
