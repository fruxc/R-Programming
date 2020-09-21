m1 <- matrix(C <- sample(1:100, 25, replace = TRUE), nrow = 5, ncol = 5)
m1
applyOnM1 <- apply(m1, 2, sum)
applyOnM1

apply(m1, 2, function(x) x * 10)
apply(m1, 1, function(x) x * 10)
