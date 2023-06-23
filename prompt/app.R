#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("risk.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("PROMPT"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
      sidebarPanel(
        selectInput("race", "Race", choices = c("African Ancestry", "Other")),
        numericInput("age", "Age", 40, min = 40.0, max = 90.0),
        numericInput("psa", "PSA [ng/ml]", 2, min = 0.1, max = 50),
        selectInput("dre", "Digital rectal examination", selectize = F,
                    choices = c("Normal", "Abnormal", "Not performed or not sure")),
        selectInput("priobiop", "Prior biopsy", selectize = F,
                    choices = c("Never had a prior biopsy", "Prior negative biopsy", "Not sure")),
        selectInput("famhist", "Family History of Prostate Cancer", selectize = F,
                    choices = c("No", "Yes", "Do not know")),
        checkboxInput("prompt_exit", "Have PROMPT"),
        conditionalPanel(
          condition = "input.prompt_exit == true",
          numericInput("PROMPT", "PROMPT:", NA, min = 0.1, max = 150, step = 0.1)
        ),
        # Percent free PSA available?            
        checkboxInput("fpsa_avail", "Percent free PSA available?",value=FALSE),
        conditionalPanel("input.fpsa_avail",
                         numericInput("fpsa", "Percent free PSA", NA, min = 5, max = 75)),
        # PSA3?
        #conditionalPanel("!(input.fpsa_avail)",
        checkboxInput("pca3_avail", "PCA3 available?",value=FALSE),
        conditionalPanel("(input.pca3_avail)",
                         numericInput("pca_3", "PCA3", NA, min = 0.3, max = 332.5)),
        
        # PSA3 and T2ERG?
        #conditionalPanel("!(input.fpsa_avail)",
        checkboxInput("pca3_t2erg_avail", "T2:ERG available?",value=FALSE),
        conditionalPanel("input.pca3_t2erg_avail",
                         numericInput("t_2erg", "T2ERG",NA, min = 0.0, max = 6031.6))
        
      ),
      
      mainPanel(
        verbatimTextOutput("result")
      )
    )
)


server <- function(input, output) {
  
  output$result <- renderText({
    validate(
      need(input$age>=40 & input$age <=90, "age between 40 - 90"),
      need(input$psa <= 50 & input$psa >0, "psa between 0.1 - 50"))
    
    race = ifelse(input$race == "African Ancestry",1,0)
    famhist = ifelse(input$famhist == "Yes",1,
                     ifelse(input$famhist == "Do not know", NA, 0))
    dre = ifelse(input$dre == "Abnormal",1,
                 ifelse(input$dre == "Not performed or not sure", NA, 0))
    priobiop = ifelse(input$priobiop == "Prior negative biopsy",1,
                      ifelse(input$priobiop == "Not sure",NA,0))
    psa = input$psa
    age = input$age

    myrisk = risk(psa = psa, age=age, race=race, 
                  priorbiopsy=priobiop, dre=dre, famhistory=famhist)
    myPCPTrisk = risk_PCPT(psa=psa, pct_freePSA = input$fpsa, pca3=input$pca_3, t2erg=input$t_2erg, 
                           age=age, race=race, priorbiopsy=priobiop, dre=dre, famhistory=famhist)
    
    text = paste("PCPT: Any Cancer: ", 100 - round(myPCPTrisk[1],1), "%, High Grade Cancer: ", round(myPCPTrisk[3],1), "%", sep="")
    text = paste(text, "\n", paste("PBCG: Any Cancer: ", 100 - round(myrisk[1],1), "%, High Grade Cancer: ", round(myrisk[3],1), "%", sep=""), sep="")

    if (input$prompt_exit&!is.na(input$PROMPT)) {
      validate(need(input$PROMPT <= 150 & input$PROMPT >0, "PROMPT between 0.1 - 150"))
      Log_PROMPT = log(input$PROMPT)
      PBCG = 1- round(myrisk[1])/100

      ##### Outcome for any cancer
      Lp =-2.5676019 + 3.9791416 * PBCG + 0.70783207 * Log_PROMPT - 
        0.091167312 * max(Log_PROMPT + 1.0027246, 0)**3 + 0.17175671 * 
        max(Log_PROMPT + 0.2279146, 0)**3 - 0.080589398 * max(Log_PROMPT - 0.64859453, 0)**3
      Risk.anyCancer = 1/(1+exp(-Lp))
      
      ##### Outcome for high grade cancer
      Lp = -4.7877112 + 6.269787 * PBCG + 0.96960324 * Log_PROMPT - 
        0.25397568 * max(Log_PROMPT + 1.0027246, 0)**3 + 0.47848319 * 
        max(Log_PROMPT + 0.2279146, 0)**3 - 0.22450752 * max(Log_PROMPT - 
                                                               0.64859453, 0)**3
      Risk.highGradeCancer = 1/(1+exp(-Lp))
      
      text = paste(text, "\nPROMPT: Any Cancer: ", round(Risk.anyCancer*100, 1), "%, High Grade Cancer: ", round(Risk.highGradeCancer*100, 1), "%", sep="")
      
    }
    
    return(text)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
