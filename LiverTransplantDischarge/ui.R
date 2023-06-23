library(shiny)

# Define UI for the risk calculator that
##  predicts the discharge status - probability of
## discharging to facility
shinyUI(pageWithSidebar(

  # Application title
  headerPanel(h1("A risk Calculator for Orthotopic Liver Transplantation",style = "color:ForestGreen")),

  # Sidebar with controls to select a dataset and specify the number
  # of observations to view
  sidebarPanel(
    sliderInput("Karnofsky.score..", "Karnofsky Score", value = 80, min = 10, max = 90, step = 1),
     sliderInput("AGE", "Patient's Age (Years)", value = 30, min = 20, max = 80),
     sliderInput("INR", "INR", value = 5, min = 0, max = 10, step = 0.1),
     sliderInput("CREAT", "Serum Creatinine (mg/dL)", value = 5, min = 0, max = 10, step = 0.1),
    selectInput("PRE_TX_DIABETES", "Have History of Diabetes?",
                choices = c("No", "Yes")) ,
     sliderInput("TBILI", "Bilirubin (mg/dL)", value = 30, min = 0, max = 65, step = 0.1),
    sliderInput("ALB", "Albumin (g/dL)", value = 3, min = 1, max = 7, step = 0.1),
     sliderInput("BMI", label = HTML("BMI (kg/m<sup>2</sup>)"),value = 25, min = 15, max = 55, step = 0.1), 
    selectInput("Dialysis.Y.N", "Renal Dialysis",
                  choices = c("No", "Yes")) ,
    selectInput("SEX", "Gender",
                choices = c("Female", "Male"))
    

      ## submitButton(text = "Calculate")
  ),

  # Show a summary of the dataset and an HTML table with the requested
  # number of observations
  mainPanel(
      h2("Predicted Probability of Discharging to Facility",
         style = "color:ForestGreen",align = "center"),
      plotOutput("piePlot"),
      h3(a("Kelly DM, Bennett R, Brown N, McCoy J, Boerner D, Yu C, Eghtesad B, Barsoum W, Fung JJ, Kattan MW. Predicting the discharge status after liver transplantation at a single center: a new approach for a new era.",
tags$b(tags$i("Liver Transplantation")),". 2012 Jul;18(7):796-802. doi: 10.1002/lt.23434.",
         href = "http://onlinelibrary.wiley.com/doi/10.1002/lt.23434/pdf", style = "color:DodgerMediumBlue",target = "_blank"))


  )
))
