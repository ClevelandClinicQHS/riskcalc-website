library(shinyWidgets)
require(shinythemes)
library(shinyBS)
library(shinyjs)
library(dplyr)

fluidPage(
  useShinyjs(),
  theme = shinytheme("flatly"),
  titlePanel('Predict Risk of ICU/Death for COVID-19 Positive'),
  sidebarLayout(
    sidebarPanel(id = "sidebar",
                 numericInput('age', 'Age', value = 18, min=0, max = 100),
                 bsTooltip("age", "Range: 0 - 100", "right", options = list(container = "body")),
                 selectInput('DischargedInRecent14Days', 'Discharged In Recent 14 Days?', choices = c("No", "Yes")),
                 selectizeInput('risk', 'Symptoms and risks', 
                                choices = c('Flu like symptoms' = 'Flu_like_symptoms',
                                            "Vomiting"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 selectizeInput('comorbidities', 'Comorbidities', 
                                choices = c("COPD/Emphysema"="Copd_emphysema",
                                            "Asthma",
                                            "Diabetes", 
                                            "Transplant history"="Transplant_history"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 selectizeInput('medications', 'Pre-testing medications', 
                                choices = c("NSAIDS" = "nsaids", 
                                            "Carvedilol" = "carvedilol", 
                                            "ARB" = "arb"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 materialSwitch("bun", "BUN?", status="success", inline=T),
                 materialSwitch("crp", "CRP?", status="success", inline=T),
                 conditionalPanel(
                   condition = 'input.bun==true',
                   numericInput('pre_testing_bun', 'BUN (mg/dL)', value = 7, min = 1, max = 60, step=1),
                   bsTooltip("pre_testing_bun", "Range: 1 - 60", "right", options = list(container = "body"))
                 ),conditionalPanel(
                   condition = 'input.crp==true',
                   numericInput('pre_testing_crp', 'CRP (mg/L)', value=5, min = 0, max = 30, step=0.1),
                   bsTooltip("pre_testing_crp", "Range: 0 - 30", "right", options = list(container = "body"))
                 )
    
    ),
    mainPanel(
      actionButton("goButton", "Run Calculator"),
      br(),
      br(),
      tags$head(
        tags$style(type="text/css", "tfoot {display:none;}")
      ),
      shinyjs::hidden(div(id = "result_panel",DT::dataTableOutput('result'))),
      br(),
      #wellPanel(h3('Reference'),p("")),
      wellPanel(h3('Disclaimer'),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
      p(a("Homepage",
          href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        " | ",
        a("Contact Us",
          href = "mailto:rcalcsupport@ccf.org?body=30-day%20and%2012-month%20Outcomes%20after%20Discharge%20for%20an%20Acute%20Coronary%20Syndrome", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        style = "text-align: center;"),
      img(src='../logo-ccf.png', style = "max-width:50%; max-height:100%;"))))
