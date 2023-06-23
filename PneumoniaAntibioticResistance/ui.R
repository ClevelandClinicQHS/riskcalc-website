library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)

fluidPage(
  shinyjs::useShinyjs(), theme = shinytheme("flatly"),
  # Application title
  titlePanel("Community-Acquired Pneumonia Antibiotic Resistance Model"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        selectInput('gender', 'Gender', choices = c('Female', 'Male')),
        selectInput('smoker', 'Smoker', choices=c('No', "Yes")),
        selectInput('snf', 'Admitted from SNF/ICF', choices=c('No', "Yes")),
        selectInput('pre_admission', 'Previous admission within 1 year ', choices=c('No', "Yes")),
        selectInput('recent', 'Had an Organism Resistant to CAP therapy in past year', choices=c('No', "Yes")),
        selectInput('paralysis', 'Paralysis', choices=c('No', "Yes")),
        selectInput('cpd', 'Chronic pulmonary disease', choices=c('No', "Yes")),
        selectInput('ulcer', 'Pressure ulcer', choices=c('No', "Yes")),
        selectInput('loss', 'Low functional status/ weight loss', choices=c('No', "Yes")),
        selectInput('icu', 'In ICU', choices=c('No', "Yes")),
        selectInput('imv', 'On IMV', choices=c('No', "Yes")),
        selectInput('vasopressors', 'On Vasopressors', choices=c('No', "Yes")),
      
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
