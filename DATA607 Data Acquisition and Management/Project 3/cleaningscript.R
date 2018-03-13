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


str(oscardat)
head(oscartable)
oscartable <- oscardat %>%
  gather("won","pictures", 3:11) %>%
  spread(won,won)
oscartable$pictures
str(oscartable)
head(oscartable)
oscartable
?spread
?str_replace_all
oscarTable<- data.frame(spread(oscarTable,won,won))
colnames(oscarTable)=c("Oscar_Num","Oscar_Year","Pictures","Best_Edit_Winner","Best_picture_Winner")
oscarTable$Best_Edit_Winner=str_replace_all(oscarTable$Best_Edit_Winner,pattern="Best_Editing","Yes")
oscarTable$Best_picture_Winner=str_replace_all(oscarTable$Best_picture_Winner,pattern="Best_Picture","Yes")
oscarTable[is.na(oscarTable)] <- "No"
oscarTable
?trimws()

head(oscartable)
oscartable <- gather(oscardat,"won","pictures",3:11)
oscartable$pictures <- trimws(oscartable$pictures)
oscartable <- data.frame(spread(oscartable,won,won))
