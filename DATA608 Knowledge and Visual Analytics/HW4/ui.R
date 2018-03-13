library(shiny)

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      selectInput("causes",
                  "Cause of death:",
                  choices = unique(cdcData$ICD.Chapter))
    ),

    mainPanel(
      plotOutput("distPlot")
    )
  )
))