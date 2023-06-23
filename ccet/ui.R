library(shiny)
library(DT)

shinyUI(navbarPage(
    "Demo",
    tabPanel("View Data",
             fluidRow(
                 column(10, offset = 1, DT::dataTableOutput("table"))),
             hr(),
             fluidRow(
                 p(class = 'text-center', downloadButton('downloadData', 'Download Filtered Data'))
             )
             ),
    
    tabPanel("View Data Summary of BMI",
             fluidRow(
                 column(4, selectInput("sex", "group by gender", c("Yes", "No"))),
                 column(8, DT::dataTableOutput("summary"))
             ),
             hr(),
             fluidRow(
                 p(class = 'text-center', downloadButton('downloadSummary', 'Download Summary Data'))
             )
             )
    
))