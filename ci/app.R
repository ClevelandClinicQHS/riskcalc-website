#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("95% confidence interval"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            selectInput("outcome", "Outcome:",
                        c("AUC", "Proportion")),
            conditionalPanel(
                condition = "input.outcome == 'AUC'",
                numericInput(inputId = "n1", label = "Sample size of cases (n1)", value = 100),
                numericInput(inputId = "n2", label = "Sample size of controls (n2)", value = 100),
                numericInput(inputId = "auc", label = "AUC", value = 0.8, min = 0, max=1, step = 0.05)
            ),
            conditionalPanel(
                condition = "input.outcome == 'Proportion'",
                numericInput(inputId = "n", label = "Sample size (n)", value = 100),
                numericInput(inputId = "p", label = "Proportion (p)", value = 0.4, min = 0, max=1, step = 0.05)
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           uiOutput("summary"),
           hr(),
           uiOutput("formula")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$summary = renderUI({
        if (input$outcome == "AUC") {
            n1 = input$n1
            n2 = input$n2
            auc = input$auc
            q1 = auc / (2 - auc)
            q2 = 2 * auc^2 / (1+auc)
            se = sqrt((auc * (1-auc)+(n1-1)*(q1-auc*auc)+(n2-1)*(q2-auc*auc))/(n1*n2))
            h4(paste("95% confidence interval is ", round(auc - qnorm(1-0.025)*se, 3), ", ", round(auc + qnorm(1-0.025)*se, 3), sep=""))
        } else if (input$outcome == "Proportion") {
            n = input$n
            p = input$p
            se = sqrt(p*(1-p)/n)
            h4(paste("95% confidence interval is ", round(p - qnorm(1-0.025)*se, 3), ", ", round(p + qnorm(1-0.025)*se, 3), sep=""))
        }
    })
    
    output$formula = renderUI({
        if (input$outcome == "AUC") {
            withMathJax(
                h4("Formula"),
                helpText('$$CI = AUC \\pm Z_{1-\\alpha/2} \\times se$$'),
                helpText('$$se = \\sqrt{\\frac{q_0 + (n_1-1)q_1 + (n_2-1)q_2}{n_1n_2}}$$'),
                helpText('$$q_0 = AUC(1-AUC) \\quad q_1 = \\frac{AUC}{2-AUC} - AUC^2 \\quad q_2 = \\frac{2AUC^2}{1+AUC}-AUC^2$$'),
                br(),
                h4("Reference"),
                p("Hanley JA, McNeil BJ. The meaning and use of the area under a receiver operating characteristic (ROC) curve. Radiology. 1982 Apr;143(1):29-36. doi: 10.1148/radiology.143.1.7063747. PMID: 7063747.")
            )
        } else if (input$outcome == "Proportion") {
            withMathJax(
                h4("Formula"),
                helpText('$$CI = p \\pm Z_{1-\\alpha/2} \\times \\sqrt{\\frac{p(1-p)}{n}}$$'),
                br(),
                h4("Reference"),
                p('Lawrence D. Brown, T. Tony Cai, Anirban DasGupta "Interval Estimation for a Binomial Proportion," Statistical Science, Statist. Sci. 16(2), 101-133, (May 2001)')
            )
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
