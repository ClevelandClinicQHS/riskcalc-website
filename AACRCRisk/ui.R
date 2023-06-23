
library(shiny)
library(rms) 
library(dplyr)
library(shinyWidgets)
library(shinyBS) 
library(shinythemes) 
library(shinyjs)


# Define UI for application that draws a histogram
fluidPage(
    useShinyjs(),
    theme = shinytheme("flatly"),
    # Application title
    titlePanel(h1("Advanced adenoma and CRC predicted risk calculator in adults younger than 45 years old (AACRC-PRC)")), 

    navbarPage("Navigator", 
        
        tabPanel("Composite (AA/CRC)", 
                 # Sidebar with a slider input for number of bins 
                 sidebarLayout(
                     sidebarPanel(id = "sidebar1", 
                                  numericInput("bmi", "BMI (kg/m2)", NA, min = 12.84, max = 59.97), 
                                  selectInput('sex', 'Sex', choices = c('Female',"Male")), 
                                  selectInput('race1', 'Race', choices = c('Black','White',"Other")), 
                                  selectInput('ethnic', 'Ethnic Group', choices = c('Not Hispanic',"Hispanic")), 
                                  selectInput('smoking', 'Tobacco Use', choices = c('Never', "Ever")), 
                                  selectInput('alcohol', 'Alcohol Use', choices = c('Never', "Ever")), 
                                  selectInput('diabetes', 'Diabetes', choices = c('No', "Yes")), 
                                  selectInput('hpl', 'Hyperlipidemia', choices = c('No', "Yes")), 
                                  selectInput('crc_history', 'Any Family History of CRC', choices = c('No', "Yes")),  
                                  selectInput('asa', 'ASA', choices = c("No","Yes")), 
                                  
                                  # tip message
                                  ## bsTooltip(id = 'race1', title = "If White, choose No", placement = "right", trigger = "hover", options = list(container = "body")),
                                  ## bsTooltip(id = 'race', title = "Any race except White and Black", placement = "right", trigger = "hover", options = list(container = "body")),
                                  bsTooltip(id = "smoking", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")),
                                  bsTooltip(id = "alcohol", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  bsTooltip(id = "diabetes", title = "Diagnosed as Diabetes or A1c(%) >= 6.5", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  bsTooltip(id = "hpl", title = "Diagnosed as Hyperlipidemia or LDL(mg/dl) > 130", placement = "right", trigger = "hover", options = list(container = "body"))
                     ),
                     
                     mainPanel(
                         actionButton("click1", "Run Calculator"),
                         br(),
                         hr(),
                         tags$head(
                             tags$style(type="text/css", "tfoot {display:none;}")
                         ),
                         DT::dataTableOutput('result1'),
                         br(),
                         wellPanel(h3('Instructions'), p("Predicts risk of advanced adenoma and colorectal cancer in men and women younger than age 45 to help identify who may benefit from early colorectal cancer screening.")), 
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
            
        ), 
        
        tabPanel("Advanced Adenoma", 
                 # Sidebar with a slider input for number of bins 
                 sidebarLayout(
                     sidebarPanel(id = "sidebar2", 
                                  numericInput("bmi2", "BMI (kg/m2)", NA, min = 12.84, max = 59.97), 
                                  selectInput('sex2', 'Sex', choices = c('Female',"Male")), 
                                  selectInput('race2', 'Race', choices = c('Black','White',"Other")), 
                                  selectInput('ethnic2', 'Ethnic Group', choices = c('Not Hispanic',"Hispanic")), 
                                  selectInput('smoking2', 'Tobacco Use', choices = c('Never', "Ever")), 
                                  selectInput('alcohol2', 'Alcohol Use', choices = c('Never', "Ever")), 
                                  selectInput('diabetes2', 'Diabetes', choices = c('No', "Yes")), 
                                  selectInput('hpl2', 'Hyperlipidemia', choices = c('No', "Yes")), 
                                  selectInput('crc_history2', 'Any Family History of CRC', choices = c('No', "Yes")),  
                                  selectInput('asa2', 'ASA', choices = c("No","Yes")), 
                                  
                                  # tip message
                                  ## bsTooltip(id = 'race1', title = "If White, choose No", placement = "right", trigger = "hover", options = list(container = "body")),
                                  ## bsTooltip(id = 'race', title = "Any race except White and Black", placement = "right", trigger = "hover", options = list(container = "body")),
                                  bsTooltip(id = "smoking2", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")),
                                  bsTooltip(id = "alcohol2", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  bsTooltip(id = "diabetes2", title = "Diagnosed as Diabetes or A1c(%) >= 6.5", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  bsTooltip(id = "hpl2", title = "Diagnosed as Hyperlipidemia or LDL(mg/dl) > 130", placement = "right", trigger = "hover", options = list(container = "body"))
                     ),
                     
                     mainPanel(
                         actionButton("click2", "Run Calculator - AA"),
                         br(),
                         hr(),
                         tags$head(
                             tags$style(type="text/css", "tfoot {display:none;}")
                         ),
                         DT::dataTableOutput('result2'),
                         br(),
                         wellPanel(h3('Instructions'), p("Predicts risk of advanced adenoma and colorectal cancer in men and women younger than age 45 to help identify who may benefit from early colorectal cancer screening.")), 
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
            
        ), 
        tabPanel("CRC", 
                 # Sidebar with a slider input for number of bins 
                 sidebarLayout(
                     sidebarPanel(id = "sidebar3", 
                                  selectInput('diabetes3', 'Diabetes', choices = c('No', "Yes")),   
                                  selectInput('crc_history3', 'Any Family History of CRC', choices = c('No', "Yes")),  
                                  selectInput('reason3', 'Reason', choices = c("Low Risk","High Risk")), 
                                  
                                  # tip message
                                  ## bsTooltip(id = 'race1', title = "If White, choose No", placement = "right", trigger = "hover", options = list(container = "body")),
                                  ## bsTooltip(id = 'race', title = "Any race except White and Black", placement = "right", trigger = "hover", options = list(container = "body")),
                                  ## bsTooltip(id = "smoking", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")),
                                  ## bsTooltip(id = "alcohol", title = "Ever: Quit/Passive Use/Current Use", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  bsTooltip(id = "diabetes", title = "Diagnosed as Diabetes or A1c(%) >= 6.5", placement = "right", trigger = "hover", options = list(container = "body")), 
                                  ## bsTooltip(id = "hpl", title = "Diagnosed as Hyperlipidemia or LDL(mg/dl) > 130", placement = "right", trigger = "hover", options = list(container = "body"))
                     ), 
                     
                     mainPanel(
                         actionButton("click3", "Run Calculator - CRC"),
                         br(),
                         hr(),
                         tags$head(
                             tags$style(type="text/css", "tfoot {display:none;}")
                         ),
                         DT::dataTableOutput('result3'),
                         br(), 
                         wellPanel(h3('Instructions'), p("Predicts risk of advanced adenoma and colorectal cancer in men and women younger than age 45 to help identify who may benefit from early colorectal cancer screening.")), 
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
        
    )
     
)







