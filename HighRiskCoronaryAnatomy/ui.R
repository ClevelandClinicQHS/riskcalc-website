
require(shinythemes)
library(shinyBS)

fluidPage(theme = shinytheme("flatly"),
          
          titlePanel('Predicting High-Risk Coronary Anatomy'),
          hr(),
          sidebarLayout(
            sidebarPanel(id = "sidebar",
                         textInput('Age', 'Age (Years)', placeholder = '18 - 90'),
                         selectInput('Gender', 'Gender', choices = c('Female', 'Male')),
                         selectInput("fam", "Family history of CAD", choices = c('No', 'Yes')),
                         selectInput("diabetes", "Diabetes", choices = c('No', 'Yes')),
                         selectInput("HYPERTENSION", "Hypertension", choices = c('No', 'Yes')),
                         selectInput("HYPERCHOLESTEROL", "Hypercholesterol", choices = c('No', 'Yes')),
                         selectInput("block", "Complete left bundle branch block", choices = c('No', 'Yes')),
                         selectInput('duke', 'Duke treadmill score', choices = c('Unknown', '<= -11', '-10 ~ 4', ">= 5")),
                         selectInput('chest', 'Chest pain at presentation', choices = c('Unknown', 'Typical', 'Atypical')),
                         numericInput('exercise', "Total_Exercise_Time (min)", value = 0, min = 0, max = 100000),
                         numericInput('hdl', "HDL (mg/dl)", value = 50, min = 0, max = 200)
            ),
            mainPanel(
              actionButton("goButton", "Run Calculator"),
              br(),
              hr(),
              tags$head(
                tags$style(type="text/css", "tfoot {display:none;}")
              ),
              DT::dataTableOutput('result'),
              br(),
              wellPanel(h3('Disclaimer'),
                        p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
              p(a("Homepage",
                  href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                " | ",
                a("Contact Us",
                  href = "mailto:rcalcsupport@ccf.org?body=Diabetes%20-%20Predicting%206-Year%20Mortality%20Risk", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
                style = "text-align: center;"),
              img(src='../logo-ccf.png', style = "max-width:50%; max-height:100%;"))
            ))