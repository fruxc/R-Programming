fun <- function(mu, val) {
  browser() ##break point inserted here
  sub <- val - mu
  sqr <- sub ^ 2
  get <- sum(sqr)
  get
}
set.seed(100)
val <- rnorm(100)
fun(1, val)