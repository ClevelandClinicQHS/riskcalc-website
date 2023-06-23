#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Breast Cancer Outcome Predictor"),
  
  fluidRow(column(width = 12,
                  p("This predictor is applicable to women with breast cancer who have upfront mastectomy, have a <=5cm tumor, and 1, 2, or 3 positive lymph nodes. Based on a combination of patient, disease, and treatment characteristics, the 5-year and 10-year predicted risks of local recurrence, distant recurrence, overall recurrence, and breast cancer mortality are calculated."),
                    strong("Note that 'optimal systemic therapy' includes endocrine therapy for patients with ER+ or PR+ disease, trastuzumab for patients with HER2+ disease, and chemotherapy for patients with ER- and PR- disease."),
                  HTML("<br><br><br>")
  )
  ),
  
  fluidRow(
    column(width = 4,
           sliderInput(
             inputId= "age_at_diagnosis",
             label = "Age at diagnosis (years)",
             min = 20,
             max = 90,
             value = 55,
             step = 1),
           
           sliderInput(
             inputId = "pathologic_tumor_size_cm",
             label = "Pathologic tumor size (cm)",
             min = 0,
             max = 5,
             value = 3,
             step = 0.1),
           
           sliderInput(
             inputId = "number_ln_sampled",
             label = "Number of lymph nodes sampled",
             min = 1,
             max = 40,
             value = 12,
             step = 1),
           
           selectInput(
             inputId = "number_ln_positive",
             label = "Number of positive lymph nodes",
             choices = list("1", "2", "3")
           ),
           
           selectInput(
             inputId = "grade_bin",
             label = "Grade",
             choices = list("I/II", "III")
           ),
           
           selectInput(
             inputId = "lvi",
             label = "Lymphovascular invasion",
             choices = list("No", "Yes")
           ),
           
           selectInput(
             inputId = "er_pr",
             label = "ER/PR status",
             choices = list("ER+ or PR+", "ER- and PR-")
           ),
           
           selectInput(
             inputId = "her2_status",
             label = "HER2 status",
             choices = list("Negative", "Positive")
           ),
           
           selectInput(
             inputId = "tumor_quadrant_bin",
             label = "Tumor location",
             choices = list("Inner", "Other")
           ),
           
           selectInput(
             inputId = "rt",
             label = "Post-mastectomy radiation therapy (PMRT)",
             choices = list("No", "Yes")
           ),
           
           selectInput(
             inputId = "optimal_systemic_therapy",
             label = "Optimal systemic therapy",
             choices = list("No", "Yes")
           )),
    
    column(width = 8,
           align = "center",
           tableOutput("predTab"),
           br(),
           plotOutput("predPlot")
    )
  )
))