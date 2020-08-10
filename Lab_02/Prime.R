isPrime <- function(num){
  flag <- 0
  if(num > 1) {
    flag <- 1
    for(i in 2:(sqrt(num))) {
      if ((num %% i) == 0) {
        flag <- 0
        break
      }
    }
  }
  if(num == 2)    flag <- 1
  return (flag)
}
n = as.integer(readline(prompt="Enter a number: "))
result <- isPrime(n)
if(result == 1){
  print(paste(n, " is a prime number"))
}else{
  print(paste(n, " is not a prime number"))
}
