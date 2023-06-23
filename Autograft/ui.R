require(shiny)



shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel(h1("Autograft 2 Year Prediction Models")),
  
  # Sidebar
  sidebarPanel(
    h3("Risk Factors"),
    sliderInput('AGE', "Age", min=10, max=25, value=17), 
    selectInput('sex', "Gender", 
                list(
                  "Male" = "Male",
                  "Female" = "Female"
                )),
    selectInput('ethnic2', "Ethnicity", 
                list(
                  "White" = "White",
                  "Other" = "Black/Other"
                )),
    numericInput('height', "Height (in.)", 58, min=36, max=84),
    numericInput('weight', "Weight (lbs.)", 110, min=10, max=220),
    selectInput('spinj2', "Sport of Injury", 
                list(
                  "Basketball" = "Basketball",
                  "Football" = "Football",
                  "Soccer" = "Soccer",
                  "Other/None" = "None/Other"
                )),
    selectInput('level1', "Sport Level", 
                list(
                  "HS/College" = "HS/College",
                  "Rec" = "Rec"
                  )),
    selectInput('lax', "Lax",
                list(
                  "No" = "No",
                  "Yes" = "Yes"
                  )),
    numericInput('MARX.t0', "Baseline MARX Score", 16, min=0, max=16),
    numericInput('IKDC.raw.t0', "Baseline IKDC Score", 54, min=0, max=100)
  ),
  mainPanel(
    plotOutput("P.Plot", width="95%", height=800)
  )
))
