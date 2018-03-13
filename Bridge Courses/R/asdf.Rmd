require(hflights)
require(ggplot2)
require(dplyr)
require(Rcpp)
data(hflights)
summary(hflights)
head(hflights)

#Question: What variables appear to cause most departure delays? 

#boxplot DepDelay: a lot of outliers
boxplot(hflights$DepDelay)

#histogram DepDelay: right tail visible to about 200 minutes
ggplot(data = hflights) + geom_histogram(aes(x = DepDelay), bin = 10, fill = 'grey30')

#create a data.frame with data less than 200 minute departure delays and no negatives (departed early)
hf_depdelay <- hflights[which(hflights$DepDelay < 200 & hflights$DepDelay > 0),  ]

#check summary data again
summary(hf_depdelay)
str(hf_depdelay)

#check out new histogram
ggplot(data = hf_depdelay) + geom_histogram(aes(x = DepDelay), bin = 10, fill = 'grey30')

#Find some leads by checking correlations among other int variables: 
#ArrDelay has an obvious strong correlation, with weaker correlations among DepTime, ActualElapsedTime, and Airtime 
cor(hf_depdelay$DayofMonth, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$DayOfWeek, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$TaxiIn, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$DepTime, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$ArrTime, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$ActualElapsedTime, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$AirTime, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$ActualElapsedTime, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$ArrDelay, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$Distance, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$TaxiIn, hf_depdelay$DepDelay, use = "na.or.complete")
cor(hf_depdelay$TaxiOut, hf_depdelay$DepDelay, use = "na.or.complete")

#Scatterplot of ArrDelay by DepDelay
ggplot(hf_depdelay) + geom_point(aes(x = DepDelay, y = ArrDelay))

#Now check out categorical variables: carrier, destination, and origin
#Carrier first: there's a few main carriers: Continental, Skywest, Southwest, and ExpressJet
ggplot(data = hf_depdelay) + geom_histogram(aes(x = UniqueCarrier), fill = 'grey30')

#density charts by airline: looks like continental is responsible for many of the delays, considering its size
ggplot(data = hf_depdelay) + geom_density(aes(x=DepDelay, fill = UniqueCarrier)) + facet_wrap(~UniqueCarrier)

#Check out just the main airlines: create a data.frame with only the main carriers
hf_mcarriers <- hf_depdelay[which(hf_depdelay$UniqueCarrier == 'CO' | hf_depdelay$UniqueCarrier == 'OO' | hf_depdelay$UniqueCarrier == 'WN' | hf_depdelay$UniqueCarrier == 'XE'),  ]

#still only less than 1% of its flights, but continental has a higher percentage of (at least short) departure delays than others
ggplot(data = hf_mcarriers) + geom_density(aes(x=DepDelay, fill = UniqueCarrier)) + facet_wrap(~UniqueCarrier)

#check out delays by destination: there are a lot
ggplot(data = hf_depdelay) + geom_histogram(aes(x = Dest), fill = 'grey30')

#there's a lot of destinations here, so quickly using sql to get only destinations with over 2500 trips (will try to get this data on a webpage so charts work for presentation on rpubs)
(select * from depdelay where dest in (select dest from (select dest, count(dest) as count from depdelay group by dest) s 
                                       where s.count > 2500 order by count desc))

#reload the data from sql
thedest <- "C:/Users/Andrew/Desktop/Bridge Courses/R/Final/largdest.csv"
largedests <- read.table (file = thedest, header = TRUE, sep = ";")
head(largedests)

#easier to visualize histogram
ggplot(data = largedests) + geom_histogram(aes(x = dest), fill = 'grey30')

#looking at departure delay density charts, it looks like DEN and LAS have the highest proportion of short-term delays
ggplot(data = largedests) + geom_density(aes(x=depdelay, fill = dest)) + facet_wrap(~dest)