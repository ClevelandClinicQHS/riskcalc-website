require(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Next Generation Prostate Cancer Risk Calculator"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    h3("Risk Factors"),
    sliderInput('AGEDX', "Age", min=18, max=100, value=63),
    selectInput('EBC', "Race", choices=c("Black", "Caucasian", "Other")),
    selectInput('maritalstat', "Marital Status", choices = c("married", "unmarried", "widowed")),
    selectInput('employstat', "Employement Status", choices = c("employed", "retired", "unemployed")),
    selectInput('SMOKER', "Current Smoker", choices = c("No", "Yes")),
    sliderInput('BMI', "Body Mass Index (BMI)", min=12, max=60, value=25),
    numericInput('CHOLESTEROL', "Cholesterol", 210),
    numericInput('PSA', "PSA", 6, min=0.02, max=100),
    numericInput('PSARAT', "Free:Total Ratio", 0.15, min=0.0007, max=8),
    selectInput('FH', "Family History of Prostate Cancer", choices = c("No", "Yes")),
    sliderInput('AUA', "AUA Symptom Score", min=0, max=35, value=7),
    selectInput('DRE', "Digital Rectal Exam", choices = c("No", "Yes")),
    selectInput('BLADDERCA', "Bladder Cancer", choices = c("No", "Yes")),
    selectInput('ANGINA', "Angina", choices = c("No", "Yes")),
    selectInput('CABG', "CABG", choices = c("No", "Yes")),
    h5("Charlson Comorbidity Scoring"),
    checkboxInput('MI', "Myocardial Infarction", FALSE),
    checkboxInput('CHF', "Congestive Heart Failure", FALSE),
    checkboxInput('PVOD', "Peripheral Disease", FALSE),
    checkboxInput('CVA', "Cerebrovascular Disease", FALSE),
    checkboxInput('DEMENTIA', "Dementia", FALSE),
    checkboxInput('COPD', "COPD", FALSE),
    checkboxInput('COLLVASC', "Connective Tissue Disease", FALSE),
    checkboxInput('ULCER', "Peptic Ulcer Disease", FALSE),
    checkboxInput('MILDLIVER', "Mild Liver Disease", FALSE),
    checkboxInput('DIABETES', "Diabetes without End-Organ Damage", FALSE),
    checkboxInput('HEMIPLEGIA', "Hemiplegia", FALSE),
    checkboxInput('MODSEVRENAL', "Moderate/Severe Renal Disease", FALSE),
    checkboxInput('DIABENDORGAN', "Diabetes with End-Organ Damage", FALSE),
    checkboxInput('OTHERTUMOR', "Tumor without Metastasis", FALSE),
    checkboxInput('LEUKEMIA', "Leukemia", FALSE),
    checkboxInput('LYMPHOMA', "Lymphoma", FALSE),
    checkboxInput('MODSEVLIVER', "Moderate/Severe Liver Disease", FALSE),
    checkboxInput('METASTATIC', "Metastatic Solid Tumor", FALSE),
    checkboxInput('AIDS', "AIDS", FALSE)
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h4(textOutput("Pred1.text")),
    h4(textOutput("Pred2.text")),
    #tableOutput("table"),
    plotOutput("P.Plot", width="90%", height=700)
  )
))