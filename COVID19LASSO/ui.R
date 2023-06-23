library(shinyWidgets)
require(shinythemes)
fluidPage(theme = shinytheme("flatly"),
          titlePanel('Predict COVID-19 test result'),
          sidebarLayout(
              sidebarPanel(id = "sidebar",
                           numericInput('age', 'Age', value = 18, min=0, max = 100),
                           selectInput('Race', 'Race', choices = c('Asian', 'Black', 'White', 'Other')),
                           selectInput('Ethnicity', 'Ethnicity', choices = c('Hispanic', 'Non-Hispanic', 'Unknown')),
                           selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                           selectInput('Smoking', 'Smoking', choices = c('No', "Current Smoker", 'Former Smoker', "Unknown")),
                           selectizeInput('risk', 'Symptoms and risks', 
                                       choices = c('Cough',
                                                   "Exposure to COVID-19"="Expose_to_covid_19",  
                                                   "Other family members with COVID-19"="Family_covid_19",
                                                   "Fever", "Flu like symptoms"="Flu_like_symptoms",
                                                   "Shortness of breath"='Sob',"Recent Travel"="Recent_Travel",
                                                   "Loss of appetite"="Loss_of_appetite", "Vomiting"),
                                       multiple = T, 
                                       options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                           selectizeInput('comorbidities', 'Comorbidities', 
                                          choices = c("Copd/emphysema"="Copd_emphysema",
                                                      "Asthma", "Diabetes", "Hypertension", 
                                                      "Coronary artery disease"="Coronary_artery_disease",
                                                      "Heart failure"="Heart_failure","Cancer",
                                                      "Immunosuppressive_treatment"="Immunosuppressive_treatment",
                                                      "Multiple sclerosis"="Multiple_sclerosis",
                                                      "Connective tissue disease"="Connective_tissue_disease",
                                                      "Immunosuppressive disease" = "Immunosuppressive_disease",
                                                      "Connective tissue disease"="Connective_tissue_disease",
                                                      "IBD"="Ibd"),
                                          multiple = T, 
                                          options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                           selectInput('pneumovax_shot', 'Pneumovax vaccine', choices = c('No', 'Yes')),
                           selectInput('flu_shot', 'Flu vaccine', choices = c('No', 'Yes')),
                           selectizeInput('medications', 'Pre testing medications', 
                                          choices = c("Steroids" = "steroids",  "Carvedilol" = "carvedilol",  
                                            "Paroxetine" = "paroxetine",  "Melatonin" = "melatonin", "NSAIDS" = "nsaids",
                                            "ACE Inhibitor"="ace_inhibitor",
                                            "Angiotensin receptor blocker" = "arb", "Chloroquine"="colchicine"),
                                          multiple = T, 
                                          options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                           materialSwitch("platelets", "Platelets?", status="success", inline=T),
                           materialSwitch("bun", "BUN?", status="success", inline=T),
                           materialSwitch("chloride", "Chloride?", status="success", inline = T),
                           materialSwitch("creatinine", "Creatinine?", status="success", inline=T),
                           materialSwitch("ast", "AST?", status="success", inline=T),
                           materialSwitch("hematocrit", "Hematocrit?", status="success", inline=T),
                           materialSwitch("potassium", "Potassium?", status="success", inline=T),
                           conditionalPanel(
                             condition = 'input.platelets==true',
                             numericInput('pre_testing_platelets', 'Platelets (k/uL)', value = 150, min = 150, max = 400, step=0.1)
                           ),
                           conditionalPanel(
                             condition = 'input.bun==true',
                             numericInput('pre_testing_bun', 'BUN (mg/dL)', value = 7, min = 7, max = 21, step = 0.1)
                           ),
                           conditionalPanel(
                             condition = 'input.chloride==true',
                             numericInput('pre_testing_chloride', 'Chloride (mmol/L)', value = 97, min = 97, max = 105, step=0.1)
                           ),conditionalPanel(
                             condition = 'input.ast==true',
                             numericInput('pre_testing_ast', 'AST', value=7, min = 0, max = 200)
                           ),conditionalPanel(
                             condition = 'input.creatinine==true',
                             numericInput('pre_testing_creatinine', 'Creatinine (mg/dL)', value=0.58, min = 0.58, max = 0.96, step=0.01)
                           ),
                           conditionalPanel(
                             condition = 'input.hematocrit==true',
                             numericInput('pre_testing_hematocrit', 'Hematocrit (%)', value = 36, min = 36, max = 46, step=0.1)
                           ),
                           conditionalPanel(
                             condition = 'input.potassium==true',
                             numericInput('pre_testing_potassium', 'Potassium ', value = 3, min= 2, max = 9, step = 0.1)
                           )
                           
                           
              ),
              mainPanel(
                  actionButton("goButton", "Run Calculator"),
                  br(),
                  br(),
                  tags$head(
                      tags$style(type="text/css", "tfoot {display:none;}")
                  ),
                  DT::dataTableOutput('result'),
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
                  img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;"))))