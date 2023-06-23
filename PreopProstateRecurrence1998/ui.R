library(shiny)

# Define UI for the risk calculator that
##  predicts the 5-year probability of
## freedom free recurrence
shinyUI(fluidPage(
  
  titlePanel(h1("Pre Radical Prostatectomy Freedom From Recurrence Risk Calculator for CALGB 90203",style = "color:ForestGreen; text-align: center")),
  sidebarLayout(

  # Application title
  
  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    
  #      sliderInput("prepsa", "Preoperative Prostate Specific Antigen (PSA, ng/mL)?", value = 0.1, min = 0.1, max = 110),
#      textInput("prepsa2", "Or would like to enter PSA directly?", value = ""),
    numericInput("prepsa", "Preoperative Prostate Specific Antigen (PSA, ng/mL)?", value = 0.1, min = 0.1, max = 110,step = 0.1),
        selectInput("uicc", "Clinical Stage?",
            choices = c("T1ab","T1c","T2a","T2b","T2c", "T3a"),
            selected = "T1c"),

     sliderInput("g1", "Primary Biopsy Gleason Score?", value = 3, min = 1, max = 5, step = 1),
      sliderInput("g2", "Secondary Biopsy Gleason Score?", value = 3, min = 1, max = 5, step = 1)
#       selectInput("bxggmk", "Primary and Secondary Biopsy Gleason Scores?",
#                   choices = c("G1<=2 & G2<=2"="<3+<3",
#                               "G1<=2 & G2=3"="<3+3",
#                               "G1=3 & G2<=2"="3+<3",
#                               "G1=3 & G2=3"="3+3",
#                               "G1<=3 & G2>=4"="<4+>3",
#                               "G1>=4 & any G2"=">3+>0"),
#                   selected = "3+3")
      ## submitButton(text = "Calculate")
  
),


  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
#     h4("5-year Probability of Freedom From Disease Recurrence",
#        style = "color:ForestGreen; text-align: center"),
      plotOutput("outcomePlot"),
      h4(a("Kattan, M. W., Eastham, J. A, Stapleton, A M., Wheeler, T. M., & Scardino, P. T. (1998). A preoperative nomogram for disease recurrence 
           following radical prostatectomy for prostate cancer.",tags$i("Journal of the National Cancer Institute")," 90(10), 766–71.",
           href = "http://www.ncbi.nlm.nih.gov/pubmed/9605647", style = "color:dodgerblue3; text-align: center"))
    
   ),
    position = "left",
fluid = TRUE

    
)

)
)


#runApp("PreopProstateRecurrence1998")