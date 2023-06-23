require(shiny)



shinyUI(
    
    pageWithSidebar(
        
        # Application title
        headerPanel(list(    
            tags$head(
                tags$style(HTML("
                            h1 {
                            color:ForestGreen;
                            }
                            "))
            ),
            "Predicting Postoperative Predischarge AIS Score")),
        
        # Sidebar
        sidebarPanel(
            h3("Risk Factors", style="color:ForestGreen"),
            
            selectInput("ASIA_Preop_Score2", "Preoperative AIS Score", choices=list("A/B", "C", "D", "E")),
            numericInput("Preop_Pain_Duration", "Preoperative Pain Duration (years)", min=0, max=100, value=0),
            selectInput("Osteomyelitis", "Osteomyelitis", choices=list("No", "Yes")),
            selectInput("Prior_spinal_surgery", "Prior Spinal Surgery", choices=list("No", "Yes")),
            selectInput("COPD", "COPD", choices=list("No", "Yes")),
            selectInput("Paresis", "Paresis", choices=list("No", "Yes")),
            sliderInput("Admission_Age", "Age (years)", min=18, max=100, value=56),
            selectInput("High_blood_pressure", "High Blood Pressure", choices=list("No", "Yes")),
            selectInput("DM", "Diabetes Mellitus", choices=list("No", "Yes"))
            
        ),
        mainPanel(
            
            plotOutput("pred1", height="1000px")
            
            
        )
    ))
