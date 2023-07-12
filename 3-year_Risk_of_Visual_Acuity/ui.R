library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Risk Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Variables"),
      numericInput("Age", label = HTML("Age"), value = 70),
      
      numericInput("radial", label = HTML("Largest basal diameter (mm)"), value = 5),
      
 #     numericInput("surface.area", label = HTML(paste("Surface Area (mm", tags$sup(2),")", sep="")), value = 20),
      
      numericInput("td.fovea", label = HTML("Dose to Fovea (Gy)"), value = 20),
      
      numericInput("td.disc", label = HTML("Dose to Disc (Gy)"), value = 40),
      
      radioButtons(inputId = "VA50Worse", label = "Is the initial best corrected visual acuity 20/50 or worse?", choices = c("Yes", "No"))
      ),
  mainPanel(h1("Visual acuity of 20/200 or worse"),
            p("Probability of having visual acuity of 20/200 or worse 3 years following plaque radiation therapy is estimated to be:"),
            h4(textOutput("text1"), align="center"),
            p("This probability estimate is intended to serve as a general guide. Individual results may vary."),
            p(a("Source Code", 
                href = "https://github.com/ClevelandClinicQHS/riskcalc-website/tree/main/3-year_Risk_of_Visual_Acuity",
                style = "font-family: 'Lato','Helvetica Neue',Helvetica,Arial,sans-serif;
                      font-size: 12px;color: #2c3e50;text-align: center;text-decoration: underline;"))
            
            )
    )          
))