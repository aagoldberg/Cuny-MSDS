install.packages("dplyr")
library(dplyr)
library(ggplot2)

carlate <- mutate(group_by(hf_depdelay, DepDelay), percent = hf_depdelay$DepDelay / sum(hf_depdelay$DepDelay) * 100) %>% ungroup() 
carlate
sum(DepDelay)
