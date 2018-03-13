library(bigvis)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(devtools)

#reading and simplifying datasets
bkRaw <- read.csv("https://raw.githubusercontent.com/aagoldberg/Data-608/master/BK.csv")
siRaw <- read.csv("https://raw.githubusercontent.com/aagoldberg/Data-608/master/SI.csv")
bxRaw <- read.csv("https://raw.githubusercontent.com/aagoldberg/Data-608/master/BX.csv")
mnRaw <- read.csv("https://raw.githubusercontent.com/aagoldberg/Data-608/master/MN.csv")

bkData <- data.frame(bbl = bkRaw$BBL, borough = bkRaw$Borough, numFloors = bkRaw$NumFloors, yearBuilt = bkRaw$YearBuilt, assessLand = bkRaw$AssessLand, 
                     assessTot = bkRaw$AssessTot, assessBuilding = (bkRaw$AssessTot - bkRaw$AssessLand))
mnData <- data.frame(bbl = mnRaw$BBL, borough = mnRaw$Borough, numFloors = mnRaw$NumFloors, yearBuilt = mnRaw$YearBuilt, assessLand = mnRaw$AssessLand, 
                     assessTot = mnRaw$AssessTot, assessBuilding = (mnRaw$AssessTot - mnRaw$AssessLand))
bxData <- data.frame(bbl = bxRaw$BBL, borough = bxRaw$Borough, numFloors = bxRaw$NumFloors, yearBuilt = bxRaw$YearBuilt, assessLand = bxRaw$AssessLand, 
                     assessTot = bxRaw$AssessTot, assessBuilding = (bxRaw$AssessTot - bxRaw$AssessLand))
siData <- data.frame(bbl = siRaw$BBL, borough = siRaw$Borough, numFloors = siRaw$NumFloors, yearBuilt = siRaw$YearBuilt, assessLand = siRaw$AssessLand, 
                     assessTot = siRaw$AssessTot, assessBuilding = (siRaw$AssessTot - siRaw$AssessLand))

#queens data was too large to upload to github first, so simplifying local version first
# qnRaw <- read.csv("/Users/andrew/Documents/School/Visual Analytics/Data-608/QN.csv")
# qnData <- data.frame(bbl = qnRaw$BBL, borough = qnRaw$Borough, numFloors = qnRaw$NumFloors, yearBuilt = qnRaw$YearBuilt, assessLand = qnRaw$AssessLand, 
#                      assessTot = qnRaw$AssessTot, assessBuilding = (qnRaw$AssessTot - qnRaw$AssessLand))
# setwd("/Users/andrew/Documents/School/Visual Analytics/Data-608/")
# write.csv(qnData, file = "qnSimplified.csv")

qnData <- read.csv("https://raw.githubusercontent.com/aagoldberg/Data-608/master/qnSimplified.csv")
qnData <- qnData[,2:length(qnData)]

#combine each boro's data into one frame
allPlutoData <- rbind(bkData, qnData, mnData, bxData, siData)
summary(allPlutoData)

#Question 1: Build a graph to help the city determine when most buildings were constructed. 
#Is there anything in the results that causes you to question the accuracy of the data? 

q1Data <- allPlutoData %>%
  filter(yearBuilt > 1850, !is.na(yearBuilt))

yr <- with(q1Data, condense(bin(yearBuilt, 5)))

#ggplot2 binned line
ggplot(yr, aes(x = yearBuilt, y = .count)) +
  geom_line(colour = "lightsteelblue4") + 
  xlim(1850, 2017) + ylab("Total") + xlab("Year Built")

#ggplot2 density chart:
ggplot(q1Data, aes(yearBuilt)) + 
  geom_density(colour = "lightsteelblue4", fill = 'lightsteelblue4', alpha = 0.3) + 
  xlim(1850, 2017) + ylab("Total") + xlab("Year Built")

#by boro for fun
ggplot(q1Data, aes(yearBuilt, fill = borough, colour = borough)) + 
  geom_density(alpha = .7) + 
  xlim(1850, 2017) + ylab("Total") + xlab("Year Built")

#Is there anything in results that makes you question data? 
#There was data labelled after 2017, which is obviously impossible. The null values are worriesome but not unexpected. 


#question 2: Create a graph that shows how many buildings of a certain number of floors were built in each year.
#It should be clear when 20-story buildings, 30 story buildings, and 40-story buildings were first built in large numbers. 

#geom_raster, not a fan
q2Data <- allPlutoData %>%
  filter(yearBuilt > 1850, !is.na(yearBuilt), numFloors > 5) %>%
  mutate(numStories = ifelse(numFloors > 10, as.integer(round(numFloors, -1)), as.integer(numFloors))) %>%
  select(yearBuilt, numFloors, numStories)

n_bins = 100
yrFloor <- with(q2Data, 
                condense(bin(numFloors, find_width(yearBuilt, n_bins)),
                         bin(yearBuilt, find_width(numFloors, n_bins))))

ggplot(yrFloor, aes(yearBuilt, numFloors, fill=log(.count, 15) )) + 
  geom_raster() + ylim(5,75) + xlim(1850, 2017)

#geom_density -- my favorite
q2DataC <- allPlutoData %>%
  filter(yearBuilt > 1850, !is.na(yearBuilt), numFloors > 5, numFloors < 101) %>%
  mutate(numStories = ifelse(numFloors > 10, paste((round(numFloors, -1)), "-", round(numFloors, -1)+9), "<10")) %>%
  select(yearBuilt, numFloors, numStories)

ggplot(q2DataC, aes(yearBuilt, ..count.., fill = numStories)) + 
  geom_density(position = "fill") +
  scale_x_continuous(breaks = seq(1850, 2017, 15))

#q3 geom_density_2d -- cool but not sensitive for 50 and 60 story buildings
q2DataA <- allPlutoData %>%
  filter(yearBuilt > 1850, !is.na(yearBuilt), numFloors > 10) %>%
  mutate(numStories = ifelse(numFloors > 10, as.integer(round(numFloors, -1)), as.integer(numFloors))) %>%
  select(yearBuilt, numFloors, numStories)

ggplot(q2DataA, aes(yearBuilt, numStories)) + 
  geom_density_2d() 


#question 3: Construct a chart/graph to see if buildings from 41-45 have lower assessed value per floor
q3Data <- allPlutoData %>%
  filter(yearBuilt > 1850, !is.na(assessBuilding), assessBuilding > 0, numFloors > 0) %>%
  mutate(assBuildFloor = assessBuilding/numFloors) %>%
  select(yearBuilt, assBuildFloor) #assessBuilding is total assessment - land assessment, to get building value
hist(q3Data$assBuildFloor)
summary(q3Data)

yrAssess5 <- with(q3Data, condense(bin(yearBuilt, 5), z=assBuildFloor))
ggplot(yrAssess5, aes(x = yearBuilt, y = .mean)) + 
  geom_line(aes(colour = .count)) + xlim(1850, 2017) + ylab("Building Assessment per Floor") + xlab("Year Built") +
  annotate("rect", xmin = 1939, xmax = 1947, ymin = 20000, ymax = 50000, alpha = .2, colour = "red")
