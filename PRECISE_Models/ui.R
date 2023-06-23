require(shiny)
require(shinydashboard)
library(shinyBS)

dashboardPage(skin = "blue", 

  dashboardHeader(title = "Risk Factors", titleWidth = 300),
  dashboardSidebar(width = 300,
    tags$head(
        tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon"),
        tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon"),
      tags$style(HTML(".sidebar {height: 100vh; overflow-y: auto;}") # close HTML
                 )# close tags$style

),

h4("Age"),    
sliderInput('AGE_SURGERY', NULL, min=18, max=100, value=63),

h4("Number of Previous Births"),
sliderInput('VPARITY', NULL, min=0, max=15, value=0),

h4("Race"),
selectInput('RACE3', NULL, choices = c("Black", "White", "Other")),
 
h4("Cardiac Disorder"),
selectInput('CARDIAC', NULL, choices = c("No", "Yes")),
bsTooltip('CARDIAC', "Cardiac disorder includes the presence of any disorder of the heart only.", "right", options = list(container = "body")),

 
h4("Upper Gastrointestinal Disorder"),
selectInput('uppergi', NULL, choices = c("No", "Yes")),
bsTooltip('uppergi', "Upper GI includes the presence of any disorder of the esophagus, stomach, duodenum, biliary or pancreatic tract.", "right", options = list(container = "body")),

h4("Lower Gastrointestinal Disorder"),
selectInput('lowergi', NULL, choices = c("No", "Yes")),
bsTooltip('lowergi', "Lower GI includes the presence of any disorder of the intestines, hernias.", "right", options = list(container = "body")),
 
h4("Vascular Disorder"),
selectInput('VASCULAR', NULL, choices = c("No", "Yes")),
bsTooltip('VASCULAR', "Vascular disorder includes the presence of any disorder of the blood, blood vessels and cells, marrow, spleen, lymphatics.", "right", options = list(container = "body")),

 
h4("Connective Tissue Disorder"),
selectInput('TISSUE', NULL, choices = c("No", "Yes")),
 
h4("Current health limits vigorous activities such as running, lifting heavy objects, participating in strenuous sports"),
selectInput('SF36Q3', NULL, choices = c("Not limited at all", "Limited a little", "Limited a lot")),
 
h4("Heavy Lifting Frequency"),
selectInput('lifting', NULL, choices = c("Never", "Less than once a month", "Once a month", "Two to three times a month", "Once a week", "More than once a week")),
 
h4("Smoking Status"),
selectInput('smoking.status', NULL, choices = c("Never", "Former", "Current")),
 
h4("Estrogen Therapy"),
selectInput('ESTROGEN', '*Any type', choices = c("No", "Yes")),
 
h4("Anticoagulant Use"),
selectInput('anticoag', NULL, choices = c("No", "Yes")),
 
h4("Number of body systems with baseline medical condition/diagnosis"),
numericInput('CMIRS_SUM', NULL, min=0, max=12, value=0),
 
h4("Prior Hysterectomy"),
selectInput('HYSTERECTOMY', '*Includes supracervical', choices = c("No", "Yes")),
 
h4("Prior surgery for prolapse"),
selectInput('PRIORPOP', NULL, choices = c("No", "Yes")),
 
h4("Body Mass Index"),
numericInput('BMI', NULL, min=15, max=60, value=27),

h4("POPQ Stage"),
selectInput('POPQ', NULL, choices = c("II", "III", "IV")),

h4("POPQ Stage C"),
sliderInput('C', NULL, min=-9, max=12, value=0),

h4("POPQ Stage Ba"),
sliderInput('BA', NULL, min=-3, max=12, value=0),

h4("POPQ Stage Bp"),
sliderInput('BP', NULL, min=-3, max=11, value=0),

h4("POPQ Stage GH"),
sliderInput('GH', NULL, min=0, max=11, value=0),

h4("Anesthesia Type"),
selectInput('anesthetics', NULL, choices = c("Regional", "General")),

h4("Concurrent Anterior Repair"),
selectInput('ANTERIORC', NULL, choices = c("No", "Yes")),

h4("Concurrent Posterior Repair"),
selectInput('POSTERIORC', NULL, choices = c("No", "Yes")),

h4("Concurrent Hysterectomy or oophrectomy"),
selectInput('HYSTOOP', NULL, choices = c("No", "Yes")),

h4("Concurrent Continence Procedure"),
selectInput('ANTIURINE', NULL, choices = c("Burch", "Sling/TVT", "Other", "None")),

h6("Includes cardiac, vascular, respiratory, EENT, upper GI, lower GI, hepatic, renal (kidneys only), other GU, MSI, Neurologic, Psychiatric, Endocrine-Metabolic")
  ),

  dashboardBody(
    
    
    h1(a("Predicting Recurrence and Complications One Year after Pelvic Organ Prolapse Surgery",
         href="https://www.ncbi.nlm.nih.gov/pubmed/29995735"), style = "color:Blue"),
    
    box(
      width = 100, status = "primary", solidHeader = F, background = "blue", collapsible=F,
      plotOutput("pred1", height = "700px")
    ),
    
    a("Website Error Messages",
                          href = "mailto:rcalcsupport@ccf.org",
 style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                          font-size: 15px;color: #2c3e50;font-weight: bold;text-align: center;text-decoration: underline;")
        
  )
)