library(pmsampsize)
library(shiny)
library(shinythemes)
library(shinyBS)
library(tryCatchLog)

# Define UI for application that draws a histogram
ui <- fluidPage(
    theme = shinytheme("united"),

    # Application title
    titlePanel("Prediction model sample size"),

    sidebarLayout(
        sidebarPanel(
            selectInput("outcome", "Outcome:",
                        c("Binary" = 'binary',
                          "Time-To-Event" = "tte",
                          "Continuous" = "continuous"))
        ),

        mainPanel(
           fluidRow(
               column(4,
                      numericInput('rsquared', "Expected value of the (Cox-Snell) R-squared of the new model", 0.5, min=0, max=1, step=0.001)
                      ),
               column(4,
                      numericInput('parameters', "Number of candidate predictor parameters for potential inclusion in the new model", 10, min=1,step=1),
                      bsTooltip("parameters", "this may be larger than the number of candidate predictors, as categorical and continuous predictors often require two or more parameters to be estimated",
                                "right", options = list(container = "body"))
               ),
               column(4,
                      numericInput("shrinkage", "Level of shrinkage desired at internal validation after developing the new model", value=0.9, min=0, max=1, step=0.1)
               )
           ),
           br(),
           
           conditionalPanel(
               condition = "input.outcome == 'binary'",
               fluidRow(
                   column(4,
                          numericInput("prevalence", "Overall outcome proportion (for a prognostic model) or overall prevalence (for a diagnostic model)", value=0.2, min=0, max=1, step=0.01)
                   ),
                   column(4,
                          checkboxInput("usec", "Use C-statistic in conjunction with the expected prevalence to approximate the Cox-Snell R-squared (input of R-squared will be ignored)", value = FALSE)
                   ),
                   column(4,
                          numericInput("cstatistic", "C-statistic reported in an existing prediction model study", value=0.6, min=0.51, max=1, step=0.01)
                   ),
               )
           ),
           conditionalPanel(
               condition = "input.outcome == 'tte'",
               fluidRow(
                   column(4,
                          numericInput("rate", "Overall event rate in the population of interest", value=0.3, min=0, max=1, step=0.01),
                          bsTooltip("rate", "rate must be given in time units used for meanfup and timepoint options",
                                    "right", options = list(container = "body"))
                   ),
                   column(4,
                          numericInput("timepoint", "Timepoint of interest for prediction in follow-up", value=3, min=0, step=1),
                          bsTooltip("timepoint", "time units must be the same as given for meanfup option (e.g. years, months)",
                                    "right", options = list(container = "body"))
                   ),
                   column(4,
                          numericInput("meanfup", "Average (mean) follow-up time anticipated for individuals", value=5, min=0, step=1),
                          bsTooltip("meanfup", "time units must be the same as given for timepoint option (e.g. years, months)",
                                    "right", options = list(container = "body"))
                          )
               )
           ),
           conditionalPanel(
               condition = "input.outcome == 'continuous'",
               fluidRow(
                   column(4,
                          numericInput("intercept", "Average outcome value in the population of interest", value=1, min=0)
                   ),
                   column(4,
                          numericInput("sd", "Standard deviation (SD) of outcome values in the population", value=3, min=0, step=1)
                   ),
                   column(4,
                          numericInput("mmoe", "Multiplicative margin of error (MMOE) acceptable for calculation of the intercept", value=1.1, min=0, step=0.1)
                   )
               )
           ),
           br(),
           wellPanel(
               uiOutput("res")
           ),
           br(),
           wellPanel(
               h4("Reference"),
               HTML("Riley R D, Ensor J, Snell K I E, Harrell F E, Martin G P, Reitsma J B et al. (2020). Calculating the sample size required for developing a clinical prediction model. BMJ, m441. doi: <a href='https://www.bmj.com/content/368/bmj.m441'>10.1136/bmj.m441</a>")
           ),
           br(),
           img(src='../logo-ccf.png', style = "max-width:30%; max-height:100%;")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$res <- renderPrint({
        if (input$outcome == "binary") {
            if (input$usec == FALSE) {
                mes = tryCatch(capture.output(pmsampsize('b', rsquared = input$rsquared, parameters = input$parameters, shrinkage = input$shrinkage, prevalence = input$prevalence)),
                               error = function(e) {print(e)})
            } else {
                mes = tryCatch(capture.output(pmsampsize('b', cstatistic = input$cstatistic, parameters = input$parameters, prevalence = input$prevalence)),
                               error = function(e) {print(e)})
            }
            cat(paste("<pre>", paste(mes, collapse = "<br/>"), "</pre>", sep=""))
        }
        if (input$outcome == "tte") {
            mes = tryCatch(capture.output(pmsampsize('s', rsquared = input$rsquared, parameters = input$parameters, shrinkage = input$shrinkage, rate = input$rate, timepoint = input$timepoint, meanfup = input$meanfup)),
                           error = function(e) {print(e)})
            cat(paste("<pre>", paste(mes, collapse = "<br/>"), "</pre>", sep=""))
        }
        if (input$outcome == "continuous") {
            mes = tryCatch(capture.output(pmsampsize('c', rsquared = input$rsquared, parameters = input$parameters, shrinkage = input$shrinkage, intercept = input$intercept, sd = input$sd, mmoe = input$mmoe)),
                           error = function(e) {print(e)})
            cat(paste("<pre>", paste(mes, collapse = "<br/>"), "</pre>", sep=""))
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
