library(shiny)

shinyUI(pageWithSidebar(
    
    # Application title
    headerPanel("Liver Disease Frailty"),
    
    # Application input
    sidebarPanel(
        selectInput("sex", "Gender", c("Male", "Female")),
        selectInput("depression", "Depression", c("Yes", "No")),
        selectInput("livealone", "Live Alone", c("Yes", "No")),
        selectInput("loc", "Location at Time of Transplant", c("HOSPITALIZED", "NOT HOSPITALIZED")),
        selectInput("enceph", "Encephalopathy", c("Yes", "No")),
        selectInput("cad", "CAD", c("Yes", "No")),
        selectInput("dm", "Diabetes Mellitus", c("Yes", "No")),
        selectInput("pvd", "PVD", c("Yes", "No")),
        selectInput("pph", "PPH or HPS with Home Oxygen Requirement", c("Yes", "No")),
        selectInput("hosp", "Hospital admission in past 6 months", c("Yes", "No")),
        numericInput("bmi", "BMI", min=15, max = 60, value = 22),
        numericInput("hct", "HCT", min = 15, max = 60, value = 20),
        numericInput("meld", "Meld Score", min = 6, max = 43, value = 20),
        numericInput("kscore", "Karnofsky Score", min = 10, max = 90, value = 50),
        numericInput("Tbili", "Total Bilirubin", min = 0, max = 60, value = 20),
        numericInput("Right.Psoas.Density.Mean..HU.", "Right.Psoas.Density.Mean..HU.", min = 38, max = 70, value = 55),
        numericInput("Rt.and.Left.Psoas.Vol", "Rt.and.Left.Psoas.Vol", min = 0, max = 15, value = 6), 
        numericInput("Rt.and.Left.Paraspinal.Vol", "Rt.and.Left.Paraspinal.Vol", min = 0, max = 18, value = 4)
    ), 
    
    mainPanel(
        tableOutput("table")
    )
))