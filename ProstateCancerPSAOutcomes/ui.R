#Comparing the risk of all cause mortality, prostate-cancer specific mortality, and prostate cancer diagnosis for patients screened vs. those unscreened (MODELS)
#Risk of same three evens but only patients who have previously had a PSA done (MODELS_SCREENED)

#UI file creates the layout of the app
#UI file creating the user interface
require(shiny)
require(shinythemes)
require(faceplot)


navbarPage(title = "Prostate cancer related risks",
           theme = shinytheme("darkly"),
           sidebarLayout(
             sidebarPanel(
               title = "Patient characteristics",
               
               #Switches between the two sets of models depending on this value
               radioButtons("past_screen", "Have you had a PSA?", choices = c("No", "Yes")),
              
              #Only allow user to enter PSA value if they had a prior PSA (meaning the models on only screened patients are used) 
              conditionalPanel(condition = "input.past_screen == 'Yes'",
                  numericInput("prior_psa", label = "PSA value (ng/mL)", value = 1, min = 0, max = 2000)
              ),
              
              #Inputs for the rest of the covariates
              dateInput(inputId = "dob", "Date of Birth (YYYY-MM-DD)", value = Sys.Date() - 56*365.25),
              selectInput(inputId = "ethnicity", label = "Ethnicity", choices = c("White/Non-hispanic", "Black/Non-hispanic", "Other")),
              selectInput(inputId = "cci", label = "Charlson Comorbidity Index", choices = c("0", "1", "2", "3+")),
              selectInput(inputId = "marital", label = "Marital Status", choices = c("Married", "Divorced/Separated", "Widowed", "Never married")),
              selectInput(inputId = "education", label = "Education", choices = c("Less than high school", "High school/Some college", "College graduate or more")),
              selectInput(inputId = "famhx", label = "Family History", choices = c("None", "1 family member", "2 or more family members")),
              sliderInput(inputId = "times", label = "Risk Horizon", min = 10, max = 15, value = 15)
              ),
             
             #Which output to display depending on the group of models being used (whether the first question is yes or no)
             mainPanel(
               textOutput("riskTime"),
               conditionalPanel(condition = "input.past_screen == 'No'",
                  tableOutput("riskTable"),
                  HTML('<p><img src="https://i.imgur.com/h8JEHtD.png" alt="Green smile face"/>None&nbsp;&nbsp;
                       <img src="https://i.imgur.com/rAMYIeF.png" alt="Yellow meh face"/>&nbsp;PC Diagnosis&nbsp;&nbsp;
                       <img src="https://i.imgur.com/IC22pMy.png" alt="Red sad face"/>&nbsp;All-cause mortality&nbsp;&nbsp;
                       <img src="https://i.imgur.com/cYzzd9X.png" alt="Pink frown face"/>&nbsp;PC specific mortality</p>'),
                  fluidRow(
                      column(6, 
                             div(style = "border = 6px solid", 
                                 h4("Screened"),
                                 faceplotOutput(outputId = "faceplot1"))),
                      column(6, 
                             div(style = "border = 6px solid", 
                                 h4("Not Screened"),
                                 faceplotOutput(outputId = "faceplot2")))
                      
                  )
             ),
             conditionalPanel(condition = "input.past_screen == 'Yes'",
                  tableOutput("riskTable3"),
                  HTML('<p><img src="https://i.imgur.com/h8JEHtD.png" alt="Green smile face"/>None&nbsp;&nbsp;
                       <img src="https://i.imgur.com/rAMYIeF.png" alt="Yellow meh face"/>&nbsp;PC Diagnosis&nbsp;&nbsp;
                       <img src="https://i.imgur.com/IC22pMy.png" alt="Red sad face"/>&nbsp;All-cause mortality&nbsp;&nbsp;
                       <img src="https://i.imgur.com/cYzzd9X.png" alt="Pink frown face"/>&nbsp;PC specific mortality</p>'),
                  faceplotOutput(outputId = "faceplot3")
              )
             )
             
           )
)
