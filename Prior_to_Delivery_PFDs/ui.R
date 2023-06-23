require(shiny)



shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("12 and 20 Year Risk of Pelvic Floor Disorders Prior to Delivery", style = "color:ForestGreen")),
  
  # Sidebar
  sidebarPanel(
    h3("Risk Factors", style = "color:ForestGreen"),
    
    h5("Maternal Age at Delivery", style = "color:ForestGreen"),
    sliderInput('Age', NULL, min=14, max=45, value=28),  
    
    h5("Maternal Pre-Pregnancy Weight", style = "color:ForestGreen"),
    numericInput('PrepregWeight', "(kilograms)", NULL, min=38, max=130),
    h6("or"),
    numericInput('PrepregWeight.b', "(pounds)", NULL, min=83, max=286),
    
    h5("Maternal Height", style = "color:ForestGreen"),    
    numericInput('height', "(centimeters)", NULL, min=120, max=190),
    h6("or"),
    numericInput('height.ft', "(feet)", NULL, min=3, max=7),
    numericInput('height.in', "(inches)", NULL, min=0, max=12),
    
    h5("Number of Previous Births", style = "color:ForestGreen"),
    numericInput('parity', NULL, NULL, min=0, max=10),
    
    h5("Planned Route of Delivery", style = "color:ForestGreen"),
    selectInput('delmode2', NULL, choices = c("Vaginal", "C-Section")),
    
    h5("Family History of POP", style = "color:ForestGreen"),
    selectInput('FH.POP', NULL, choices = c("No", "Yes")),
    
    h5("Family History of UI", style = "color:ForestGreen"), 
    selectInput('FH.UI', NULL, choices = c("No", "Yes")),
    
    h5("Family History of FI", style = "color:ForestGreen"),
    selectInput('FH.FI', NULL, choices = c("No", "Yes")),
    
    h5("Pre-Pregnancy UI", style = "color:ForestGreen"),
    selectInput('uiprepreg', NULL, choices = list("No", "Yes")),
    
    h5("UI During Pregnancy", style = "color:ForestGreen"),
    selectInput('uiduringpreg', NULL, choices = list("No", "Yes")),
    
    h5("Estimated Infant Birthweight", style = "color:ForestGreen"),
    numericInput('BirthWeight', "(grams)", NULL, min=370, max=6000),
    h6("or"),
    numericInput('BirthWeight.p', "(pounds)", NULL, min=0, max=14),
    numericInput('BirthWeight.o', "(ounces)", NULL, min=13, max=211),
    
    h5("Estimated Infant Head Circumference", style = "color:ForestGreen"),
    numericInput('circumference', "(cm)", NULL, min=0, max=60)
        
  ),
  mainPanel(
    h2("12-Year Risk for Women with Multiple Births", style="color:Blue", align = "center"),
    plotOutput("prediction", height="700px"),
    h2("20-Year Risk for Women with First Birth", style="color:Blue", align = "center"),
    plotOutput("prediction2", height="700px")
  )
))