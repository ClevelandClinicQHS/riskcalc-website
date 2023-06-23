library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)

fluidPage(
  shinyjs::useShinyjs(), theme = shinytheme("flatly"),
  # Application title
  titlePanel("Predicting high-risk coronary artery disease anatomy"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age", min = 18, max = 90, value = 18),
      selectInput("male", "Sex", choices = c("Female", "Male")),
      selectInput("diabetes", "Diabetes", choices = c("No", "Yes")),
      selectInput("hypertension", "Hypertension", choices = c("No", "Yes")),
      selectInput("hypercholesterolemia", "Hypercholesterolemia", choices = c("No", "Yes")),
      numericInput("HDL", "HDL (mg/dl)", min = 0, max = 100, value = 60),
      numericInput("exercise_time", "Total exercise time (min)", min = 0, max = 20, value = 0, step=1),
      selectInput("duke_treadmill_score", "Duke treadmill score", choices = c("<= -11", "-10 to 4", ">= 5", "Not available")),
      selectInput("chestpain", "Chest pain", choices = c("No chest pain", "Cardiac chest pain", "Unavailable")),
      selectInput("FMHx_CAD", "Family history of CAD", choices = c("No", "Yes")),
      
      bsTooltip("age", "Range: 18 - 90", "right", options = list(container = "body")),
      bsTooltip("HDL", "Range: 0 - 100", "right", options = list(container = "body")),
      bsTooltip("exercise_time", "Range: 0 - 20", "right", options = list(container = "body"))
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      #actionButton("goButton", "Run Calculator"),
      #br(),
      #br(),
      tags$head(tags$style(type = "text/css", "tfoot {display:none;}")),
      DT::dataTableOutput('result'),
      br(),
      wellPanel(
          h3('Click Below for Calculator and Author Contact Information'),
          p(
              "Barakat AF, Amuthan R, Hariri E, Chana R, Gupta N, Ibrahim J, Bashir ZS, Hu B, Sezer A, Thoma F, Soman P, Mulukutla S, Barzilai B, Ellis SG, Jaber W, Rothberg MB. ",
              a(
                  "A Validated Model to Identify Patients With Low Likelihood of High-Risk Coronary Artery Disease Anatomy. ",
                  href = "https://pubmed.ncbi.nlm.nih.gov/35031112/"
              ),
              "Am J Cardiol. 2022 Mar 15;167:27-34. doi: 10.1016/j.amjcard.2021.11.037. Epub 2022 Jan 11. PMID: 35031112."
          )
      ),
      wellPanel(
        h3('Disclaimer'),
        p(
          "No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site."
        )
      ),
      p(
        a(
          "Homepage",
          href = "../",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        " | ",
        a(
          "Website Error Messages",
          href = "javascript:myFunction()",
          #href = "mailto:rcalcsupport@ccf.org",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"
        ),
        style = "text-align: center;"
      ),
      img(src = '../logo-ccf.png', style = "max-width:50%; max-height:100%;")
      
    )
  )
)
