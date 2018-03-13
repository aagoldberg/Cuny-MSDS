library(shiny)
library(dplyr)
library(ggplot2)
library(forcats)


#paste(unique(cdcData$ICD.Chapter), collapse = "' , '")

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    
    cdcData <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv")
    #filter data by year and cause
    stDis10 <- cdcData %>%
      filter(Year == "2010", ICD.Chapter == input$causes) %>%
      arrange(desc(Crude.Rate)) %>%
      select(State, ICD.Chapter, Crude.Rate)
    
    #stDis10$Crude.Rate <- factor(stDis10$Crude.Rate, levels = stDis10$Crude.Rate)
    #plot barchart
    ggplot(stDis10, aes(y = Crude.Rate, x = reorder(State, Crude.Rate))) + geom_col() + coord_flip()
  })
})