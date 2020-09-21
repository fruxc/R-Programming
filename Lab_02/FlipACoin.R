sample(0:1, 10, rep = T)
sample(c("H", "T"), 10, replace = TRUE)

x <- readline(prompt = "Enter number of times you want to flip a coin ")
x <- as.integer(x)
FlipCoin = function(n) sample(c("H", "T"), n, rep = T)
result = FlipCoin(x)
result