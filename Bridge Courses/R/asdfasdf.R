#load ggplot2 and diamonds dataset
require(ggplot2)
data(diamonds)

#summary descriptive stats; cut/color/clarity are categorial
summary(diamonds)

ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot()
ggplot(diamonds, aes(y = carat, x = cut, z = color)) + geom_boxplot()

ggplot(diamonds) + geom_histogram(aes(x = color, fill = color))
ggplot(diamonds) + geom_histogram(aes(x = color, fill = color)) + facet_wrap(~cut)
g <- ggplot(diamonds, aes(x = cut, y = color))
g + geom_histogram(aes(fill = color))

ggplot(diamonds, aes(x = cut, y = color)) + geom_point(color = color)
g <- ggplot(diamonds, aes(x = cut, y = color))
g + geom_point(aes(color = cut))

ggplot(data = diamonds) +geom_density(aes(x = price))

g <- ggplot(diamonds, aes(x = depth, y = price))
g + geom_point(aes(color = depth))

table(diamonds$cut)
table(diamonds$cut, diamonds$clarity)
