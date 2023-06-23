library(shiny)

shinyUI(
    fluidPage(
        # include CSS
        includeCSS("riskcalc.css"),
        # Google Analytics
        JS_google_analytics,
        
        navbarPage(
            title = "Prostate Cancer Risk Calculator", inverse = T,
            tabPanel("Home",
                     sidebarLayout(
                         sidebarPanel(
                             numericInput("Age", "Age [years]", NA, min = 40.0, max = 90.0),
                             numericInput("PSA", "PSA [ng/ml]", NA, min = 0.1, max = 50),
                             numericInput("Prompt", "Prompt", NA, min = 0.1, max = 10),
                             actionButton("calcRisk","Calculate risk", "primary",c("btn-large", "meheh")),
                             
                             bsPopover(id = "Age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "PSA", title = "PSA", content = tooltip_psa_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "Prompt", title = "Prompt", content = tooltip_prompt_en, placement = "right", trigger = "hover", options = list(container = "body"))
                         ),
                         
                         mainPanel(
                             h4("Result"),
                             br(),
                             htmlOutput("smile_en",inline = T))
                     )
            )      
        )
        #tabPanel("Map", stats_en)
    )
)
