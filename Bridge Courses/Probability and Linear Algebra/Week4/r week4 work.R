a <- rbind(c(1,2,-3),
           c(2,1,-3),
           c(-1,1,0))
b <- c(5,13,-8)
solve(a,b)

class(a)

c <- rbind(c(4, -3),
           c(-3, 5),
           c(0, 1))
d <- rbind(c(1, 4),
           c(3, -2))

c %*% d

a <- rbind(c(1,2,0),
           c(2,1,0),
           c(-1,1,0))
b <- c(5,13,-8)
solve(a,b)