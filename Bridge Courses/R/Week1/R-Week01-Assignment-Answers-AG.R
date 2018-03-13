#Week 1 Assignment - R
#Andrew Goldberg
#7/4/2015

#Q1 CODE:
twelveFact <- 1
for (x in 12:1)
{
  twelveFact = twelveFact * x
}
  
twelveFact

#Q1 Answer: 479001600

#Q2 CODE:
#I had to look this up, didn't see "seq" in book
numVect <- seq(20,50, by=5)
numVect

#Q2 Answer: [1] 20 25 30 35 40 45 50


#Q2 CODE2:
#Still had to look up a few things, although, maybe this formation was the goal:

byFiveVect <- as.numeric(vector())
for (x in 20:50)
{
  if (x %% 5 != 0)
  {
    next
  }
  byFiveVect <-c(byFiveVect,x)
}

#Q3 CODE:

quadEquationInput <- function()
{
  a <- as.integer(readline(prompt="Enter an integer a for execution in a quadratic equation: "))
  b <- as.integer(readline(prompt="Enter an integer b for execution in a quadratic equation: "))
  c <- as.integer(readline(prompt="Enter an integer c for execution in a quadratic equation: "))
  x1 <- (b+(sqrt((b^2)-(4*a*c)))/(2*a))
  x2 <- (-b+(sqrt((b^2)-(4*a*c)))/(2*a))
  print(x1)
  print(x2)
}


quadEquation <- function(a,b,c)
{
  x1 <- (b+(sqrt((b^2)-(4*a*c)))/(2*a))
  x2 <- (-b+(sqrt((b^2)-(4*a*c)))/(2*a))
  print(x1)
  print(x2)
}

quadEquation()

