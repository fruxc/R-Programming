data(mtcars)
dataset <- subset(mtcars, select = c(mpg, am, vs))
dataset

prob_vm <- glm(vs ~ mpg, dataset, family = binomial(link = "logit"))

summary(prob_vm)

library(ggplot2)
ggplot(dataset, aes(x = mpg, y = vs)) + geom_point() +
  stat_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE)

par(mar = c(4, 4, 1, 1)) # Reduce some of the margins so that the plot fits better
plot(dataset$mpg, dataset$vs)
curve(predict(prob_vm, data.frame(mpg = x), type = "response"), add = TRUE)


prob_va <- glm(vs ~ am, dataset, family = binomial)
summary(prob_va)


ggplot(dataset, aes(x = am, y = vs)) +
  geom_point(shape = 1, position = position_jitter(width = .05, height = .05)) +
  stat_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE)


par(mar = c(4, 4, 1, 1)) # Reduce some of the margins so that the plot fits better
plot(jitter(dataset$am, .2), jitter(dataset$vs, .2))
curve(predict(prob_va, data.frame(am = x), type = "response"), add = TRUE)


prob_vma <- glm(vs ~ mpg + am, dataset, family = binomial)
prob_vma
summary(prob_vma)
