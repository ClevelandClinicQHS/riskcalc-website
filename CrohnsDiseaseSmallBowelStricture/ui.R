
library(shiny)
library(rms) 
library(dplyr)
library(shinyWidgets)
library(shinyBS) 
library(shinythemes) 
library(shinyjs)

load("model.RData")

# Define UI for application that draws a histogram
fluidPage(
    useShinyjs(),
    theme = shinytheme("flatly"),
    # Application title
    titlePanel(h1("Crohn's disease small bowel stricture risk calculator")), 

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(id = "sidebar",
                     selectInput('bio', 'Were biologics used at the time of stricture imaging?', choices = c('No', "Yes")), 
                     numericInput("dur", "Stricture duration (Months)", NA, min = 0, max = 147), 
                     selectInput('index1', 'Abdominal pain?', choices = c('No', "Yes")), 
                     selectInput('index2', 'Postprandial abdominal pain?', choices = c('No', "Yes")), 
                     selectInput('index3', 'Acute abdominal distention?', choices = c('No', "Yes")), 
                     selectInput('index4', 'Bloating?', choices = c('No', "Yes")), 
                     selectInput('index5', 'Abdominal cramping?', choices = c('No', "Yes")), 
                     selectInput('index6', 'Dietary restrictions?', choices = c('No', "Yes")), 
                     selectInput('index7', 'Nausea and/or vomiting?', choices = c('No', "Yes")), 
                     numericInput("len", "Length of Stricture (cm)", NA, min = 1, max = 70), 
                     numericInput("max", "Maximal Wall Thickness of Stricture (mm)", NA, min = 2, max = 17), 
                     numericInput("Ti", "Predicted Time Scale (Months)", NA, min = 1, max = 48), 
                     
                     # tip message
                     bsTooltip(id = 'dur', title = "Range: 0 - 147; time from date of stricture diagnosis to date of current stricture imaging", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = 'len', title = "Range: 1 - 70", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "max", title = "Range: 2 - 17", placement = "right", trigger = "hover", options = list(container = "body")),
                     bsTooltip(id = "Ti", title = "Range: 1- 48", placement = "right", trigger = "hover", options = list(container = "body")),
        ),
        
        mainPanel(
            actionButton("click", "Run Calculator"),
            br(),
            hr(),
            tags$head(
                tags$style(type="text/css", "tfoot {display:none;}")
            ),
            DT::dataTableOutput('result'),
            br(),
            wellPanel(p("*This applies to adult patients with no more than 2 Crohn's disease-associated terminal ileal strictures on imaging, not associated with an ileostomy or an ileal pouch anal anastomosis, and in the absence of concurrent internal penetrating complications or colonic strictures.")), 
            wellPanel(h3('Reference'),p("<Insert it after published>")),
            wellPanel(h3('Disclaimer'),
                      p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")), 
            p(a("Homepage",
                href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                                   font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"),
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
            img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        ) 
        
    ) 
)







