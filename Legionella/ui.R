library(shiny)
library(shinyBS)
library(shinythemes)
library(shinyjs)

fluidPage(
  shinyjs::useShinyjs(), theme = shinytheme("flatly"),
  # Application title
  titlePanel("Predicting probability of positive Legionella test"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        selectInput('region', 'Region', choices=c('Northeast', 'Midwest', 'South', 'West')),
        selectInput('Summer6_10', 'June-October', choices=c('No', "Yes")),
        selectInput('recent', 'Legionnaire’s Disease in hospital in past 30 days', choices=c('No', "Yes")),
        selectInput('male', 'Sex', choices = c('Female', 'Male')),
        selectInput('CHRNLUNG', 'Chronic Lung Disease', choices=c('No', "Yes")),
        selectInput('smoker', 'Smoker', choices=c('No', "Yes")),
        selectInput('Hyponatremia', 'Hyponatremia', choices=c('No', "Yes")),
        selectInput('Diarrhea', 'Diarrhea', choices=c('No', "Yes")),
        selectInput('p6m_adm', 'Admission in past 6 months', choices=c('No', "Yes")),
      
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
