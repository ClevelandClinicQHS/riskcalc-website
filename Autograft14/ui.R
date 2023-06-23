require(shiny)



shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("Autograft 2 Year Prediction Models")),
  
  # Sidebar
  sidebarPanel(
    h3("Risk Factors"),
    
    sliderInput('AGE', "Age",  min=10, max=25, value=17),
    
    selectInput("sex", "Gender", choices=list("Female", "Male")),
    
    selectInput("ethnic2", "Race", choices=list("White", "Black/Other")),
    
    numericInput('height', "Height (in.)", 58, min=36, max=84),
    
    numericInput('weight', "Weight (lbs.)", 110, min=10, max=220),
    
    selectInput("spinj", "Sport of Injury", choices=list("Football", "Basketball", "Soccer", "Other")),
    
    selectInput("level1", "Sport Level", choices=list("Rec", "HS/College")),
    
    selectInput("lax", "High-Grade Laxity", choices=list("No", "Yes")),
    
    numericInput('MARX.t0', "Baseline MARX Score", 16, min=0, max=100),
    
    numericInput('KOOS.KRQOL.t0', "Baseline KOOS QOL Score", 40, min=0, max=100),
    
    numericInput('IKDC.raw.t0', "Baseline IKDC Score", 54, min=0, max=100)
    
  ),
  mainPanel(
    plotOutput("P.Plot", width="95%", height=800)
  )
))
