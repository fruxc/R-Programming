{
  a <- readline(prompt = "Enter first number :")
  b <- readline(prompt = "Enter second number :")

  a <- as.integer(a)
  b <- as.integer(b)

  a = a + b
  b = a - b
  a = a - b

  print(paste("first :", a))
  print(paste("second :", b))
}