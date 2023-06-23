library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Zhi Ma Kai Men, Show Me the Password !"),
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    textInput("passwd", label = "Please Enter Your Key or Index Numbers Here", 
                value = ""),
  
  checkboxInput("iskey", label = "It is a key ?", value = TRUE)
  ),
  # Show a plot of the generated distribution
  mainPanel(
    h3(verbatimTextOutput("mykey"))
  )
))
