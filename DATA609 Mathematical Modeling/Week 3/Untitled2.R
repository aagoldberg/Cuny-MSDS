xLen <- c(12.5, 12.625, 14.125, 14.5, 17.25, 17.75)
yWei <- c(17, 16.5, 23, 26.5, 41, 49)
p169 <- data.frame(xLen, yWei)
fit5 <- lm(yWei ~ poly(xLen, 5, raw=TRUE))
fit

summary(fit5)
fit$model
plot(yVol ~ xDia)
abline(fit)
library(ggplot2)

g <- ggplot(p169, aes(xLen, yWei)) 
g + stat_smooth(method="lm", formula = y ~ poly(x,4)) + geom_point()
g + stat_smooth(method="lm", formula = y ~ poly(x,5)) + geom_point()


+ 
  geom_point() +
  stat_smooth(method = "lm", col = "red", formula = yVol ~ poly(xDia, 13))

plot(p154, y = yVol, x = xDia, formula = )
