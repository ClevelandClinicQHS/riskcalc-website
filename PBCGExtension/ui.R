library(shiny)
library(shinyWidgets)

shinyUI(
    fluidPage(
        # include CSS
        includeCSS("riskcalc.css"),

        

            title = "PBCG Risk Calculator", inverse = T,
            h2("For initial biopsy only.  Not for men with prior biopsy."),
 
                     sidebarLayout(
                         sidebarPanel(
                             radioGroupButtons(
                                 inputId = "exo",
                                 label = "Do you have ExosomeDx score?",
                                 choiceNames = c("No", "Yes"),
                                 choiceValues = c(1, 2)
                             ),
                             conditionalPanel(condition = "input.exo == 2",
                                              numericInput('exoEPI', "ExosomeDx score", 0, min = 0, max = 100.0)),
                             radioGroupButtons(
                                 inputId = "mri",
                                 label = "Do you have MRI results?",
                                 choiceNames = c("No", "Yes"),
                                 choiceValues = c(1, 2)
                             ),
                             conditionalPanel(condition = "input.mri == 2",
                                              selectInput('PIRADS', "PIRADS", choices = c("<3", "3", ">3"))),
                             selectInput("race", "Race", choices = c("","African Ancestry", "Other")),
                             numericInput("age", "Age", NA, min = 40.0, max = 90.0),
                             numericInput("psa", "PSA [ng/ml]", NA, min = 2, max = 10),
                             selectInput("dre", "Digital rectal examination", selectize = F,
                                         choices = c("", "Abnormal", "Normal", "Not performed or not sure")),
                             selectInput("famhist", "Family History of Prostate Cancer", selectize = F,
                                         choices = c("", "Yes", "No", "Do not know")),
                             
                             actionButton("calcRisk","Calculate Risk", "primary",c("btn-large", "meheh")),
                             
                             # Some tooltips for the input fields
                             bsPopover(id = "age",title= "Age", content = tooltip_age_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "psa", title = "PSA", content = tooltip_psa_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "famhist", title = "Family History", content = tooltip_famhist_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "dre", title = "Digital rectal examination", content = tooltip_dre_en, placement = "right", trigger = "hover", options = list(container = "body")),
                             bsPopover(id = "exoEPI", title ="ExoEPI", content = tooltip_exoepi_en, placement = "right", trigger = "hover", options = list(container = "body"))
                         ),
                         
                         mainPanel(
                             tabsetPanel(
                                 tabPanel("Result",
                                          br(),
                                          htmlOutput("smile_en",inline = T),
                                          HTML("<p>This risk calculator is for patients who have been deemed to be suitable candidates for biopsy by their urologist. 
                                               This means that, for instance, they have been evaluated to see if their PSA level is due to a disease other than cancer, 
                                               such having an enlarged prostate, a common problem in older men. 
                                               If you have not been evaluated by your urologist and told that you are a good candidate for biopsy, 
                                               the risk calculator will likely ovestimate your risk of having prostate cancer</p>"))
                             )
                         )
                     )   
            )
        )
