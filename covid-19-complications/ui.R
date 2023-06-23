library(shinyWidgets)
require(shinythemes)
library(shinyBS)
library(shinyjs)
library(dplyr)

fluidPage(
  useShinyjs(),
  theme = shinytheme("flatly"),
  titlePanel('Predict Probability of Having Complications for Patients with Covid-19 '),
  sidebarLayout(
    sidebarPanel(id = "sidebar",
                 numericInput('Age', 'Age', value = 50, min=20, max = 80),
                 bsTooltip("Age", "Range: 20 - 80", "right", options = list(container = "body")),
                 numericInput('lymphocyte_109_L', 'Lymphocyte count, 10^9/L (normal range, 1.1 ~ 3.2)', value = 1.5, min=0.2, max = 3.2, step = 0.1),
                 bsTooltip("lymphocyte_109_L", "Range: 0.2 - 3.2", "right", options = list(container = "body")),
                 selectInput("Gender", "Gender",choices = c("Female", "Male")),
                 selectInput("CT_severity_level", "CT Severity Level", choices = c("None or Mild", "Moderate", "Severe"))
    ),
    mainPanel(
      actionButton("goButton", "Run Calculator"),
      br(),
      br(),
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
