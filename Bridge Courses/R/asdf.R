install.packages("cape")
require(cape)
a <- rbind(c(1,2),
            c(2,1))
b <- c(5,13)
solve(a,b)
