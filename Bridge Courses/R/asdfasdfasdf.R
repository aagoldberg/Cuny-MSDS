require(ggplot2)
data(diamonds)
head(diamonds)

hist(diamonds$carat, main = "Carat Histogram", xlab = "Carat")

plot(price ~ carat, data = diamonds)
boxplot(diamonds$carat)
ggplot(data = diamonds) + geom_histogram(aes(x = carat))
ggplot(data = diamonds) + geom_density(aes(x = carat), fill = "grey50")

ggplot(diamonds, aes(x = carat, y = price)) + geom_point()
g <- ggplot(diamonds, aes(x = carat, y = price))
g + geom_point(aes(color = color)) + facet_wrap(~color) 
g + geom_point(aes(color = color)) + facet_grid(cut ~ clarity)
ggplot(diamonds, aes(x = carat)) + geom_histogram() + facet_wrap(~color)
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin() + geom_point()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_point() + geom_violin()
ggplot(economics, aes(x = date, y = pop)) + geom_line()
head(economics)
require(lubridate)
install.packages(lubridate)
economics$year <- year(economics$date)
require(lubridate)

economics$date
head(economics$date)
year(economics$date)
head(economics$year)
head(economics)
economics$month <- month(economics$date, label = TRUE)
head(economics)
econ2000 <- economics[which(economics$year >= 2000), ]
head(econ2000)
require(scales)

g <- ggplot(econ2000, aes(x=month, y=pop))
g <- g + geom_line(aes(color=factor(year), group=year))
g <- g + scale_y_continuous(labels=comma)
g <- g + labs(title="Population Growth", x="Month", y="Population")
g
factor(econ2000$year)

require(ggthemes)
g2 <- ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point(aes(color=color))
g2 + theme_economist() + scale_colour_economist()
g2 + theme_excel() + scale_colour_excel()
g2 + theme_wsj()
