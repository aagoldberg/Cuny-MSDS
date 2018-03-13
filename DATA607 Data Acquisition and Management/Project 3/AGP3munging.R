library(dplyr)
library(tidyr)
library(stringr)

oscardat <- read.csv("https://raw.githubusercontent.com/mfarris9505/IS607_Project3/master/data/Combo_Oscar.csv", strip.white = TRUE, header=TRUE, sep=",")
oscardat[,3:11] <- lapply(oscardat[,3:11], trimws)
oscardat <- oscardat[,2:11]

oscartable <- oscardat %>%
  gather("won","pictures", 2:10) %>%
  spread(won,won) %>%
  filter(pictures !="NA")

head(oscartable)
oscartable[,2:11] <- lapply(oscartable[,2:11], as.character)
oscartable[,3:11][oscartable[,3:11] != "NA"] <- 1
oscartable[,3:11][is.na(oscartable[,3:11])] <- 0