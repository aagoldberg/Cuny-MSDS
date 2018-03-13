2+2

4/7
9/6
2/2

if (toCHeck == 0)
{
  print("hello")
}

check.bool <- function(x)
{
  if (x == 1)
  {
    print("hello")
  } else
  {
    print("goodbye")
  }
}

check.bool(1)
check.bool(2)
check.bool(TRUE)

check.bool1 <- function(x)
{
  if (x == 1)
  {
    print("hello")
  } else if(x == 0)
  {
    print("goodbye")
  } else
  {
    print("confused")
  }
}

check.bool(1)
check.bool(2)
check.bool(TRUE)


use.switch <- function(x)
{
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "c"="third",
         "other")
}

ifelse(1 == 1, "Yes", "No")
ifelse(1 == 0, "Yes", "No")
toTest <- c(1, 0, 1, 0, 1)
ifelse(toTest == 1, toTest * 3, toTest)
ifelse(toTest == 1, toTest * 3, "Zero")
toTest[2] <- NA
toTest
ifelse(toTest == 1, "Yes", "No")
ifelse(toTest == 1, toTest *3, toTest)
ifelse(toTest == 1, toTest *3, "Zero")


a <- c(1, 1, 0, 1)
b <- c(2, 1, 0, 1)
ifelse(a == 1 & b == 1, "Yes", "No")
ifelse(a == 1 && b == 1, "Yes", "No")

for (i in 1:10)
{
  print(i)
}

fruit <- c("apple", "banana", "pomegranate")
fruitLength <- rep(NA, length(fruit))
fruitlength
names(fruitLength) <- fruit
fruitLength

for (a in fruit)
{
  fruitLength[a] <- nchar(a)
}

fruitLength

x <- 1
while (x <= 5)
{
  print(x)
  x <- x + 1
}

for (i in 1:10)
{
  if (i == 3)
  {
    next
  }
  print(i)
}
  


hello.person <- function(name)
{
  print(sprintf("hello %s", name))
}

hello.person("andrew")
re