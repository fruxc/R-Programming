{
  x <- readline(prompt = "Enter first number :")
  y <- readline(prompt = "Enter second number :")

  x <- as.integer(x)
  y <- as.integer(y)

  z = x + y

  print(paste("Addition of two number is :", z))
}