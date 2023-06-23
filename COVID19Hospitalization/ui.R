

fluidPage(
  useShinyjs(),
    tags$script(HTML(
    'function myFunction() {
  var txt;
  if (confirm("This is a mailbox for reporting website errors to programmers for the risk calculator website.  If you have questions or concerns about a specific calculator, please use the calculator Author Contact Information found on the publication for that calculator.  Each calculator is documented by a specific publication with a corresponding author.")) {
    window.open("mailto:rcalcsupport@ccf.org");
  }
}'
  )),
  theme = shinytheme("flatly"),
  titlePanel('Predict Hospitalization Risk for COVID-19 Positive'),
  sidebarLayout(
    sidebarPanel(id = "sidebar",
                 numericInput('age', 'Age', value = 18, min=0, max = 100),
                 bsTooltip("age", "Range: 0 - 100", "right", options = list(container = "body")),
                 selectInput('Race', 'Race', choices = c('Asian', 'Black', 'White', 'Other')),
                 selectInput('Ethnicity', 'Ethnicity', choices = c('Non-Hispanic', 'Hispanic', 'Unknown')),
                 selectInput('Gender', 'Gender', choices = c('Male', 'Female')),
                 selectInput('Smoking', 'Smoking', choices = c('No', "Current Smoker", 'Former Smoker', "Unknown")),
                 numericInput('BMI', 'BMI', value = 21, min=4, max = 60),
                 bsTooltip("BMI", "Range: 4 - 60", "right", options = list(container = "body")),
                 materialSwitch(inputId = "geo", label = 'ZIP?'),
                 conditionalPanel(
                   condition = "input.geo == true",
                   textInput('ZIP', "5 digit ZIP code")
                 ),
                 selectizeInput('risk', 'Symptoms and risks', 
                                choices = c(#"Exposed to COVID-19" = "Expose_to_covid_19",
                                            #"Other family members with COVID-19"="Family_covid_19",
                                            'Fever',
                                            "Fatigue",
                                            "Shortness of breath"='Sob',
                                            #"Sputum production"="Sputum_production",
                                            "Diarrhea",
                                            #"Loss of appetite"="Loss_of_appetite",
                                            "Vomiting"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 selectizeInput('comorbidities', 'Comorbidities', 
                                choices = c(#"COPD/Emphysema"="Copd_emphysema",
                                            "Asthma","Diabetes", "Hypertension", 
                                            #"Transplant history"="Transplant_history",
                                            #"Multiple sclerosis"="Multiple_sclerosis",
                                            #"IBD"="Ibd",
                                            "Immunosuppressive disease" = "Immunosuppressive_disease"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 #selectInput('pneumovax_shot', 'Pneumococcal polysaccharide vaccine', choices = c('No', 'Yes')),
                 #selectInput('flu_shot', 'Influenza vaccine', choices = c('No', 'Yes')),
                 selectizeInput('medications', 'Pre-testing medications', 
                                choices = c("Immunosuppressive treatment"="Immunosuppressive_treatment",
                                            "NSAIDS" = "nsaids"), 
                                            #"Steroids" = "steroids",  
                                            #"Carvedilol" = "carvedilol",  
                                            #"Melatonin" = "melatonin"),
                                multiple = T, 
                                options = list('plugins' = list('remove_button'),'create' = TRUE,'persist' = FALSE)),
                 materialSwitch("platelets", "Platelets?", status="success", inline=T),
                 materialSwitch("ast", "AST?", status="success", inline=T),
                 materialSwitch("bun", "BUN?", status="success", inline=T),
                 materialSwitch("chloride", "Chloride?", status="success", inline = T),
                 #materialSwitch("creatinine", "Creatinine?", status="success", inline=T),
                 #materialSwitch("hematocrit", "Hematocrit?", status="success", inline=T),
                 materialSwitch("potassium", "Potassium?", status="success", inline=T),
                 conditionalPanel(
                   condition = 'input.platelets==true',
                   numericInput('pre_testing_platelets', 'Platelets (k/uL)', value = 150, min = 100, max = 500, step=0.1),
                   bsTooltip("pre_testing_platelets", "Range: 100 - 500", "right", options = list(container = "body"))
                 ),conditionalPanel(
                   condition = 'input.ast==true',
                   numericInput('pre_testing_ast', 'AST (U/L)', value=7, min = 0, max = 200),
                   bsTooltip("pre_testing_ast", "Range: 0 - 200", "right", options = list(container = "body"))
                 ),
                 conditionalPanel(
                   condition = 'input.bun==true',
                   numericInput('pre_testing_bun', 'BUN (mg/dL)', value = 16, min = 0, max = 60, step = 1),
                   bsTooltip("pre_testing_bun", "Range: 0 - 60", "right", options = list(container = "body"))
                 ),
                 conditionalPanel(
                   condition = 'input.chloride==true',
                   numericInput('pre_testing_chloride', 'Chloride (mmol/L)', value = 97, min = 97, max = 105, step=0.1),
                   bsTooltip("pre_testing_chloride", "Range: 97 - 105", "right", options = list(container = "body"))
                 ),
                 # conditionalPanel(
                 #   condition = 'input.creatinine==true',
                 #   numericInput('pre_testing_creatinine', 'Creatinine (mg/dL)', value=0.58, min = 0.58, max = 0.96, step=0.01),
                 #   bsTooltip("pre_testing_creatinine", "Range: 0.58 - 0.96", "right", options = list(container = "body"))
                 # ),
                 # conditionalPanel(
                 #   condition = 'input.hematocrit==true',
                 #   numericInput('pre_testing_hematocrit', 'Hematocrit (%)', value = 36, min = 36, max = 46, step=0.1),
                 #   bsTooltip("pre_testing_hematocrit", "Range: 36 - 46", "right", options = list(container = "body"))
                 # ),
                 conditionalPanel(
                   condition = 'input.potassium==true',
                   numericInput('pre_testing_potassium', 'Potassium (mEq/L)', value = 3, min= 2, max = 9, step = 0.1),
                   bsTooltip("pre_testing_potassium", "Range: 2 - 9", "right", options = list(container = "body"))
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
      wellPanel(
        h3('Click Below for Calculator and Author Contact Information'),
        p(
          "Jehi, L., Ji, X., Milinovich, A., Erzurum, S., Merlino, A., Gordon, S., Young, J. B., & Kattan, M. W. (2020).",
          a(
            "Development and validation of a model for individualized prediction of hospitalization risk in 4,536 patients with COVID-19. ",
            href = "https://doi.org/10.1371/journal.pone.0237419"
          ),
          "PloS one, 15(8), e0237419. "
        )
      ),
      wellPanel(h3('Disclaimer'),
                p("No Medical Advice. ALTHOUGH SOME CONTENT MAY BE PROVIDED BY INDIVIDUALS IN THE MEDICAL PROFESSION, YOU ACKNOWLEDGE THAT PROVISION OF SUCH CONTENT DOES NOT CREATE A MEDICAL PROFESSIONAL-PATIENT RELATIONSHIP AND DOES NOT CONSTITUTE AN OPINION, MEDICAL ADVICE, PROFESSIONAL DIAGNOSIS, SERVICE OR TREATMENT OF ANY CONDITION. Access to general information is provided for educational purposes only, through this site and links to other sites. Content is not recommended or endorsed by any doctor or healthcare provider. The information and Content provided are not substitutes for medical or professional care, and you should not use the information in place of a visit, call, consultation or the advice of your physician or other healthcare provider. You are liable or responsible for any advice, course of treatment, diagnosis or any other information, services or product obtained through this site.")),
      p(a("Homepage",
          href = "../", style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        " | ",
        a("Website Error Messages",
          href = "javascript:myFunction()",
          style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;"), 
        style = "text-align: center;"),
      img(src='../logo-ccf.png', style = "max-width:50%; max-height:100%;"))))
