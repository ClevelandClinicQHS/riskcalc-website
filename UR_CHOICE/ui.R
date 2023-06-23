require(shiny)
require(shinydashboard)

dashboardPage(skin = "blue", 
  dashboardHeader(title = "Risk Factors", titleWidth = 300),
  dashboardSidebar(width = 300,
    tags$head(
        tags$link(rel="shortcut icon", href="../assets/icons/favicon.ico", type="image/x-icon"),
        tags$link(rel="apple-touch-icon", href="../assets/icons/apple-touch-icon.png", type="image/x-icon"),
      tags$style(HTML(".sidebar {height: 100vh; overflow-y: auto;}") # close HTML
                 )# close tags$style

),

h4("Maternal Age at Delivery"),    
sliderInput('Age', NULL, min=14, max=34, value=28),

h4("Number of Previous Births"),
sliderInput('parity', NULL, min=0, max=10, value=0),

conditionalPanel(condition = "input.parity > 0",
h4("History of Any Vaginal Birth"),
selectInput('Hx_Vaginal', NULL, choices = c("No", "Yes")),

conditionalPanel(condition = "input.Hx_Vaginal == 'Yes'",
  h4("History of Forceps-Assisted Birth"),
  selectInput('Hx.Forcept.Vag', NULL, choices = c("No", "Yes"))
),

conditionalPanel(condition = "input.Hx_Vaginal == 'Yes'",
  h4("History of Unassisted Birth"),
  selectInput('Hx.Unassist.Vag', NULL, choices = c("No", "Yes"))
),

conditionalPanel(condition = "input.Hx_Vaginal == 'Yes'",
  h4("Total Number of Vacuum-Assisted Births"),
  sliderInput('vacuum', NULL, min=0, max=5, value=0)
),

conditionalPanel(condition = "input.Hx_Vaginal == 'Yes'",
  h4("Total Number of Unassisted Vaginal Births"),
  sliderInput('svd', NULL, min=0, max=5, value=0)
),

h4("History of Any C-Section"),
selectInput('Hx_CSec', NULL, choices = c("No", "Yes")),

conditionalPanel(condition = "input.Hx_CSec == 'Yes'",
  h4("History of Planned C-Section"),
  selectInput('Hx.Plan.CSec', NULL, choices = c("No", "Yes"))
),

conditionalPanel(condition = "input.Hx_CSec == 'Yes'",
  h4("Total Number of Planned C-Sections"),
  sliderInput('electivecs', NULL, min=0, max=5, value=0)
),

conditionalPanel(condition = "input.Hx_CSec == 'Yes'",
  h4("Total Number of Acute C-Sections"),
  sliderInput('emergencycs', NULL, min=0, max=5, value=0)
)
),

h4("Maternal Pre-Pregnancy Weight"),
numericInput('PrepregWeight', "(kilograms)", min=38, max=130, value=NULL),
h6("or"),
numericInput('PrepregWeight_lb', "(pounds)", min=83, 286, value=NULL),

h4("Maternal Height"),
numericInput('height', "(centimeters)", min=120, max=190, value=NULL),
h6("or"),
numericInput('height.ft', "(feet)", min=3, max=7, value=NULL),
numericInput('height.in', "(inches)", min=0, max=12, value=NULL),

h4("Estimated Infant Birthweight"),
numericInput('FetalWeight', "(grams)", min=370, max=6000, value=NULL),
h6("or"),
numericInput('FetalWeight.p', "(pounds)", min=0, max=14, value=NULL),
numericInput('FetalWeight.o', "(ounces)", min=0, max=211, value=NULL),

h4("Estimated Infant Head Circumference"),
numericInput('circumference', "(centimeters)", min=0, max=60, value=NULL),

h4("History of Diabetes"),
selectInput('DIABETES', NULL, choices = c("No", "Yes")),

h4("Family History of POP"),
selectInput('FH.POP', NULL, choices = c("No", "Yes")),

h4("Family History of UI"),
selectInput('FH.UI', NULL, choices = c("No", "Yes")),

h4("Family History of FI"),
selectInput('FH.FI', NULL, choices = c("No", "Yes")),

h4("Pre-Pregnancy UI"),
selectInput('uiprepreg', NULL, choices = c("No", "Yes")),

h4("UI During Pregnancy"),
selectInput('uiduringpreg', NULL, choices = c("No", "Yes"))





  ),
  dashboardBody(
    
    
    h1("UR-CHOICE Pelvic Floor Disorders Risk Calculator", style = "color:Blue"),
    
    box(
      width = 100, status = "primary", solidHeader = TRUE, background = "blue", title="12-Year Risk for Women with One or More Previous Births.", collapsible=T,
      plotOutput("pred1", height = "700px")
    ),
    
    box(
      width = 100, status = "primary", solidHeader = TRUE, background = "blue", title="20-Year Risk for Women with First Birth", collapsible=T,
      conditionalPanel(condition = "input.parity < 1",
                       plotOutput("pred2", height = "700px")  
      ),
      conditionalPanel(condition = "input.parity >= 1",
                       h5("Not applicable for women who had previous births", style="color:Red")
      )
    ),
    p("* No model could be created and rates from the original cohort have been used.")
    
    
  )
)